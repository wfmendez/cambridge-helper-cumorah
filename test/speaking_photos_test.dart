/// Speaking is a different test at each level, and Part 2 works from
/// photographs: one to describe at B1, two to compare at B2, three to choose
/// two from at C1.
library;

import 'dart:io';

import 'package:cil/cambridge.dart';
import 'package:cil/main.dart';
import 'package:cil/speaking_data.dart';
import 'package:cil/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio_falso.dart';

SpeakingPart _parte(ExamLevel level, int n) =>
    speakingPartsFor(level).firstWhere((p) => p.number == n);

/// Every photograph a level's Part 2 can show.
List<SpeakingPhoto> _fotos(ExamLevel level) => [
  for (final task in _parte(level, 2).photoTasks) ...task.photos,
];

final _imagen = find.byWidgetPredicate(
  (w) =>
      w is Image &&
      w.image is AssetImage &&
      (w.image as AssetImage).assetName.startsWith('assets/speaking/'),
);

Future<void> _speaking(
  WidgetTester tester,
  ExamLevel level, {
  double ancho = 1280,
}) async {
  SharedPreferences.setMockInitialValues({'tutorial_seen': true});
  simularAudio();
  tester.view.physicalSize = Size(ancho, 3200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final state = await AppState.open();
  await state.setGoal(level);
  await tester.pumpWidget(CilApp(state: state));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Speaking').first);
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("each level has its own four parts, with the exam's own timings", () {
    for (final level in ExamLevel.values) {
      final parts = speakingPartsFor(level);
      expect(parts.map((p) => p.number), [1, 2, 3, 4], reason: level.cefr);
      for (final p in parts) {
        final donde = '${level.cefr} Part ${p.number}';
        expect(p.variants, greaterThanOrEqualTo(4), reason: donde);
        expect(p.openers.length, greaterThanOrEqualTo(4), reason: donde);
        expect(p.tip, isNotNull, reason: donde);
        // No prompt twice within a part.
        expect({
          for (var i = 0; i < p.variants; i++) p.promptAt(i),
        }, hasLength(p.variants));
      }
    }
    // Nothing is shared between levels: the questions are written for each.
    for (final n in [1, 3, 4]) {
      final preguntas = [
        for (final level in ExamLevel.values) ..._parte(level, n).prompts,
      ];
      expect(preguntas.toSet(), hasLength(preguntas.length), reason: 'Part $n');
    }
    // B1 talks for less on the shared task; C1's discussion is the long one.
    expect(_parte(ExamLevel.b1, 3).seconds, 180);
    expect(_parte(ExamLevel.b2, 4).seconds, 240);
    expect(_parte(ExamLevel.c1, 4).seconds, 300);
    for (final level in ExamLevel.values) {
      expect(_parte(level, 2).seconds, 60);
    }
  });

  test('B1 describes one photograph, B2 compares two, C1 chooses from '
      'three', () {
    expect(_parte(ExamLevel.b1, 2).name, 'Describe a photograph');
    expect(_parte(ExamLevel.b2, 2).name, 'Long turn');
    expect(_parte(ExamLevel.c1, 2).name, 'Long turn');
    for (final (level, cuantas) in [
      (ExamLevel.b1, 1),
      (ExamLevel.b2, 2),
      (ExamLevel.c1, 3),
    ]) {
      final tasks = _parte(level, 2).photoTasks;
      expect(tasks, hasLength(6), reason: level.cefr);
      expect(tasks.every((t) => t.photos.length == cuantas), isTrue);
    }
    // C1 asks two things at once; that is the point of its long turn.
    for (final task in _parte(ExamLevel.c1, 2).photoTasks) {
      expect(task.question, contains(', and '));
    }
  });

  test('a C1 set is a B2 pair with a third picture on the same theme', () {
    final b2 = _parte(ExamLevel.b2, 2).photoTasks;
    final c1 = _parte(ExamLevel.c1, 2).photoTasks;
    for (var i = 0; i < 6; i++) {
      expect(c1[i].photos.take(2), b2[i].photos, reason: 'set $i');
      // b2-study-library and b2-study-cafe are joined by c1-study-park.
      final tema = b2[i].photos.first.file.split('-')[1];
      expect(c1[i].photos.last.file, startsWith('c1-$tema-'));
    }
  });

  test('every photograph exists, is credited, and none is left unused', () {
    final todas = {for (final level in ExamLevel.values) ..._fotos(level)};
    expect(todas, hasLength(24));
    expect(todas.map((f) => f.file).toSet(), hasLength(24));
    for (final f in todas) {
      expect(File(f.asset).existsSync(), isTrue, reason: f.asset);
      expect(f.by.trim(), isNotEmpty, reason: f.file);
      expect(f.page, startsWith('https://unsplash.com/photos/'));
    }
    // A level never shows a photograph meant for a higher one.
    expect(_fotos(ExamLevel.b1).every((f) => f.file.startsWith('b1-')), isTrue);
    expect(_fotos(ExamLevel.b2).every((f) => f.file.startsWith('b2-')), isTrue);

    final enDisco = Directory('assets/speaking')
        .listSync()
        .map((e) => e.uri.pathSegments.last)
        .toSet();
    expect(enDisco, todas.map((f) => '${f.file}.webp').toSet());
  });

  testWidgets('a B1 learner gets one photograph to describe, with its credit', (
    tester,
  ) async {
    final semantica = tester.ensureSemantics();
    await _speaking(tester, ExamLevel.b1);

    expect(find.text('Part 2 · Describe a photograph'), findsOneWidget);
    expect(find.text('Part 2 · Long turn'), findsNothing);
    expect(_imagen, findsOneWidget);
    expect(find.textContaining('Photo: '), findsOneWidget);
    expect(find.textContaining('Tell us what you can see'), findsOneWidget);
    // The label says it is a photograph, never what is in it: describing it
    // is the exercise.
    expect(find.bySemanticsLabel('Photograph. Tap to enlarge.'), findsOne);
    semantica.dispose();
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('a B2 learner gets two photographs, A and B, side by side '
      'where the card is wide enough', (tester) async {
    // A tablet: one column of wide cards.
    await _speaking(tester, ExamLevel.b2, ancho: 700);

    expect(find.text('Part 2 · Long turn'), findsOneWidget);
    expect(_imagen, findsNWidgets(2));
    expect(find.textContaining('A · Photo: '), findsOneWidget);
    expect(find.textContaining('B · Photo: '), findsOneWidget);
    expect(
      tester.getTopLeft(_imagen.at(0)).dy,
      tester.getTopLeft(_imagen.at(1)).dy,
    );
    expect(tester.getSize(_imagen.at(0)).width, greaterThan(200));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('a C1 learner gets three photographs, A, B and C, to choose two '
      'from', (tester) async {
    // Just wide enough for three in a row: one column of 708-pixel cards.
    await _speaking(tester, ExamLevel.c1, ancho: 740);

    expect(_imagen, findsNWidgets(3));
    for (final letra in ['A', 'B', 'C']) {
      expect(find.textContaining('$letra · Photo: '), findsOneWidget);
    }
    expect(find.textContaining('choose two'), findsOneWidget);
    final arriba = tester.getTopLeft(_imagen.at(0)).dy;
    expect(tester.getTopLeft(_imagen.at(1)).dy, arriba);
    expect(tester.getTopLeft(_imagen.at(2)).dy, arriba);
    expect(tester.getSize(_imagen.at(0)).width, greaterThanOrEqualTo(200));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  // A phone, and a desktop: there the grid has two columns of narrow cards,
  // so the photographs stack just as they do on the phone.
  for (final (level, cuantas) in [(ExamLevel.b2, 2), (ExamLevel.c1, 3)]) {
    for (final ancho in [360.0, 1280.0]) {
      testWidgets('${level.cefr} at ${ancho.toInt()} px: the $cuantas '
          'photographs stack, each large enough to see', (tester) async {
        await _speaking(tester, level, ancho: ancho);

        expect(_imagen, findsNWidgets(cuantas));
        for (var i = 1; i < cuantas; i++) {
          expect(
            tester.getTopLeft(_imagen.at(i)).dy,
            greaterThan(tester.getBottomLeft(_imagen.at(i - 1)).dy),
          );
        }
        expect(tester.getSize(_imagen.at(0)).width, greaterThan(250));
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox());
      });
    }
  }

  testWidgets('a photograph opens larger, with a credit that can be followed', (
    tester,
  ) async {
    await _speaking(tester, ExamLevel.b1);

    await tester.ensureVisible(_imagen);
    await tester.pumpAndSettle();
    await tester.tap(_imagen);
    await tester.pumpAndSettle();
    expect(find.byType(InteractiveViewer), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(Dialog),
        matching: find.textContaining(RegExp('Photo: .+ / Unsplash')),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.byType(InteractiveViewer), findsNothing);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });
}
