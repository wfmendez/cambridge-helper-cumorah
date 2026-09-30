import 'package:cil/cambridge.dart';
import 'package:cil/cambridge_data.dart';
import 'package:cil/b1_data.dart';
import 'package:cil/cil_extra_papers.dart';
import 'package:cil/cil_paper_b1.dart';
import 'package:cil/listening_resources.dart';
import 'package:cil/main.dart';
import 'package:cil/screens/listening_library.dart';
import 'package:cil/state.dart';
import 'package:cil/writing_data.dart';
import 'package:cil/writing_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio_falso.dart';

void main() {
  test('nine original papers have complete keys, text and explanations', () {
    final originals = cambridgePapers
        .where((p) => p.source == PaperSource.cil)
        .toList();
    expect(originals.length, 9);
    expect(originals.fold<int>(0, (n, p) => n + p.questions), 240);
    expect(
      cambridgePapers.map((p) => p.id).toSet().length,
      cambridgePapers.length,
    );
    for (final paper in originals) {
      final b1 = paper.level == ExamLevel.b1;
      final seen = <int>{};
      for (final part in paper.parts) {
        expect(part.items.length, part.questions, reason: paper.id);
        expect(part.answers.length, part.questions, reason: paper.id);
        for (var q = part.from; q <= part.to; q++) {
          expect(seen.add(q), isTrue, reason: '${paper.id}: duplicate $q');
          final item = part.itemFor(q)!;
          expect(item.explanation, isNotNull);
          expect(item.explanation!.length, greaterThan(35));
          if (b1) {
            // B1 Part 1 is five separate notices: each one is its own stem.
            // Parts 4–6 are the gapped ones.
            if (part.number == 1) {
              expect(item.stem!.length, greaterThan(60), reason: 'B1 $q');
            } else {
              expect(part.passage, isNotEmpty, reason: 'B1 $q');
            }
            if (part.number >= 4) {
              expect(part.passage, contains('($q) ___'), reason: 'B1 $q');
            }
          } else if (part.type != AnswerType.transformation &&
              part.number <= 6) {
            expect(part.passage, isNotEmpty);
            if (part.number != 5) expect(part.passage, contains('($q) ___'));
          }
          if (item.options.isNotEmpty) {
            // B1 Part 1 has three options, every other multiple choice four.
            final opciones = b1 && part.number == 1 ? 3 : 4;
            expect(item.options.toSet().length, opciones, reason: '$q');
            expect(
              'ABCD'.substring(0, opciones),
              contains(part.answers[q]),
              reason: '${paper.id}: $q',
            );
          } else if (b1 && part.type == AnswerType.choice) {
            // B1 matching and gapped text: the key is a letter listed in the
            // passage, so it can never point at an option that is not there.
            expect(part.passage, contains('${part.answers[q]}  '));
          }
        }
      }
    }
  });

  test('the B1 paper has the shape of the real B1 Reading paper', () {
    expect(cilPaperB1.level, ExamLevel.b1);
    expect(cilPaperB1.minutes, 45);
    expect(cilPaperB1.questions, 32);
    expect(cilPaperB1.maxMarks, 32);
    expect(cilPaperB1.parts.map((p) => p.questions), [5, 5, 5, 5, 6, 6]);
    // Same shape as the official sample, part by part.
    expect(
      cilPaperB1.parts.map((p) => (p.from, p.to, p.type)),
      b1Reading.parts.map((p) => (p.from, p.to, p.type)),
    );
  });

  test(
    'the newer papers mark realistic keys to full marks and blanks to zero',
    () {
      for (final paper in [...extraCilPapers, cilPaperB1]) {
        final responses = <int, String>{};
        for (final part in paper.parts) {
          for (var q = part.from; q <= part.to; q++) {
            final key = part.answers[q]!.split(' OR ').first;
            final answer = key
                .replaceAll('|', '')
                .split(RegExp(r'\s+'))
                .where((word) => word.isNotEmpty)
                .map((word) => word.split('/').first)
                .join(' ');
            responses[q] = answer;
            if (part.type == AnswerType.transformation) {
              expect(
                answer.split(' ').length,
                inInclusiveRange(2, 5),
                reason: '${paper.id}: $q',
              );
              final keyword = part
                  .itemFor(q)!
                  .stem!
                  .split('\n')[1]
                  .toLowerCase();
              expect(answer.toLowerCase().split(' '), contains(keyword));
            }
          }
        }
        final marked = markPaper(paper, responses);
        expect(
          marked.fold<int>(0, (n, p) => n + p.marks),
          paper.maxMarks,
          reason: paper.id,
        );
        expect(marked.expand((p) => p.wrong), isEmpty);
        final blank = markPaper(paper, {});
        expect(blank.fold<int>(0, (n, p) => n + p.marks), 0);
        expect(blank.expand((p) => p.wrong).length, paper.questions);
      }
    },
  );

  test(
    'new writing tasks have complete models within the actual word targets',
    () {
      expect(writingTasks.length, 22);
      expect(writingTasks.map((task) => task.id).toSet().length, 22);
      expect(extraWritingTasks.length, 8);
      for (final task in extraWritingTasks) {
        final model = writingModels[task.id]!;
        expect(
          model.words,
          inInclusiveRange(task.wordRange.$1, task.wordRange.$2),
        );
        expect(model.why.length, greaterThanOrEqualTo(3));
        expect(task.checklist, isNotEmpty);
        expect(task.title, isNotEmpty);
      }
    },
  );

  test(
    'listening catalogue uses unique direct lessons at all three levels',
    () {
      expect(listeningResources.length, 12);
      expect(listeningResources.map((r) => r.url).toSet().length, 12);
      for (final level in ExamLevel.values) {
        expect(listeningResources.where((r) => r.level == level).length, 4);
      }
      for (final resource in listeningResources) {
        final uri = Uri.parse(resource.url);
        expect(uri.scheme, 'https');
        expect(uri.host, 'learnenglish.britishcouncil.org');
        expect(uri.pathSegments.last, resource.slug);
        expect(uri.query, isEmpty);
      }
    },
  );

  for (final width in [360.0, 1280.0]) {
    testWidgets('paper filters and listening navigation at $width', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({'tutorial_seen': true});
      simularAudio();
      tester.view.physicalSize = Size(width, 1100);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(CilApp(state: await AppState.open()));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mock test').first);
      await tester.pumpAndSettle();
      final list = find
          .descendant(
            of: find.byType(ListView).first,
            matching: find.byType(Scrollable),
          )
          .first;
      final reading = find.widgetWithText(ChoiceChip, 'Reading');
      await tester.scrollUntilVisible(reading, 300, scrollable: list);
      await tester.tap(reading);
      await tester.pumpAndSettle();
      // B2 is the default goal, and B2 includes the B1 material below it.
      expect(
        find.text(
          '5 papers · 4 B2, 1 B1 · 120 questions · every answer explained',
        ),
        findsOneWidget,
      );
      expect(find.text('Cíl Paper 1 · Use of English'), findsNothing);
      final useOfEnglish = find.widgetWithText(ChoiceChip, 'Use of English');
      await tester.ensureVisible(useOfEnglish);
      await tester.pumpAndSettle();
      await tester.tap(useOfEnglish);
      await tester.pumpAndSettle();
      expect(
        find.text('4 B2 papers · 120 questions · every answer explained'),
        findsOneWidget,
      );
      expect(find.text('Cíl Paper 2 · Reading'), findsNothing);
      await tester.tap(find.text('Free listening · 12 lessons'));
      await tester.pumpAndSettle();
      expect(find.byType(ListeningLibrary), findsOneWidget);
      expect(find.text('A business interview'), findsOneWidget);
      await tester.tap(find.widgetWithText(ChoiceChip, 'C1 · 4 lessons'));
      await tester.pumpAndSettle();
      expect(find.text('A project management meeting'), findsOneWidget);
      expect(find.text('A business interview'), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    });
  }

  testWidgets('a B1 learner sees B1 papers only, without a Use of English '
      'filter that would lead nowhere', (tester) async {
    SharedPreferences.setMockInitialValues({'tutorial_seen': true});
    simularAudio();
    tester.view.physicalSize = const Size(1280, 1100);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final state = await AppState.open();
    await state.setGoal(ExamLevel.b1);
    await tester.pumpWidget(CilApp(state: state));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mock test').first);
    await tester.pumpAndSettle();
    expect(
      find.text('1 B1 paper · 32 questions · every answer explained'),
      findsOneWidget,
    );
    expect(find.text('Cíl B1 Paper 1 · Reading'), findsOneWidget);
    expect(find.text('Cíl Paper 3 · Use of English'), findsNothing);
    expect(find.widgetWithText(ChoiceChip, 'Use of English'), findsNothing);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets(
    'listening remains readable with large text and can copy a direct link',
    (tester) async {
      tester.view.physicalSize = const Size(360, 1000);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.6;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      String? copied;
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            copied = (call.arguments as Map)['text'] as String;
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      await tester.pumpWidget(
        const MaterialApp(home: ListeningLibrary(level: ExamLevel.b2)),
      );
      await tester.pumpAndSettle();
      final copy = find.byKey(
        const ValueKey('listening-copy-business-interview'),
      );
      // Wait for the lazy list to lay out the lesson before tapping it.
      // At large text sizes the introduction and filters fill a viewport.
      for (
        var attempts = 0;
        copy.hitTestable().evaluate().isEmpty && attempts < 12;
        attempts++
      ) {
        await tester.drag(find.byType(ListView), const Offset(0, -250));
        await tester.pumpAndSettle();
      }
      expect(copy.hitTestable(), findsOneWidget);
      await tester.tap(copy);
      await tester.pump();
      expect(
        copied,
        listeningResources.firstWhere((r) => r.level == ExamLevel.b2).url,
      );
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
}
