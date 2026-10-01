/// Speaking Part 2 works from photographs, and which task it is depends on
/// the level: one photograph to describe at B1, two to compare from B2.
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

/// Every photograph a level's Part 2 can show.
List<SpeakingPhoto> _fotos(ExamLevel level) => [
  for (final part in speakingPartsFor(level))
    for (final task in part.photoTasks) ...task.photos,
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
  tester.view.physicalSize = Size(ancho, 2400);
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

  test('B1 describes one photograph, B2 and C1 compare two', () {
    final b1 = speakingPartsFor(ExamLevel.b1).firstWhere((p) => p.number == 2);
    expect(b1.name, 'Describe a photograph');
    expect(b1.photoTasks, hasLength(6));
    expect(b1.photoTasks.every((t) => t.photos.length == 1), isTrue);

    for (final level in [ExamLevel.b2, ExamLevel.c1]) {
      final part = speakingPartsFor(level).firstWhere((p) => p.number == 2);
      expect(part.name, 'Long turn');
      expect(part.photoTasks, hasLength(6));
      expect(part.photoTasks.every((t) => t.photos.length == 2), isTrue);
    }

    // Only Part 2 depends on the level.
    for (final n in [1, 3, 4]) {
      expect(
        speakingPartsFor(ExamLevel.b1).firstWhere((p) => p.number == n),
        same(speakingPartsFor(ExamLevel.b2).firstWhere((p) => p.number == n)),
      );
    }
  });

  test('every photograph exists, is credited, and none is left unused', () {
    final todas = [..._fotos(ExamLevel.b1), ..._fotos(ExamLevel.b2)];
    expect(todas, hasLength(18));
    expect(todas.map((f) => f.file).toSet(), hasLength(18));
    for (final f in todas) {
      expect(File(f.asset).existsSync(), isTrue, reason: f.asset);
      expect(f.by.trim(), isNotEmpty, reason: f.file);
      expect(f.page, startsWith('https://unsplash.com/photos/'));
      // A level's photographs carry its name, so one is never shown at the
      // other level by a slip in the data.
      expect(
        f.file,
        startsWith(_fotos(ExamLevel.b1).contains(f) ? 'b1-' : 'b2-'),
      );
    }
    final enDisco = Directory('assets/speaking')
        .listSync()
        .map((e) => e.uri.pathSegments.last)
        .toSet();
    expect(enDisco, todas.map((f) => '${f.file}.webp').toSet());
  });

  test('"another prompt" always gives a different one', () {
    final part = speakingPartsFor(ExamLevel.b1)
        .firstWhere((p) => p.number == 2);
    expect(part.variants, 6);
    expect({
      for (var i = 0; i < part.variants; i++) part.promptAt(i),
    }, hasLength(6));
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

  // A phone, and a desktop: there the grid has two columns of narrow cards,
  // so the photographs stack just as they do on the phone.
  for (final ancho in [360.0, 1280.0]) {
    testWidgets('at ${ancho.toInt()} px the two photographs stack, each one '
        'large enough to see', (tester) async {
      await _speaking(tester, ExamLevel.b2, ancho: ancho);

      expect(_imagen, findsNWidgets(2));
      expect(
        tester.getTopLeft(_imagen.at(1)).dy,
        greaterThan(tester.getBottomLeft(_imagen.at(0)).dy),
      );
      expect(tester.getSize(_imagen.at(0)).width, greaterThan(250));
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    });
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
