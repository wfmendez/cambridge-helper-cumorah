import 'package:cil/cambridge.dart';
import 'package:cil/cambridge_data.dart';
import 'package:cil/cil_extra_papers.dart';
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
  test('eight original papers have complete keys, text and explanations', () {
    final originals = cambridgePapers
        .where((p) => p.source == PaperSource.cil)
        .toList();
    expect(originals.length, 8);
    expect(originals.fold<int>(0, (n, p) => n + p.questions), 208);
    expect(
      cambridgePapers.map((p) => p.id).toSet().length,
      cambridgePapers.length,
    );
    for (final paper in originals) {
      final seen = <int>{};
      for (final part in paper.parts) {
        expect(part.items.length, part.questions, reason: paper.id);
        expect(part.answers.length, part.questions, reason: paper.id);
        for (var q = part.from; q <= part.to; q++) {
          expect(seen.add(q), isTrue, reason: '${paper.id}: duplicate $q');
          final item = part.itemFor(q)!;
          expect(item.explanation, isNotNull);
          expect(item.explanation!.length, greaterThan(35));
          if (part.type != AnswerType.transformation && part.number <= 6) {
            expect(part.passage, isNotEmpty);
            if (part.number != 5) expect(part.passage, contains('($q) ___'));
          }
          if (item.options.isNotEmpty) {
            expect(item.options.toSet().length, 4);
            expect(part.answers[q], matches(RegExp(r'^[A-D]$')));
          }
        }
      }
    }
  });

  test(
    'all six new papers mark realistic keys to full marks and blanks to zero',
    () {
      for (final paper in extraCilPapers) {
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
      expect(
        find.text('4 B2 papers · 88 questions · every answer explained'),
        findsOneWidget,
      );
      expect(find.text('Cíl Paper 1 · Use of English'), findsNothing);
      await tester.tap(find.widgetWithText(ChoiceChip, 'Use of English'));
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
      await tester.scrollUntilVisible(
        find.text('Copy link').first,
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Copy link').first);
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
