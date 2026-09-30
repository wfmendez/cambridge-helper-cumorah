import 'package:cil/answer_feedback.dart';
import 'package:cil/cambridge.dart';
import 'package:cil/cambridge_data.dart';
import 'package:cil/cambridge_theme.dart';
import 'package:cil/cil_paper.dart';
import 'package:cil/cil_paper_2.dart';
import 'package:cil/main.dart';
import 'package:cil/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio_falso.dart';

void main() {
  test('every Cíl question has an explanation tied to its answer', () {
    var questions = 0;
    for (final paper in [cilPaper1, cilPaper2]) {
      for (final part in paper.parts) {
        for (var q = part.from; q <= part.to; q++) {
          expect(part.answers[q], isNotNull);
          expect(
            part.itemFor(q)?.explanation,
            isNotNull,
            reason: 'Question $q',
          );
          expect(part.itemFor(q)!.explanation!.trim(), isNotEmpty);
          questions++;
        }
      }
    }
    expect(questions, 52);
  });

  test('Cíl transformations accept complete answers within the word limit', () {
    final part = cilPaper1.parts.last;
    const answers = {
      25: 'since I last',
      26: 'is being repaired',
      27: 'suggested taking',
      28: 'should not have lent',
      29: 'such a long film',
      30: 'cannot have known',
    };
    for (final answer in answers.entries) {
      expect(answer.value.split(' ').length, inInclusiveRange(2, 5));
      expect(marksForAnswer(part, answer.key, answer.value), 2);
    }
    expect(markPaper(cilPaper1, answers).last.marks, 12);
    expect(marksForAnswer(part, 27, 'suggested that I take'), 2);
    expect(marksForAnswer(part, 27, 'suggested I should take'), 2);
    expect(marksForAnswer(part, 27, 'suggested'), 1);
    expect(marksForAnswer(part, 27, 'unsuggested takingness'), 0);
  });

  test('per-answer feedback and paper totals use the same scores', () {
    const responses = {
      1: 'A',
      2: 'B',
      24: 'prices',
      26: 'is being',
      27: 'suggested taking',
    };
    final results = markPaper(cilPaper1, responses);
    for (final result in results) {
      var score = 0;
      for (var q = result.part.from; q <= result.part.to; q++) {
        final earned = marksForAnswer(result.part, q, responses[q] ?? '')!;
        score += earned;
        expect(result.wrong.contains(q), earned < result.part.marksPerQuestion);
      }
      expect(result.marks, score);
    }
    expect(results.fold<int>(0, (sum, part) => sum + part.marks), 5);
  });

  for (final scenario in [
    (
      part: cilPaper1.parts.first,
      q: 1,
      response: ' a ',
      status: 'Correct · 1/1 mark',
    ),
    (
      part: cilPaper1.parts.first,
      q: 2,
      response: 'B',
      status: 'Not quite · 0/1 mark',
    ),
    (
      part: cilPaper1.parts.first,
      q: 3,
      response: '  ',
      status: 'Not answered · 0/1 mark',
    ),
    (
      part: cilPaper1.parts.last,
      q: 26,
      response: 'is being',
      status: 'Partly correct · 1/2 marks',
    ),
    (
      part: cilPaper2.parts.first,
      q: 31,
      response: 'B',
      status: 'Correct · 2/2 marks',
    ),
  ]) {
    testWidgets(
      '${scenario.status}: hidden until grading, readable on a phone',
      (tester) async {
        tester.view.physicalSize = const Size(360, 1000);
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = 1.6;
        addTearDown(tester.view.reset);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        final controller = TextEditingController(text: scenario.response);
        addTearDown(controller.dispose);
        Widget app(bool graded) => MaterialApp(
          theme: paperTheme(),
          home: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ExamAnswerField(
                  part: scenario.part,
                  number: scenario.q,
                  controller: controller,
                  graded: graded,
                ),
              ),
            ),
          ),
        );
        final explanation = scenario.part.itemFor(scenario.q)!.explanation!;
        await tester.pumpWidget(app(false));
        expect(find.text(explanation), findsNothing);
        expect(find.text(scenario.status), findsNothing);
        expect(find.textContaining('Answer:'), findsNothing);
        expect(
          tester.widget<TextField>(find.byType(TextField)).enabled,
          isTrue,
        );
        await tester.pumpWidget(app(true));
        await tester.pumpAndSettle();
        expect(find.text(explanation), findsOneWidget);
        expect(find.text(scenario.status), findsOneWidget);
        expect(find.textContaining('Answer:'), findsOneWidget);
        expect(
          tester.widget<TextField>(find.byType(TextField)).enabled,
          isFalse,
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'official Listening gives a review step without inventing evidence',
    (tester) async {
      final part = cambridgePapers
          .firstWhere((p) => p.id == 'b2-sp2-listening')
          .parts
          .first;
      final controller = TextEditingController(text: part.answers[1]);
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        MaterialApp(
          theme: paperTheme(),
          home: Scaffold(
            body: ExamAnswerField(
              part: part,
              number: 1,
              controller: controller,
              graded: true,
              isListening: true,
            ),
          ),
        ),
      );
      expect(find.text('Correct · 1/1 mark'), findsOneWidget);
      expect(find.textContaining('Replay this section'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('a missing answer key is never reported as correct', (
    tester,
  ) async {
    const part = ExamPart(
      number: 1,
      name: 'Unkeyed',
      from: 1,
      to: 1,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {},
    );
    final controller = TextEditingController(text: 'A');
    addTearDown(controller.dispose);
    await tester.pumpWidget(
      MaterialApp(
        theme: paperTheme(),
        home: Scaffold(
          body: ExamAnswerField(
            part: part,
            number: 1,
            controller: controller,
            graded: true,
          ),
        ),
      ),
    );
    expect(marksForAnswer(part, 1, 'A'), isNull);
    expect(find.text('Not graded'), findsOneWidget);
    expect(find.textContaining('Correct'), findsNothing);
  });

  testWidgets(
    'marking a mock reveals feedback for right, wrong and blank answers',
    (tester) async {
      SharedPreferences.setMockInitialValues({'tutorial_seen': true});
      simularAudio();
      tester.view.physicalSize = const Size(1280, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final state = await AppState.open();
      await tester.pumpWidget(CilApp(state: state));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Mock test').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text(cilPaper1.name));
      await tester.pumpAndSettle();
      final fields = find.byType(TextField);
      await tester.enterText(fields.at(0), 'A');
      await tester.enterText(fields.at(1), 'B');
      expect(find.textContaining('Correct ·'), findsNothing);
      await tester.scrollUntilVisible(find.text('Mark my answers'), 700);
      await tester.tap(find.text('Mark my answers'));
      await tester.pumpAndSettle();
      final first = find.byWidgetPredicate(
        (widget) => widget is ExamAnswerField && widget.number == 1,
      );
      await tester.scrollUntilVisible(first, -700);
      await tester.ensureVisible(first);
      await tester.pumpAndSettle();
      expect(find.text('Correct · 1/1 mark'), findsOneWidget);
      expect(find.text('Not quite · 0/1 mark'), findsOneWidget);
      expect(find.text('Not answered · 0/1 mark'), findsWidgets);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
  );
}
