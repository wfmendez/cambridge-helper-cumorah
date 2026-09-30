/// Progress, a personal goal and preferences, stored on this device.
///
/// Practice scores, drafts, names and goals do not require an account.
library;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cambridge.dart';
import 'learner_profile.dart';
import 'reminders.dart';

const _kIntentos = 'intentos_examen';
const _kPractica = 'practica_marcador';
const _kFallos = 'fallos_pendientes';
const _kBorrador = 'borrador_writing';
const _kMeta = 'target_level';
const _kTema = 'theme_mode';
const _kTutorial = 'tutorial_seen';
const _kProfile = 'learner_profile';
const _kDailyPractice = 'daily_practice';

class AppState extends ChangeNotifier {
  AppState._(this._prefs) {
    _cargar();
  }

  final SharedPreferences _prefs;

  List<Attempt> _intentos = [];

  /// Right and wrong per topic: `{'perfect': [right, wrong]}`.
  Map<String, List<int>> _practica = {};

  /// The exercises you got wrong and have not since got right.
  ///
  /// Ids rather than the exercises themselves: the exercises live in the
  /// code and change with an update, and a saved copy of one would go stale.
  /// An id that no longer exists simply drops out of the deck.
  Set<String> _fallos = {};
  LearnerProfile _profile = const LearnerProfile();
  Map<String, int> _dailyPractice = {};

  static Future<AppState> open() async {
    final prefs = await SharedPreferences.getInstance();
    return AppState._(prefs);
  }

  void _cargar() {
    _intentos = _leerIntentos();
    _intentos.sort((a, b) => b.date.compareTo(a.date));
    _practica = _leerMarcador();
    _fallos = (_prefs.getStringList(_kFallos) ?? const []).toSet();
    try {
      _profile = LearnerProfile.fromJson(
        jsonDecode(_prefs.getString(_kProfile) ?? '{}'),
      );
    } catch (_) {
      _profile = const LearnerProfile();
    }
    _dailyPractice = _readDaily(_prefs.getString(_kDailyPractice));
  }

  static Map<String, int> _readDaily(String? raw) {
    try {
      final data = jsonDecode(raw ?? '{}');
      if (data is! Map) return {};
      return {
        for (final entry in data.entries)
          if (entry.key is String &&
              RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(entry.key) &&
              DateTime.tryParse(entry.key) != null &&
              entry.value is int &&
              entry.value >= 0)
            entry.key as String: entry.value as int,
      };
    } catch (_) {
      return {};
    }
  }

  LearnerProfile get profile => _profile;

  Future<void> saveProfile(LearnerProfile profile) async {
    _profile = LearnerProfile.fromJson(profile.toJson());
    await _prefs.setString(_kProfile, jsonEncode(_profile.toJson()));
    notifyListeners();
  }

  int practiceOn(DateTime day) => _dailyPractice[dayKey(day)] ?? 0;
  int get todayQuestions => practiceOn(DateTime.now());
  bool get dailyGoalReached => todayQuestions >= profile.dailyQuestions;

  /// A missed day never erases the work already done.
  int activeDaysThisWeek(DateTime now) => List.generate(
    7,
    (i) => DateTime(now.year, now.month, now.day - i),
  ).where((day) => practiceOn(day) > 0).length;

  /// Reads tolerantly: an unreadable record is dropped rather than stopping
  /// the app from opening.
  List<Attempt> _leerIntentos() {
    final crudo = _prefs.getString(_kIntentos);
    if (crudo == null || crudo.isEmpty) return [];
    try {
      final list = jsonDecode(crudo) as List<dynamic>;
      final out = <Attempt>[];
      for (final item in list) {
        try {
          out.add(Attempt.fromJson(Map<String, dynamic>.from(item as Map)));
        } catch (_) {
          continue;
        }
      }
      return out;
    } catch (_) {
      return [];
    }
  }

  Map<String, List<int>> _leerMarcador() {
    final crudo = _prefs.getString(_kPractica);
    if (crudo == null || crudo.isEmpty) return {};
    try {
      final mapa = jsonDecode(crudo) as Map<String, dynamic>;
      return mapa.map(
        (k, v) =>
            MapEntry(k, (v as List).map((n) => (n as num).toInt()).toList()),
      );
    } catch (_) {
      return {};
    }
  }

  // ── First run ──────────────────────────────────────────────────────────────

  /// Whether the walkthrough has been shown. It appears once and then never
  /// again on its own; it stays reachable from The exam.
  bool get tutorialSeen => _prefs.getBool(_kTutorial) ?? false;

  Future<void> markTutorialSeen() async {
    await _prefs.setBool(_kTutorial, true);
    notifyListeners();
  }

  // ── Appearance ─────────────────────────────────────────────────────────────

  /// Light, dark, or whatever the phone is doing. Defaults to the phone,
  /// which is what most people want until they don't.
  ThemeMode get themeMode {
    switch (_prefs.getString(_kTema)) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  /// Cycles system → light → dark → system.
  Future<void> cycleThemeMode() async {
    final siguiente = switch (themeMode) {
      ThemeMode.system => 'light',
      ThemeMode.light => 'dark',
      ThemeMode.dark => 'system',
    };
    await _prefs.setString(_kTema, siguiente);
    notifyListeners();
  }

  // ── Target level ───────────────────────────────────────────────────────────

  /// Which certificate you are aiming at. Everything else is the same work;
  /// this only changes what the app puts in front of you first.
  ExamLevel get goal {
    final guardado = _prefs.getString(_kMeta);
    return ExamLevel.values.firstWhere(
      (n) => n.name == guardado,
      orElse: () => ExamLevel.b2,
    );
  }

  Future<void> setGoal(ExamLevel level) async {
    await _prefs.setString(_kMeta, level.name);
    notifyListeners();
    await restoreLocalReminder(profile, level.cefr);
  }

  // ── Mock tests ─────────────────────────────────────────────────────────────

  List<Attempt> get attempts => List.unmodifiable(_intentos);

  List<Attempt> attemptsFor(String paperId) =>
      _intentos.where((i) => i.paperId == paperId).toList();

  /// The latest result for a paper, so the next one has something to beat.
  Attempt? lastAttempt(String paperId) {
    final list = attemptsFor(paperId);
    return list.isEmpty ? null : list.first;
  }

  Future<void> saveAttempt(Attempt intento) async {
    _intentos.insert(0, intento);
    notifyListeners();
    await _guardarIntentos();
  }

  Future<void> deleteAttempt(String id) async {
    _intentos.removeWhere((i) => i.id == id);
    notifyListeners();
    await _guardarIntentos();
  }

  Future<void> _guardarIntentos() => _prefs.setString(
    _kIntentos,
    jsonEncode(_intentos.map((i) => i.toJson()).toList()),
  );

  // ── Practice ───────────────────────────────────────────────────────────────

  (int aciertos, int fallos) scoreFor(String theme) {
    final v = _practica[theme];
    if (v == null || v.length < 2) return (0, 0);
    return (v[0], v[1]);
  }

  double? accuracyFor(String theme) {
    final (ok, mal) = scoreFor(theme);
    final total = ok + mal;
    return total == 0 ? null : ok / total;
  }

  /// The topic with the worst rate among those already practised.
  ///
  /// Only counts from three attempts up: with one or two, the percentage says
  /// more about luck than about you.
  String? get weakestTopic {
    String? peor;
    var peorTasa = 1.1;
    for (final entrada in _practica.entries) {
      final ok = entrada.value[0];
      final mal = entrada.value.length > 1 ? entrada.value[1] : 0;
      if (ok + mal < 3) continue;
      final tasa = ok / (ok + mal);
      if (tasa < peorTasa) {
        peorTasa = tasa;
        peor = entrada.key;
      }
    }
    return peor;
  }

  /// The exercises waiting to be redone, newest mistake last.
  Set<String> get mistakes => Set.unmodifiable(_fallos);

  Future<void> recordPractice(
    String theme,
    String exerciseId,
    bool acierto,
  ) async {
    final now = DateTime.now();
    final today = dayKey(now);
    _dailyPractice[today] = (_dailyPractice[today] ?? 0) + 1;
    _dailyPractice.removeWhere(
      (day, _) => daysUntil(DateTime.parse(day), now) < -90,
    );
    final actual = _practica[theme] ?? [0, 0];
    _practica[theme] = [
      actual[0] + (acierto ? 1 : 0),
      actual[1] + (acierto ? 0 : 1),
    ];
    // Fallarlo lo mete en el mazo de repaso; acertarlo lo saca, se haya
    // fallado en esta sesión o hace una semana. Acertar es la única salida,
    // que es lo que hace que el mazo signifique algo.
    if (acierto) {
      _fallos.remove(exerciseId);
    } else {
      _fallos.add(exerciseId);
    }
    notifyListeners();
    await _prefs.setString(_kPractica, jsonEncode(_practica));
    await _prefs.setStringList(_kFallos, _fallos.toList());
    await _prefs.setString(_kDailyPractice, jsonEncode(_dailyPractice));
  }

  // ── Writing ────────────────────────────────────────────────────────────────

  /// One draft per task, saved as you type so that closing the app by
  /// accident does not cost twenty minutes of work.
  String? writingDraft(String taskId) =>
      _prefs.getString('${_kBorrador}_$taskId');

  Future<void> saveDraft(String taskId, String text) async {
    await _prefs.setString('${_kBorrador}_$taskId', text);
  }

  /// Wipes everything stored. Useful if you lend the phone, or want a clean
  /// slate before a mock you intend to take seriously.
  Future<void> clearAll() async {
    await cancelLocalReminder();
    _intentos = [];
    _practica = {};
    _fallos = {};
    _profile = const LearnerProfile();
    _dailyPractice = {};
    notifyListeners();
    await _prefs.remove(_kIntentos);
    await _prefs.remove(_kPractica);
    await _prefs.remove(_kFallos);
    await _prefs.remove(_kProfile);
    await _prefs.remove(_kDailyPractice);
    for (final clave in _prefs.getKeys().toList()) {
      if (clave.startsWith(_kBorrador)) await _prefs.remove(clave);
    }
    // El tutorial no se reabre al borrar: quien vacía sus datos ya sabe usarla.
  }

  // ── Backup ─────────────────────────────────────────────────────────────────

  /// Everything you have produced, as one block of text.
  ///
  /// There is no cloud and there is no account, which is the point of the
  /// app; the cost of that is that uninstalling deletes your work. This is
  /// the way out: copy the text somewhere you keep things — an email to
  /// yourself does the job — and it can be put back later or on another
  /// phone.
  String exportarTodo() {
    final borradores = <String, String>{};
    for (final clave in _prefs.getKeys()) {
      if (clave.startsWith(_kBorrador)) {
        borradores[clave.substring(_kBorrador.length + 1)] =
            _prefs.getString(clave) ?? '';
      }
    }
    return jsonEncode({
      'cil': 1,
      'saved': DateTime.now().toIso8601String(),
      'goal': goal.name,
      'profile': profile.toJson(),
      'dailyPractice': _dailyPractice,
      'attempts': _intentos.map((i) => i.toJson()).toList(),
      'practice': _practica,
      'mistakes': _fallos.toList(),
      'drafts': borradores,
    });
  }

  /// Puts an exported block back. Returns false if it is not one of ours.
  ///
  /// It replaces rather than merges. Merging two histories of the same mock
  /// test raises questions with no good answer — which attempt is the real
  /// one? — and a restore is almost always onto an empty phone anyway.
  Future<bool> importarTodo(String texto) async {
    Map<String, dynamic> datos;
    try {
      final leido = jsonDecode(texto.trim());
      if (leido is! Map<String, dynamic> || leido['cil'] == null) return false;
      datos = leido;
    } catch (_) {
      return false;
    }

    _intentos =
        ((datos['attempts'] as List?) ?? const [])
            .map((e) => Attempt.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date));

    final marcador = datos['practice'];
    _practica = marcador is Map
        ? marcador.map(
            (k, v) => MapEntry(
              k.toString(),
              (v as List).map((n) => (n as num).toInt()).toList(),
            ),
          )
        : <String, List<int>>{};

    _fallos = ((datos['mistakes'] as List?) ?? const [])
        .map((e) => e.toString())
        .toSet();

    await _prefs.setString(
      _kIntentos,
      jsonEncode(_intentos.map((i) => i.toJson()).toList()),
    );
    await _prefs.setString(_kPractica, jsonEncode(_practica));
    await _prefs.setStringList(_kFallos, _fallos.toList());

    final borradores = datos['drafts'];
    if (borradores is Map) {
      for (final e in borradores.entries) {
        await _prefs.setString('${_kBorrador}_${e.key}', e.value.toString());
      }
    }

    final meta = ExamLevel.values.where((l) => l.name == datos['goal']);
    // Notification permission belongs to this device, not to a backup.
    await cancelLocalReminder();
    if (meta.isNotEmpty) await setGoal(meta.first);
    await saveProfile(LearnerProfile.fromJson(datos['profile']));
    _dailyPractice = _readDaily(jsonEncode(datos['dailyPractice'] ?? {}));
    await _prefs.setString(_kDailyPractice, jsonEncode(_dailyPractice));

    notifyListeners();
    return true;
  }
}

/// Reaches the state from any widget, with no external dependencies.
class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child})
    : super(notifier: state);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'No AppScope found in the widget tree');
    return scope!.notifier!;
  }
}
