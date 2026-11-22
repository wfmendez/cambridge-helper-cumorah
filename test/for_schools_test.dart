/// The for Schools mode: a switch beside the goal, saved like the goal, that
/// changes what Speaking and Writing put in front of you and says so where
/// the material is still the general one.
library;

import 'dart:convert';

import 'package:cil/cambridge.dart';
import 'package:cil/main.dart';
import 'package:cil/speaking_data.dart';
import 'package:cil/state.dart';
import 'package:cil/writing_data.dart';
import 'package:cil/writing_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio_falso.dart';

Future<AppState> _abrir([Map<String, Object> guardado = const {}]) async {
  SharedPreferences.setMockInitialValues({'tutorial_seen': true, ...guardado});
  return AppState.open();
}

Future<AppState> _app(WidgetTester tester, {double ancho = 375}) async {
  simularAudio();
  tester.view.physicalSize = Size(ancho, 1600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final state = await _abrir();
  await tester.pumpWidget(CilApp(state: state));
  await tester.pumpAndSettle();
  return state;
}

/// Las preguntas de un test, para comparar conjuntos enteros.
List<String> _preguntas(SpeakingTest t) => [
  ...t.interview,
  ...t.discussion,
  t.diagram.question,
];

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('state', () {
    test('starts general, and the choice survives a restart', () async {
      final state = await _abrir();
      expect(state.forSchools, isFalse);
      await state.setForSchools(true);
      expect(state.forSchools, isTrue);
      final otra = await AppState.open();
      expect(otra.forSchools, isTrue);
      await otra.setForSchools(false);
      expect((await AppState.open()).forSchools, isFalse);
    });

    test('C1 has no for Schools version', () async {
      final state = await _abrir({'target_level': ExamLevel.c1.name});
      expect(ExamLevel.c1.hasSchoolsVersion, isFalse);
      // Turning the mode on at C1 moves the goal to B2.
      await state.setForSchools(true);
      expect(state.goal, ExamLevel.b2);
      expect(state.forSchools, isTrue);
      // Choosing C1 again means the general exam.
      await state.setGoal(ExamLevel.c1);
      expect(state.forSchools, isFalse);
      // A stored flag never makes C1 a for Schools exam.
      final raro = await _abrir({
        'target_level': ExamLevel.c1.name,
        'for_schools': true,
      });
      expect(raro.forSchools, isFalse);
    });

    test('names the exam you are actually sitting', () {
      expect(ExamLevel.b2.examName(schools: true), 'B2 First for Schools');
      expect(ExamLevel.b1.examName(schools: false), 'B1 Preliminary');
      expect(ExamLevel.c1.examName(schools: true), 'C1 Advanced');
    });

    test('travels with the backup', () async {
      final state = await _abrir({'target_level': ExamLevel.b1.name});
      await state.setForSchools(true);
      final copia = state.exportarTodo();
      expect(jsonDecode(copia)['forSchools'], isTrue);

      final otra = await _abrir();
      expect(await otra.importarTodo(copia), isTrue);
      expect(otra.goal, ExamLevel.b1);
      expect(otra.forSchools, isTrue);
    });
  });

  group('Speaking for Schools', () {
    test('six whole tests at B1 and at B2, in the exam format', () {
      for (final level in [ExamLevel.b1, ExamLevel.b2]) {
        final tests = speakingTestsFor(level, schools: true);
        expect(tests, hasLength(6), reason: level.cefr);
        for (final (i, t) in tests.indexed) {
          final donde = '${level.cefr} for Schools test ${i + 1}';
          expect(t.interview, hasLength(4), reason: donde);
          expect(t.discussion, hasLength(4), reason: donde);
          expect(t.diagram.options.toSet(), hasLength(5), reason: donde);
          expect(t.diagram.decision, endsWith('?'), reason: donde);
          expect(
            t.diagram.situation != null,
            level == ExamLevel.b1,
            reason: donde,
          );
          expect(
            t.photos.photos,
            hasLength(level == ExamLevel.b1 ? 1 : 2),
            reason: donde,
          );
        }
      }
    });

    test('nothing is asked twice, in either version or across them', () {
      final todas = [
        for (final level in ExamLevel.values)
          for (final schools in [false, true])
            if (!schools || level.hasSchoolsVersion)
              for (final t in speakingTestsFor(level, schools: schools))
                ..._preguntas(t),
      ];
      expect(todas.toSet(), hasLength(todas.length));
    });

    test('B2 for Schools pairs the photographs in new ways', () {
      Set<String> pareja(SpeakingTest t) =>
          t.photos.photos.map((p) => p.file).toSet();
      final generales = speakingTestsFor(ExamLevel.b2).map(pareja).toList();
      final schools = speakingTestsFor(
        ExamLevel.b2,
        schools: true,
      ).map(pareja).toList();
      for (final p in schools) {
        expect(generales.any((g) => g.containsAll(p)), isFalse, reason: '$p');
      }
      // Each of the twelve photographs once.
      expect(schools.expand((p) => p).toSet(), hasLength(12));
    });

    test('C1 asked for Schools gives the general C1, the exam that exists', () {
      expect(
        speakingTestsFor(ExamLevel.c1, schools: true),
        same(speakingTestsFor(ExamLevel.c1)),
      );
    });

    test('topics stay away from work and adult life', () {
      final palabras = RegExp(
        r'\b(company|staff|office|colleague|manager|salary|mortgage|'
        r'commute|employer)\b',
        caseSensitive: false,
      );
      for (final level in [ExamLevel.b1, ExamLevel.b2]) {
        for (final t in speakingTestsFor(level, schools: true)) {
          for (final texto in [
            ..._preguntas(t),
            ...t.diagram.options,
            t.diagram.decision,
            t.photos.question,
            if (t.diagram.situation != null) t.diagram.situation!,
          ]) {
            expect(palabras.hasMatch(texto), isFalse, reason: texto);
          }
        }
      }
    });
  });

  group('Writing for Schools', () {
    test('B2: a story and never a report; the general exam the reverse', () {
      final schools = writingTasksFor(ExamLevel.b2, schools: true);
      final general = writingTasksFor(ExamLevel.b2);
      expect(schools.any((t) => t.kind == TextType.report), isFalse);
      expect(
        schools.any((t) => t.kind == TextType.story && t.forSchools),
        isTrue,
      );
      expect(general.any((t) => t.kind == TextType.story), isFalse);
      expect(general.any((t) => t.kind == TextType.report), isTrue);
      expect(general.any((t) => t.forSchools), isFalse);
    });

    test('for Schools tasks come first, with a model answer each', () {
      for (final level in [ExamLevel.b1, ExamLevel.b2]) {
        final tasks = writingTasksFor(level, schools: true);
        expect(tasks.first.forSchools, isTrue, reason: level.cefr);
        final propias = tasks.where((t) => t.forSchools).toList();
        expect(propias.map((t) => t.part).toSet(), {1, 2}, reason: level.cefr);
        for (final t in propias) {
          final modelo = writingModels[t.id];
          expect(modelo, isNotNull, reason: t.id);
          final (low, high) = t.wordRange;
          expect(modelo!.words, inInclusiveRange(low, high), reason: t.id);
        }
      }
      // The general mode is unchanged.
      expect(writingTasksFor(ExamLevel.b1).any((t) => t.forSchools), isFalse);
    });

    test('B2 story models begin with the sentence they were given', () {
      for (final t in schoolsWritingTasks.where(
        (t) => t.kind == TextType.story,
      )) {
        expect(writingModels[t.id]!.text, startsWith(t.question));
      }
    });
  });

  group('on screen, at phone width', () {
    testWidgets('the switch hides C1, is saved, and changes Speaking', (
      tester,
    ) async {
      final state = await _app(tester);
      expect(find.text('C1 · CAE'), findsOneWidget);
      expect(find.text('General'), findsOneWidget);

      await tester.tap(find.text('for Schools'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(state.forSchools, isTrue);
      expect(find.text('C1 · CAE'), findsNothing);
      expect(find.textContaining('There is no C1'), findsOneWidget);
      // Practice is still general material, and says so.
      expect(find.text('Preparing B2 First for Schools'), findsOneWidget);
      expect(find.text('Working towards B2 First for Schools'), findsOneWidget);
      expect(
        find.textContaining('not yet for the for Schools'),
        findsOneWidget,
      );

      await tester.tap(find.text('Speaking'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('For Schools'), findsWidgets);
      expect(
        find.textContaining('Written for B2 First for Schools'),
        findsOneWidget,
      );
      final rotulo = tester
          .widget<Text>(find.textContaining(RegExp(r'^Test \d+ of ')))
          .data!;
      expect(rotulo, endsWith('of 6'));

      await tester.tap(find.text('General'));
      await tester.pumpAndSettle();
      expect(state.forSchools, isFalse);
      expect(find.text('C1 · CAE'), findsOneWidget);
      expect(
        tester.widget<Text>(find.textContaining(RegExp(r'^Test \d+ of '))).data,
        endsWith('of 12'),
      );
    });

    testWidgets('Writing labels each task and drops the B2 reports', (
      tester,
    ) async {
      final state = await _app(tester);
      await state.setForSchools(true);
      await tester.tap(find.text('Writing'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.textContaining('never a report'), findsOneWidget);
      expect(find.text('Report'), findsNothing);
      expect(find.text('Story'), findsWidgets);
      expect(find.text('General'), findsWidgets);
    });

    testWidgets('nothing overflows in for Schools mode at 1.6x text', (
      tester,
    ) async {
      simularAudio();
      tester.view.physicalSize = const Size(360, 760);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final state = await _abrir();
      await state.setForSchools(true);
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(1.6)),
          child: CilApp(state: state),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      for (final destino in ['Writing', 'Speaking', 'Mock test', 'Practice']) {
        await tester.tap(find.text(destino).last);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: destino);
      }
    });

    testWidgets('Mock tests say their papers are general ones', (tester) async {
      final state = await _app(tester);
      await state.setGoal(ExamLevel.b1);
      await state.setForSchools(true);
      await tester.tap(find.text('Mock test'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(
        find.textContaining('not yet for B1 Preliminary for Schools'),
        findsOneWidget,
      );
    });
  });
}
