import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../disposicion.dart';

import '../cambridge.dart';
import '../cambridge_data.dart';
import '../brand.dart';
import '../cambridge_guide.dart';
import '../state.dart';
import '../practice.dart';
import '../theme.dart';
import '../cambridge_theme.dart';
import '../widgets.dart';
import '../encouragement.dart';
import 'profile.dart';
import 'descargas.dart';
import 'player.dart';
import 'speaking.dart';
import 'task_types.dart';
import 'tutorial.dart';
import '../vocab_data.dart';
import 'progress.dart';
import 'vocab.dart';
import 'writing.dart';

/// Cambridge preparation: practice with explanations, mocks that mark
/// themselves, and a guide to the exam.
///
/// Five destinations in a bar at the bottom, not four tabs at the top. Writing
/// and Speaking used to be reachable only by opening Mock test and tapping the
/// right paper, which buried two of the five things the app does behind a
/// screen about something else. The bottom is also where the thumb is, and
/// this is used on a phone.
///
/// The exam guide moved to the header: it is reference material you read once
/// and come back to rarely, not somewhere you go to practise.
class EnglishScreen extends StatefulWidget {
  const EnglishScreen({super.key});

  @override
  State<EnglishScreen> createState() => _EnglishScreenState();
}

class _EnglishScreenState extends State<EnglishScreen>
    with WidgetsBindingObserver {
  int _destino = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) setState(() {});
  }

  // Una sola lista alimenta ambas formas de navegación.
  static const _destinos = [
    (Icons.school_outlined, Icons.school_rounded, 'Practice'),
    (Icons.edit_outlined, Icons.edit_rounded, 'Writing'),
    (Icons.mic_none_rounded, Icons.mic_rounded, 'Speaking'),
    (Icons.assignment_outlined, Icons.assignment_rounded, 'Mock test'),
    (Icons.insights_outlined, Icons.insights_rounded, 'Progress'),
  ];

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final amplio = MediaQuery.sizeOf(context).width >= corteAmplio;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        // La columna y el IndexedStack conservan su sitio al cambiar de ancho.
        child: Row(
          children: [
            if (amplio) ...[
              NavigationRail(
                labelType: NavigationRailLabelType.all,
                selectedIndex: _destino,
                onDestinationSelected: (i) => setState(() => _destino = i),
                destinations: [
                  for (final (icono, seleccionado, etiqueta) in _destinos)
                    NavigationRailDestination(
                      icon: Icon(icono),
                      selectedIcon: Icon(seleccionado),
                      label: Text(etiqueta),
                    ),
                ],
              ),
              const VerticalDivider(width: 1),
            ],
            Expanded(
              child: Column(
                children: [
                  Centrado(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Cabecera(
                          subtitulo: 'Cambridge certification practice',
                          trailing: _AccionesCabecera(),
                        ),
                        const SizedBox(height: 10),
                        const _GoalPicker(),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _destino,
                      children: [
                        const _Practica(),
                        WritingBody(level: state.goal),
                        const SpeakingBody(),
                        const _Simulacros(),
                        const ProgressTab(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: amplio
          ? null
          : NavigationBar(
              selectedIndex: _destino,
              onDestinationSelected: (i) => setState(() => _destino = i),
              destinations: [
                for (final (icono, seleccionado, etiqueta) in _destinos)
                  NavigationDestination(
                    icon: Icon(icono),
                    selectedIcon: Icon(seleccionado),
                    label: etiqueta,
                  ),
              ],
            ),
    );
  }
}

/// The theme switch, the way into the exam guide, and — on the web only — the
/// way to install the app properly.
class _AccionesCabecera extends StatelessWidget {
  const _AccionesCabecera();

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      // En el móvil ya la tienes instalada: el botón sobraría.
      if (kIsWeb)
        IconButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const DescargasScreen())),
          icon: const Icon(Icons.install_mobile_outlined),
          tooltip: 'Install the app',
        ),
      IconButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('The exam')),
              body: const _Guia(),
            ),
          ),
        ),
        icon: const Icon(Icons.menu_book_outlined),
        tooltip: 'How the exam works',
      ),
      const _ThemeButton(),
    ],
  );
}

/// Cycles the appearance: follow the phone, force light, force dark.
///
/// Worth having its own button rather than hiding in a settings screen: people
/// studying at night and people studying in a sunlit common room want opposite
/// things, and the same person is often both in one day.
class _ThemeButton extends StatelessWidget {
  const _ThemeButton();

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final (icono, etiqueta) = switch (state.themeMode) {
      ThemeMode.system => (Icons.brightness_auto_rounded, 'Follows the phone'),
      ThemeMode.light => (Icons.light_mode_rounded, 'Light'),
      ThemeMode.dark => (Icons.dark_mode_rounded, 'Dark'),
    };

    return IconButton(
      onPressed: state.cycleThemeMode,
      icon: Icon(icono),
      tooltip: etiqueta,
    );
  }
}

/// Which certificate you are aiming at.
///
/// It was hard-coded to C1 before, which is wrong: most people sitting this
/// are working towards B2 first, and the app should say what you are actually
/// aiming at rather than what somebody else is.
class _GoalPicker extends StatelessWidget {
  const _GoalPicker();

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        InkWell(
          onTap: () => openProfile(context),
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              'MY GOAL',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
        for (final level in ExamLevel.values)
          _GoalChip(
            level: level,
            selected: state.goal == level,
            onTap: () => state.setGoal(level),
          ),
      ],
    );
  }
}

class _GoalChip extends StatelessWidget {
  const _GoalChip({
    required this.level,
    required this.selected,
    required this.onTap,
  });

  final ExamLevel level;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colour = cambridgeReadable(colourFor(level), theme.colorScheme);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selected ? colour.withValues(alpha: 0.14) : null,
          border: Border.all(
            color: selected
                ? colour.withValues(alpha: 0.7)
                : theme.colorScheme.outlineVariant,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          level.chip,
          style: theme.textTheme.labelMedium?.copyWith(
            color: selected ? colour : theme.colorScheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ── Practice ─────────────────────────────────────────────────────────────────

class _Practica extends StatelessWidget {
  const _Practica();

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final flojo = state.weakestTopic;

    return Pagina(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        const GoalCard(),
        const SizedBox(height: 16),
        Rejilla(
          espacioFinal: false,
          children: [
            // Understand the tasks first, then drill them: Cambridge's own
            // instructions assume terms that nobody ever explains.
            ContentCard(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const TaskTypesScreen()),
              ),
              border: cambridgeRed.withValues(alpha: 0.35),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline_rounded,
                    color: cambridgeReadable(cambridgeRed, theme.colorScheme),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How the tasks work',
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Start here: what a cloze or a gapped text actually is, '
                          'with a worked example of each',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
            Builder(
              builder: (context) {
                final morado = cambridgeReadable(
                  cambridgePurple,
                  theme.colorScheme,
                );
                final cuantas = vocabForGoal(state.goal)
                    .fold<int>(0, (n, s) => n + s.entries.length);
                return ContentCard(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const VocabScreen()),
                  ),
                  border: cambridgePurple.withValues(alpha: 0.35),
                  child: Row(
                    children: [
                      Icon(Icons.menu_book_rounded, color: morado),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Word bank',
                              style: theme.textTheme.titleSmall,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$cuantas entries: the prepositions, families and '
                              'fixed phrases the paper keeps testing',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded),
                    ],
                  ),
                );
              },
            ),
            if (state.mistakes.isNotEmpty)
              Builder(
                builder: (context) {
                  final mazo = exercisesByIds(state.mistakes);
                  final oro = cambridgeReadable(cilGold, theme.colorScheme);
                  return ContentCard(
                    onTap: () =>
                        _abrirSesion(context, mazo, 'Redo your mistakes'),
                    color: cilGold.withValues(alpha: 0.09),
                    border: cilGold.withValues(alpha: 0.45),
                    child: Row(
                      children: [
                        Icon(Icons.replay_rounded, color: oro),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Redo your mistakes',
                                style: theme.textTheme.titleSmall,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                mazo.length == 1
                                    ? 'One question waiting. Get it right and it '
                                          'leaves the deck.'
                                    : '${mazo.length} questions waiting. Each one '
                                          'leaves the deck when you get it right.',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  );
                },
              ),
            ContentCard(
              onTap: () => _abrirSesion(
                context,
                exercisesForGoal(state.goal),
                'Mixed practice',
              ),
              color: cambridgeBlue.withValues(alpha: 0.07),
              border: cambridgeBlue.withValues(alpha: 0.35),
              child: Row(
                children: [
                  Icon(
                    Icons.shuffle_rounded,
                    color: cambridgeReadable(cambridgeBlue, theme.colorScheme),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mixed practice',
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'All ${exercisesForGoal(state.goal).length} items, shuffled',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
            if (flojo != null)
              Builder(
                builder: (context) {
                  final t = topics.firstWhere((t) => t.id == flojo);
                  final tasa = state.accuracyFor(flojo) ?? 0;
                  return ContentCard(
                    onTap: () => _abrirSesion(
                      context,
                      exercisesFor(flojo, goal: state.goal),
                      t.name,
                    ),
                    border: theme.colorScheme.error.withValues(alpha: 0.35),
                    child: Row(
                      children: [
                        Icon(
                          Icons.trending_down_rounded,
                          color: theme.colorScheme.error,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weakest area: ${t.name}',
                                style: theme.textTheme.titleSmall,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${(tasa * 100).round()}% correct so far',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
        Seccion(
          titulo: TituloMarcado(
            'By topic',
            color: cambridgeReadable(cambridgeRed, theme.colorScheme),
          ),
          children: [
            for (final t in topicsForGoal(state.goal))
              _TopicRow(topic: t, state: state),
          ],
        ),
      ],
    );
  }

  static void _abrirSesion(
    BuildContext context,
    List<Exercise> list,
    String title,
  ) {
    if (list.isEmpty) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => _SesionPractica(exercises: list, title: title),
      ),
    );
  }
}

class _TopicRow extends StatelessWidget {
  const _TopicRow({required this.topic, required this.state});

  final Topic topic;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final tasa = state.accuracyFor(topic.id);
    final (ok, mal) = state.scoreFor(topic.id);

    final color = cambridgeReadable(topicColour(topic.id), t.colorScheme);

    return ContentCard(
      onTap: () => _Practica._abrirSesion(
        context,
        exercisesFor(topic.id, goal: state.goal),
        topic.name,
      ),
      border: color.withValues(alpha: 0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                margin: const EdgeInsets.only(right: 10),
                color: color,
              ),
              Expanded(child: Text(topic.name, style: t.textTheme.titleSmall)),
              if (tasa != null)
                Pill(
                  '${(tasa * 100).round()}%',
                  color: tasa >= 0.8
                      ? okGreen(t.colorScheme)
                      : (tasa >= 0.5
                            ? warnAmber(t.colorScheme)
                            : t.colorScheme.error),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            topic.blurb,
            style: t.textTheme.bodySmall?.copyWith(
              color: t.colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Pill(
                '${countFor(topic.id, goal: state.goal)} items',
                color: t.colorScheme.onSurfaceVariant,
                icon: Icons.list_alt_rounded,
              ),
              if (ok + mal > 0) ...[
                const SizedBox(width: 6),
                Pill(
                  '$ok right · $mal wrong',
                  color: t.colorScheme.onSurfaceVariant,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

/// A run of exercises. Marked one at a time, with the explanation appearing
/// right after you answer — the moment where anything is actually learnt.
class _SesionPractica extends StatefulWidget {
  const _SesionPractica({required this.exercises, required this.title});

  final List<Exercise> exercises;
  final String title;

  @override
  State<_SesionPractica> createState() => _SesionPracticaState();
}

class _SesionPracticaState extends State<_SesionPractica> {
  late final List<Exercise> _lista;
  final _campo = TextEditingController();
  int _indice = 0;
  String? _respuesta;
  bool _comprobado = false;
  bool _verPista = false;
  int _aciertos = 0;
  int _streak = 0;
  bool _dailyWin = false;
  final _missed = <Exercise>[];
  final _feedbackSounds = FeedbackSounds();

  @override
  void initState() {
    super.initState();
    _lista = [...widget.exercises]..shuffle();
  }

  @override
  void dispose() {
    _campo.dispose();
    _feedbackSounds.dispose();
    super.dispose();
  }

  Exercise get _actual => _lista[_indice];
  bool get _acertado => _comprobado && _actual.accepts(_respuesta ?? '');

  Future<void> _comprobar() async {
    if (_comprobado) return;
    final dada = _actual.type == ExerciseType.choice
        ? (_respuesta ?? '')
        : _campo.text;
    if (dada.trim().isEmpty) return;
    final bien = _actual.accepts(dada);
    final state = AppScope.of(context);
    _dailyWin =
        state.profile.configured &&
        state.todayQuestions < state.profile.dailyQuestions &&
        state.todayQuestions + 1 >= state.profile.dailyQuestions;

    setState(() {
      _respuesta = dada;
      _comprobado = true;
      if (bien) _aciertos++;
      _streak = bien ? _streak + 1 : 0;
      if (!bien) _missed.add(_actual);
    });
    unawaited(
      _feedbackSounds.play(
        enabled: state.profile.sounds,
        correct: bien,
        milestone: _dailyWin || _streak == 3,
      ),
    );
    await state.recordPractice(_actual.topic, _actual.id, bien);
  }

  void _siguiente() {
    if (_indice + 1 >= _lista.length) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => _PracticeComplete(
            correct: _aciertos,
            total: _lista.length,
            missed: _missed,
          ),
        ),
      );
      return;
    }
    setState(() {
      _indice++;
      _respuesta = null;
      _comprobado = false;
      _verPista = false;
      _campo.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final e = _actual;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_indice + 1) / _lista.length,
            minHeight: 4,
          ),
        ),
      ),
      body: Pagina(
        ancho: anchoLectura,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Text(
            '${_indice + 1} of ${_lista.length} · $_aciertos right',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          ContentCard(
            child: Text(
              e.prompt,
              style: theme.textTheme.titleMedium?.copyWith(height: 1.5),
            ),
          ),
          const SizedBox(height: 16),
          if (e.type == ExerciseType.choice)
            for (final o in e.options)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _Opcion(
                  text: o,
                  elegida: _respuesta == o,
                  correct: _comprobado && e.accepts(o),
                  fallada: _comprobado && _respuesta == o && !e.accepts(o),
                  onTap: _comprobado
                      ? null
                      : () => setState(() => _respuesta = o),
                ),
              )
          else
            TextField(
              controller: _campo,
              enabled: !_comprobado,
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              maxLines: e.type == ExerciseType.transformation ? 2 : 1,
              decoration: const InputDecoration(
                labelText: 'Your answer',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _comprobar(),
            ),
          if (!_comprobado && e.hint != null) ...[
            const SizedBox(height: 10),
            if (_verPista)
              Text(
                e.hint!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontStyle: FontStyle.italic,
                ),
              )
            else
              TextButton.icon(
                onPressed: () => setState(() => _verPista = true),
                icon: const Icon(Icons.lightbulb_outline_rounded, size: 18),
                label: const Text('Hint'),
              ),
          ],
          if (_comprobado) ...[
            const SizedBox(height: 16),
            EncouragementCard(
              key: ValueKey('encouragement-$_indice'),
              title: _dailyWin
                  ? addressed(
                      'Daily goal complete',
                      AppScope.of(context).profile.name,
                    )
                  : answerEncouragement(
                      correct: _acertado,
                      index: _indice,
                      streak: _streak,
                      name: AppScope.of(context).profile.name,
                    ),
              message: _dailyWin
                  ? 'You made time for your goal today. Every attempt helped you get here.'
                  : _acertado
                  ? 'Read the explanation to make this one stick.'
                  : 'One answer does not define your ability. Read the explanation, then take the next step.',
              celebrate: _dailyWin || _acertado,
            ),
            const SizedBox(height: 12),
            Reveal(
              child: ContentCard(
                color:
                    (_acertado
                            ? okGreen(theme.colorScheme)
                            : warnAmber(theme.colorScheme))
                        .withValues(alpha: 0.08),
                border:
                    (_acertado
                            ? okGreen(theme.colorScheme)
                            : warnAmber(theme.colorScheme))
                        .withValues(alpha: 0.4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _acertado
                              ? Icons.check_circle_rounded
                              : Icons.lightbulb_outline_rounded,
                          color: _acertado
                              ? okGreen(theme.colorScheme)
                              : warnAmber(theme.colorScheme),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _acertado ? 'Correct' : 'Not quite',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    if (!_acertado) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Answer: ${e.correct}',
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                    const SizedBox(height: 10),
                    Text(
                      e.explanation,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          FilledButton(
            onPressed: _comprobado
                ? _siguiente
                : ((_respuesta != null || _campo.text.trim().isNotEmpty)
                      ? _comprobar
                      : null),
            child: Text(
              _comprobado
                  ? (_indice + 1 >= _lista.length ? 'Finish' : 'Next')
                  : 'Check',
            ),
          ),
        ],
      ),
    );
  }
}

class _PracticeComplete extends StatelessWidget {
  const _PracticeComplete({
    required this.correct,
    required this.total,
    required this.missed,
  });

  final int correct;
  final int total;
  final List<Exercise> missed;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Practice complete')),
      body: Pagina(
        ancho: anchoLectura,
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
        children: [
          EncouragementCard(
            title: sessionEncouragement(correct, total, state.profile.name),
            message:
                '$correct of $total correct. '
                '${missed.isEmpty ? 'Take a moment to enjoy what you have learned.' : 'The questions you missed are a useful guide for your next practice.'}',
            celebrate: total > 0 && correct / total >= 0.7,
          ),
          const SizedBox(height: 20),
          const GoalCard(),
          const SizedBox(height: 20),
          if (missed.isNotEmpty) ...[
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) =>
                      _SesionPractica(exercises: missed, title: 'Another try'),
                ),
              ),
              icon: const Icon(Icons.replay_rounded),
              label: Text(
                missed.length == 1
                    ? 'Try this question again'
                    : 'Try ${missed.length} questions again',
              ),
            ),
            const SizedBox(height: 10),
          ],
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back to practice'),
          ),
        ],
      ),
    );
  }
}

class _Opcion extends StatelessWidget {
  const _Opcion({
    required this.text,
    required this.elegida,
    required this.correct,
    required this.fallada,
    this.onTap,
  });

  final String text;
  final bool elegida;
  final bool correct;
  final bool fallada;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = correct
        ? okGreen(theme.colorScheme)
        : (fallada
              ? theme.colorScheme.error
              : (elegida
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline));

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withValues(
              alpha: correct || fallada || elegida ? 0.7 : 0.3,
            ),
            width: correct || fallada || elegida ? 1.6 : 1,
          ),
          color: (correct || fallada)
              ? color.withValues(alpha: 0.08)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              correct
                  ? Icons.check_circle_rounded
                  : (fallada
                        ? Icons.cancel_rounded
                        : (elegida
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_unchecked_rounded)),
              size: 19,
              color: color,
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(text, style: theme.textTheme.bodyLarge)),
          ],
        ),
      ),
    );
  }
}

// ── Simulacros ───────────────────────────────────────────────────────────────

class _Simulacros extends StatefulWidget {
  const _Simulacros();

  @override
  State<_Simulacros> createState() => _SimulacrosState();
}

class _SimulacrosState extends State<_Simulacros> {
  ExamLevel? _meta;
  ExamLevel _nivel = ExamLevel.b2;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final meta = AppScope.of(context).goal;
    // Mirar otro examen no cambia la meta de toda la app. Elegir una meta
    // nueva sí actualiza qué muestra este catálogo al volver a él.
    if (_meta != meta) {
      _meta = meta;
      _nivel = meta;
    }
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => constraints.maxWidth >= corteMedio
        ? _amplio(context)
        : _compacto(context),
  );

  Widget _amplio(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final verde = cambridgeReadable(cambridgeGreen, theme.colorScheme);
    final rojo = cambridgeReadable(cambridgeRed, theme.colorScheme);
    final nivelColor = cambridgeReadable(colourFor(_nivel), theme.colorScheme);

    // Los dos grupos comparten el mismo borde izquierdo y la misma rejilla.
    // El aviso del cuadernillo pertenece a los oficiales; no es otro bloque
    // flotante entre niveles. En móvil se conserva la lista de siempre.
    return Pagina(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
      children: [
        Text('Mock tests', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        _NotaSimulacro(
          'Choose a paper, set aside the time, and work through it as you '
          'would in the exam.',
        ),
        const SizedBox(height: 32),
        _CabeceraSimulacros(
          titulo: 'Written for Cíl',
          etiqueta: 'Text included',
          icono: Icons.check_circle_outline_rounded,
          color: verde,
        ),
        const SizedBox(height: 8),
        const _NotaSimulacro(
          'Everything you need is in the app. Original practice papers '
          'with the format and marking of the exam.',
        ),
        const SizedBox(height: 16),
        Rejilla(
          maxColumnas: 2,
          children: [
            for (final paper in cambridgePapers.where(
              (p) => p.source == PaperSource.cil,
            ))
              _FilaPrueba(paper: paper, state: state),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(height: 1),
        const SizedBox(height: 32),
        _CabeceraSimulacros(
          titulo: 'Official Cambridge papers',
          etiqueta: 'PDF needed',
          icono: Icons.picture_as_pdf_outlined,
          color: rojo,
        ),
        const SizedBox(height: 8),
        const _NotaSimulacro(
          'Work from the free Cambridge sample booklet, then enter your '
          'answers here. Each paper tells you which file to download.',
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final level in ExamLevel.values)
              ChoiceChip(
                label: Text(level.name),
                selected: _nivel == level,
                onSelected: (_) => setState(() => _nivel = level),
              ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          _nivel == ExamLevel.b2 ? 'Sample paper 2' : 'Sample paper',
          style: theme.textTheme.titleSmall?.copyWith(color: nivelColor),
        ),
        const SizedBox(height: 6),
        _NotaSimulacro(switch (_nivel) {
          ExamLevel.b1 =>
            'A shorter exam: Reading has six parts, with no separate '
                'Use of English paper.',
          ExamLevel.b2 =>
            'Reading and Use of English, Listening, Writing and Speaking '
                'for B2 First.',
          ExamLevel.c1 =>
            'A more demanding exam: Reading and Use of English has '
                'eight parts and 56 questions.',
        }),
        const SizedBox(height: 16),
        Rejilla(
          maxColumnas: 2,
          children: [
            for (final paper in papersFor(
              _nivel,
            ).where((p) => p.source == PaperSource.official))
              _FilaPrueba(paper: paper, state: state),
          ],
        ),
      ],
    );
  }

  Widget _compacto(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);

    return Pagina(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        Centrado(
          ancho: anchoLectura,
          child: ContentCard(
            color: theme.colorScheme.surfaceContainerLowest,
            child: Text(
              'Do the paper on paper, timed, exactly as in the real exam. Then '
              'type your answers in here and it marks them instantly, part by '
              'part, so you can see where the marks went.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ),
        ),
        Seccion(
          titulo: // Las dos categorías van en verde y en rojo: es la distinción que más
              // importa de esta pantalla — si puedes sentarte a hacerlo aquí o
              // necesitas el PDF de Cambridge — y en gris se perdía.
              TituloMarcado(
                'Written for Cíl · text included',
                color: cambridgeReadable(cambridgeGreen, theme.colorScheme),
              ),
          explicacion: ContentCard(
            color: cambridgeGreen.withValues(alpha: 0.06),
            border: cambridgeGreen.withValues(alpha: 0.3),
            child: Text(
              'These are ours, so the texts are in the app: you can sit them on '
              'the phone with nothing else open. Same shapes and same marks as '
              'the real thing, but not Cambridge material.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ),
          separacionIntro: 10,
          maxColumnas: 2,
          children: [
            for (final paper in cambridgePapers.where(
              (p) => p.source == PaperSource.cil,
            ))
              _FilaPrueba(paper: paper, state: state),
          ],
        ),
        Seccion(
          titulo: TituloMarcado(
            'Official Cambridge papers · PDF needed',
            color: cambridgeReadable(cambridgeRed, theme.colorScheme),
          ),
          explicacion: ContentCard(
            color: cambridgeRed.withValues(alpha: 0.06),
            border: cambridgeRed.withValues(alpha: 0.3),
            child: Text(
              'These follow Cambridge\'s own sample papers, so the texts are not '
              'here — they are free to download from Cambridge, and each paper '
              'says which file it is and where to get it. The app holds the '
              'answer key, so it still marks you.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        for (final level in ExamLevel.values)
          Seccion(
            titulo: TituloMarcado(
              switch (level) {
                ExamLevel.b1 => 'B1 Preliminary · sample paper',
                ExamLevel.b2 => 'B2 First · Sample paper 2',
                ExamLevel.c1 => 'C1 Advanced · sample paper',
              },
              // El mismo color que ya lleva la etiqueta de nivel a la derecha.
              color: cambridgeReadable(switch (level) {
                ExamLevel.b1 => cambridgeGreen,
                ExamLevel.b2 => cambridgeBlue,
                ExamLevel.c1 => cambridgePurple,
              }, theme.colorScheme),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: switch (level) {
                    ExamLevel.b1 => cambridgeGreen,
                    ExamLevel.b2 => cambridgeBlue,
                    ExamLevel.c1 => cambridgePurple,
                  }.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  level.chip,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: cambridgeReadable(switch (level) {
                      ExamLevel.b1 => cambridgeGreen,
                      ExamLevel.b2 => cambridgeBlue,
                      ExamLevel.c1 => cambridgePurple,
                    }, theme.colorScheme),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            explicacion: switch (level) {
              ExamLevel.b1 => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ContentCard(
                  color: cambridgeGreen.withValues(alpha: 0.06),
                  border: cambridgeGreen.withValues(alpha: 0.3),
                  child: Text(
                    'A shorter exam with a different shape: Reading is one paper '
                    'of six parts and there is no separate Use of English. Score '
                    '160 here and Cambridge issues a B2 certificate anyway.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.45,
                    ),
                  ),
                ),
              ),
              ExamLevel.c1 => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ContentCard(
                  color: cambridgePurple.withValues(alpha: 0.06),
                  border: cambridgePurple.withValues(alpha: 0.3),
                  child: Text(
                    'Where you are heading. Same marking, harder paper: eight '
                    'parts instead of seven and 56 questions instead of 52. '
                    'Worth one attempt after Monday, just to see the gap.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.45,
                    ),
                  ),
                ),
              ),
              _ => null,
            },
            maxColumnas: 2,
            children: [
              for (final paper in papersFor(
                level,
              ).where((p) => p.source == PaperSource.official))
                _FilaPrueba(paper: paper, state: state),
            ],
          ),
      ],
    );
  }
}

/// Las explicaciones se leen en renglones cortos, alineadas con las tarjetas.
class _NotaSimulacro extends StatelessWidget {
  const _NotaSimulacro(this.texto);

  final String texto;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerLeft,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: anchoLectura),
      child: Text(
        texto,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          height: 1.5,
        ),
      ),
    ),
  );
}

class _CabeceraSimulacros extends StatelessWidget {
  const _CabeceraSimulacros({
    required this.titulo,
    required this.etiqueta,
    required this.icono,
    required this.color,
  });

  final String titulo;
  final String etiqueta;
  final IconData icono;
  final Color color;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 12,
    runSpacing: 8,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      Text(titulo, style: Theme.of(context).textTheme.titleLarge),
      Pill(etiqueta, color: color, icon: icono),
    ],
  );
}

class _FilaPrueba extends StatelessWidget {
  const _FilaPrueba({required this.paper, required this.state});

  final ExamPaper paper;
  final AppState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ultimo = state.lastAttempt(paper.id);
    final color = cambridgeReadable(paperColour(paper.id), theme.colorScheme);
    final muestraNivel = paper.level != ExamLevel.b2;

    return ContentCard(
      border: color.withValues(alpha: 0.4),
      // Writing and Speaking cannot mark themselves, but they can be
      // practised: each opens its own screen instead of being a dead tap.
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => switch (paper.id) {
            final id when id.contains('writing') => WritingScreen(
              level: paper.level,
            ),
            final id when id.contains('speaking') => const SpeakingScreen(),
            _ => _HojaRespuestas(paper: paper),
          },
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 18,
                margin: const EdgeInsets.only(right: 10),
                color: color,
              ),
              Expanded(
                child: Text(paper.name, style: theme.textTheme.titleSmall),
              ),
              if (ultimo != null)
                Pill(
                  '${ultimo.marks}/${ultimo.maxMarks}',
                  color: ultimo.passing
                      ? okGreen(theme.colorScheme)
                      : theme.colorScheme.error,
                ),
              const Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              if (muestraNivel)
                Pill(
                  paper.level.chip,
                  color: cambridgeReadable(
                    paper.level == ExamLevel.b1
                        ? cambridgeGreen
                        : cambridgePurple,
                    theme.colorScheme,
                  ),
                  icon: paper.level == ExamLevel.b1
                      ? Icons.trending_flat_rounded
                      : Icons.trending_up_rounded,
                ),
              // Lo primero que hay que saber de un paper es si puedes
              // sentarte a hacerlo aquí mismo o necesitas el PDF de Cambridge
              // delante. Writing y Speaking no lo llevan: su propia etiqueta
              // ya dice lo mismo.
              if (paper.selfMarked)
                Pill(
                  paper.source == PaperSource.cil
                      ? 'Text included'
                      : 'PDF needed',
                  color: paper.source == PaperSource.cil
                      ? cambridgeReadable(cambridgeGreen, theme.colorScheme)
                      : cambridgeReadable(cambridgeRed, theme.colorScheme),
                  icon: paper.source == PaperSource.cil
                      ? Icons.check_circle_outline_rounded
                      : Icons.picture_as_pdf_outlined,
                ),
              Pill(
                '${paper.minutes} min',
                color: theme.colorScheme.onSurfaceVariant,
                icon: Icons.timer_outlined,
              ),
              if (paper.selfMarked)
                Pill(
                  '${paper.questions} questions · ${paper.maxMarks} marks',
                  color: theme.colorScheme.onSurfaceVariant,
                )
              else
                Pill(
                  paper.id.contains('writing')
                      ? 'Write it here'
                      : 'Practise out loud',
                  color: theme.colorScheme.tertiary,
                  icon: paper.id.contains('writing')
                      ? Icons.edit_outlined
                      : Icons.mic_none_rounded,
                ),
              if (paper.audio.isNotEmpty)
                Pill(
                  '${paper.audio.length} audio tracks',
                  color: theme.colorScheme.onSurfaceVariant,
                  icon: Icons.headphones_rounded,
                ),
            ],
          ),
          if (paper.note != null) ...[
            const SizedBox(height: 10),
            Text(
              paper.note!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The sheet where you copy up the answers from the paper.
class _HojaRespuestas extends StatefulWidget {
  const _HojaRespuestas({required this.paper});
  final ExamPaper paper;

  @override
  State<_HojaRespuestas> createState() => _HojaRespuestasState();
}

class _HojaRespuestasState extends State<_HojaRespuestas> {
  final _feedbackSounds = FeedbackSounds();
  final _campos = <int, TextEditingController>{};
  List<PartResult>? _resultado;

  /// Exam clock. Counts up from the moment the sheet opens: the point is not
  /// an alarm going off, it is knowing how long you really took against the
  /// minutes Cambridge allows.
  final _inicio = DateTime.now();
  Timer? _tic;
  Duration _transcurrido = Duration.zero;

  @override
  void initState() {
    super.initState();
    for (final p in widget.paper.parts) {
      for (var q = p.from; q <= p.to; q++) {
        _campos[q] = TextEditingController();
      }
    }
    _tic = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _resultado == null) {
        setState(() => _transcurrido = DateTime.now().difference(_inicio));
      }
    });
  }

  @override
  void dispose() {
    _tic?.cancel();
    _feedbackSounds.dispose();
    for (final c in _campos.values) {
      c.dispose();
    }
    super.dispose();
  }

  String get _reloj {
    final m = _transcurrido.inMinutes;
    final s = (_transcurrido.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  bool get _pasado => _transcurrido.inMinutes >= widget.paper.minutes;

  Map<int, String> get _respuestas =>
      _campos.map((k, v) => MapEntry(k, v.text));

  Future<void> _corregir() async {
    if (_resultado != null) return;
    final res = markPaper(widget.paper, _respuestas);
    final marks = res.fold<int>(0, (n, r) => n + r.marks);

    _tic?.cancel();
    setState(() => _resultado = res);
    unawaited(
      _feedbackSounds.play(
        enabled: AppScope.of(context).profile.sounds,
        milestone: true,
      ),
    );

    await AppScope.of(context).saveAttempt(
      Attempt(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        paperId: widget.paper.id,
        date: DateTime.now(),
        responses: _respuestas,
        marks: marks,
        maxMarks: widget.paper.maxMarks,
        minutes: _transcurrido.inMinutes,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final res = _resultado;

    // The mock paints itself with its own theme, black and white: it imitates
    // the booklet and must not follow the phone's light or dark mode.
    return Theme(
      data: paperTheme(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.paper.name),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '$_reloj / ${widget.paper.minutes}:00',
                  style: TextStyle(
                    fontFeatures: const [FontFeature.tabularFigures()],
                    fontWeight: FontWeight.w600,
                    color: _pasado ? cambridgeRed : paperGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Pagina(
          ancho: widget.paper.source == PaperSource.official
              ? anchoMenu
              : anchoLectura,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
          children: [
            if (res != null) ...[
              EncouragementCard(
                title: sessionEncouragement(
                  res.fold<int>(0, (sum, part) => sum + part.marks),
                  widget.paper.maxMarks,
                  AppScope.of(context).profile.name,
                ),
                message: 'Finishing a practice paper takes commitment. Pick one area to work on next — you can build from here.',
                celebrate:
                    res.fold<int>(0, (sum, part) => sum + part.marks) >=
                    widget.paper.maxMarks * 0.7,
              ),
              const SizedBox(height: 12),
              _Marcador(result: res, paper: widget.paper),
              const SizedBox(height: 8),
            ],
            if (widget.paper.whereToFind != null)
              Centrado(
                ancho: anchoLectura,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    border: Border.all(color: paperInk),
                    color: const Color(0xFFF4F4F0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'THE QUESTIONS ARE ON PAPER',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                          color: paperInk,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.paper.whereToFind!,
                        style: const TextStyle(color: paperInk, height: 1.5),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'This app does not reproduce Cambridge texts — it marks '
                        'you. Work from the booklet and copy your answers across, '
                        'exactly as you would onto the real answer sheet.',
                        style: TextStyle(
                          color: paperGrey,
                          fontSize: 13,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (widget.paper.faltaAudio) _SinAudio(paper: widget.paper),
            for (final part in widget.paper.parts) ...[
              TituloMarcado('Part ${part.number} · ${part.name}'),
              if (widget.paper.audio.length >= part.number)
                ListeningPlayer(
                  part: part.number,
                  file: widget.paper.audio[part.number - 1],
                ),
              if (part.blurb != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 4),
                  child: Text(
                    part.blurb!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ),
              if (part.howToAnswer != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 12, left: 4),
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                  decoration: const BoxDecoration(
                    border: Border(left: BorderSide(color: paperInk, width: 2)),
                  ),
                  child: Text(
                    part.howToAnswer!,
                    style: const TextStyle(
                      color: paperInk,
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ),
              if (part.passage != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: paperRule),
                    color: Colors.white,
                  ),
                  child: Text(
                    part.passage!,
                    style: const TextStyle(
                      color: paperInk,
                      height: 1.75,
                      fontSize: 15,
                    ),
                  ),
                ),
              Rejilla(
                maxColumnas: widget.paper.source == PaperSource.official
                    ? 3
                    : 1,
                rellenoCompacto: EdgeInsets.zero,
                children: [
                  for (var q = part.from; q <= part.to; q++)
                    _FilaPregunta(
                      number: q,
                      item: part.itemFor(q),
                      control: _campos[q]!,
                      clave: part.answers[q],
                      corregida: res != null,
                      fallada:
                          res
                              ?.firstWhere((r) => r.part == part)
                              .wrong
                              .contains(q) ??
                          false,
                      ancho: part.type == AnswerType.transformation,
                    ),
                ],
              ),
            ],
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: res == null ? _corregir : () => Navigator.pop(context),
              icon: Icon(res == null ? Icons.fact_check_outlined : Icons.done),
              label: Text(res == null ? 'Mark my answers' : 'Done'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilaPregunta extends StatelessWidget {
  const _FilaPregunta({
    required this.number,
    required this.control,
    this.item,
    required this.clave,
    required this.corregida,
    required this.fallada,
    required this.ancho,
  });

  final int number;

  /// Only Cíl's own papers carry the question itself; official ones leave it
  /// in the booklet.
  final ExamItem? item;

  final TextEditingController control;
  final String? clave;
  final bool corregida;
  final bool fallada;
  final bool ancho;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = !corregida
        ? theme.colorScheme.outlineVariant
        : (fallada ? theme.colorScheme.error : cambridgeGreen);

    final item = this.item;
    final conTexto = item?.stem != null && item!.stem != '$number';

    return Padding(
      padding: EdgeInsets.only(bottom: conTexto ? 18 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // El enunciado solo existe en los exámenes propios; en los oficiales
          // vive en el cuadernillo y aquí solo va el número.
          if (conTexto)
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 6),
              child: Text(
                item.stem!,
                style: const TextStyle(
                  color: paperInk,
                  height: 1.55,
                  fontSize: 15,
                ),
              ),
            ),
          if (item != null && item.options.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 8),
              child: Wrap(
                spacing: 14,
                runSpacing: 4,
                children: [
                  for (final (i, o) in item.options.indexed)
                    Text(
                      '${String.fromCharCode(65 + i)}  $o',
                      style: const TextStyle(color: paperInk, fontSize: 14),
                    ),
                ],
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    '$number',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: control,
                  enabled: !corregida,
                  autocorrect: false,
                  maxLines: ancho ? 2 : 1,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    isDense: true,
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color, width: 1.6),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (corregida && fallada && clave != null)
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 4),
              child: Text(
                'Answer: $clave',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cambridgeGreen,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Marcador extends StatelessWidget {
  const _Marcador({required this.result, required this.paper});

  final List<PartResult> result;
  final ExamPaper paper;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final marks = result.fold<int>(0, (n, r) => n + r.marks);
    final fraction = paper.maxMarks == 0 ? 0.0 : marks / paper.maxMarks;
    final color = fraction >= 0.6 ? cambridgeGreen : theme.colorScheme.error;

    return ContentCard(
      border: color.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$marks',
                style: theme.textTheme.displaySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'of ${paper.maxMarks}  ·  ${(fraction * 100).round()}%',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ProgressBar(value: fraction, color: color, height: 8),
          const SizedBox(height: 16),
          for (final r in result)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 52,
                    child: Text(
                      'Part ${r.part.number}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ProgressBar(
                      value: r.fraction,
                      color: r.fraction >= 0.6
                          ? cambridgeGreen
                          : cambridgeOrange,
                      height: 6,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${r.marks}/${r.part.maxMarks}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 6),
          Text(
            'Around 60% is the usual pass mark for B2 First. The official '
            'conversion to the Cambridge English Scale is not linear, so treat '
            'this as a guide.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Guide ────────────────────────────────────────────────────────────────────

class _Guia extends StatelessWidget {
  const _Guia();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Pagina(
      ancho: anchoLectura,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        const TarjetaTutorial(),
        for (final (i, bloque) in cambridgeGuide.indexed) ...[
          TituloMarcado(
            bloque.title,
            trailing: Container(
              width: 26,
              height: 3,
              color: cambridgeReadable(
                cambridgePalette[i % cambridgePalette.length],
                theme.colorScheme,
              ),
            ),
          ),
          for (final s in bloque.sections)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ContentCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.title, style: theme.textTheme.titleSmall),
                    const SizedBox(height: 8),
                    Text(
                      s.body,
                      style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                    ),
                    if (s.points.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      for (final p in s.points)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 7),
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: cambridgeReadable(
                                      cambridgePalette[i %
                                          cambridgePalette.length],
                                      theme.colorScheme,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  p,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                    height: 1.45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ],
    );
  }
}

/// Says plainly that a Listening paper has no recording in the app.
///
/// The alternative was to leave the sheet looking broken: numbered gaps, no
/// play button and no explanation. Cambridge publishes these recordings free
/// on its own site but does not allow anyone to pass them on, so the honest
/// thing is to say where they are.
class _SinAudio extends StatelessWidget {
  const _SinAudio({required this.paper});

  final ExamPaper paper;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F1EA),
        border: Border.all(color: paperGrey.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.headset_off_rounded, size: 18, color: paperInk),
              SizedBox(width: 8),
              Text(
                'The recording is not in the app',
                style: TextStyle(
                  color: paperInk,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Cambridge gives this audio away on its own site, but only from '
            'there. Download it once, play it from your phone, and type your '
            'answers in here to be marked.',
            style: TextStyle(color: paperGrey, fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 10),
          SelectableText(
            paper.audioFrom!,
            style: const TextStyle(color: paperInk, fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 6),
          OutlinedButton.icon(
            onPressed: () =>
                copyToClipboard(context, paper.audioFrom!, 'Address copied'),
            icon: const Icon(Icons.copy_rounded, size: 16),
            label: const Text('Copy the address'),
          ),
        ],
      ),
    );
  }
}
