import 'dart:async';
import 'dart:convert';

import 'package:cil/cambridge.dart';
import 'package:cil/screens/writing.dart';
import 'package:cil/screens/writing_feedback.dart';
import 'package:cil/state.dart';
import 'package:cil/writing_data.dart';
import 'package:cil/writing_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

const draft =
    'I think students learn better with a teacher because they can ask questions. '
    'Online lessons are cheaper, but it is easy to lose attention. Working with classmates '
    'also helps me understand difficult ideas.';

Map<String, dynamic> response() => {
  'summary': 'Develop the argument about cost.',
  'criteria': [
    for (final name in [
      'Content',
      'Communicative Achievement',
      'Organisation',
      'Language',
    ])
      {'name': name, 'score': 3, 'reason': 'Clear but brief.'},
  ],
  'strengths': ['Your position is clear.'],
  'improvements': ['Add an example.'],
  'corrections': [
    {
      'original': 'Online lessons are cheaper',
      'replacement': 'Online lessons usually cost less',
      'explanation': 'This is an alternative wording.',
    },
  ],
  'correctedText': draft,
  'provider': 'Groq',
};

Map<String, dynamic> fueraDeTema() => response()
  ..['taskResponse'] = {
    'relevance': 'off-task',
    'points': [
      {'point': 'Describe the food', 'status': 'missing', 'evidence': ''},
      {
        'point': 'Say which way of learning works better',
        'status': 'partly',
        'evidence': 'students learn better with a teacher',
      },
    ],
    'redirect': {
      'explanation': 'The task asks about a restaurant; this is about a film.',
      'plan': [
        'Name the place and who you went with.',
        'Describe the food and the atmosphere.',
        'Say whether you would recommend it.',
      ],
      'opening': 'Last Friday my brother and I had dinner at a small place.',
    },
  };

/// La pantalla de revisión entera, en una ventana lo bastante alta para que la
/// lista construya todo sin tener que hacer scroll.
Future<void> revision(WidgetTester tester, Map<String, dynamic> data) async {
  tester.view.physicalSize = const Size(900, 5000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final state = await AppState.open();
  await tester.pumpWidget(
    AppScope(
      state: state,
      child: MaterialApp(
        home: WritingFeedbackScreen(
          feedback: WritingFeedback.fromJson(data),
          original: draft,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

WritingReviewClient client(Future<http.Response> Function(http.Request) send) =>
    WritingReviewClient(
      client: MockClient(send),
      endpoint: Uri.parse('https://example.test/api/writing-review'),
    );

Future<AppState> editor(
  WidgetTester tester,
  WritingReviewClient reviewClient,
) async {
  tester.view.physicalSize = const Size(1000, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final state = await AppState.open();
  await tester.pumpWidget(
    AppScope(
      state: state,
      child: MaterialApp(
        home: WritingEditor(
          task: writingTasksFor(ExamLevel.b2).first,
          reviewClient: reviewClient,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return state;
}

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test(
    'client sends only the selected task and draft, and parses UTF-8 feedback',
    () async {
      final api = client((request) async {
        expect(request.headers['x-cil-review'], '1');
        expect(jsonDecode(request.body), {
          'taskId': 'b2-p1-tech',
          'text': draft,
        });
        final data = response()..['summary'] = 'Use “although” carefully.';
        return http.Response.bytes(utf8.encode(jsonEncode(data)), 200);
      });
      addTearDown(api.close);
      expect(
        (await api.review('b2-p1-tech', draft)).summary,
        'Use “although” carefully.',
      );
    },
  );

  test(
    'invalid scores, criteria and non-JSON responses are rejected',
    () async {
      for (final data in [
        response()
          ..['criteria'] = [
            {'name': 'Content', 'score': 8, 'reason': 'Invalid'},
          ],
        response()..['criteria'] = [],
        '<html>Error</html>',
      ]) {
        final api = client(
          (_) async =>
              http.Response(data is String ? data : jsonEncode(data), 200),
        );
        await expectLater(
          api.review('b2-p1-tech', draft),
          throwsA(isA<WritingReviewException>()),
        );
        api.close();
      }
    },
  );

  test('the task response is read, and losing it costs only that section', () {
    final leida = WritingFeedback.fromJson(fueraDeTema()).taskResponse!;
    expect(leida.relevance, TaskRelevance.offTask);
    expect(leida.points.map((p) => p.status), [
      PointStatus.missing,
      PointStatus.partly,
    ]);
    expect(leida.redirect.plan, hasLength(3));
    expect(leida.redirect.isEmpty, isFalse);

    // Un servidor anterior no la manda; uno futuro podría cambiarla.
    for (final data in [
      response(),
      response()..['taskResponse'] = {'relevance': 'maybe'},
    ]) {
      final feedback = WritingFeedback.fromJson(data);
      expect(feedback.taskResponse, isNull);
      expect(feedback.summary, 'Develop the argument about cost.');
    }
  });

  testWidgets('an off-task answer leads with the task and a way back to it', (
    tester,
  ) async {
    await revision(tester, fueraDeTema());

    expect(find.text('Did it answer the task?'), findsOneWidget);
    expect(find.text('Not yet — it answers a different question.'), findsOne);
    expect(find.text('Missing'), findsOneWidget);
    expect(
      find.text('Partly · “students learn better with a teacher”'),
      findsOneWidget,
    );
    expect(find.text('How it could answer the task'), findsOneWidget);
    expect(find.text('Describe the food and the atmosphere.'), findsOneWidget);
    expect(
      find.text('Last Friday my brother and I had dinner at a small place.'),
      findsOneWidget,
    );
    expect(find.textContaining('does not make it answer the task'), findsOne);

    // Antes que las notas: es lo primero que hay que leer.
    expect(
      tester.getTopLeft(find.text('Did it answer the task?')).dy,
      lessThan(tester.getTopLeft(find.text('Content · 3/5')).dy),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('an answer on task says so and suggests no detour', (
    tester,
  ) async {
    await revision(
      tester,
      response()
        ..['taskResponse'] = {
          'relevance': 'on-task',
          'points': [
            {
              'point': 'Say which way of learning works better',
              'status': 'covered',
              'evidence': 'students learn better with a teacher',
            },
          ],
          'redirect': {'explanation': '', 'plan': [], 'opening': ''},
        },
    );
    expect(find.text('Yes — it answers the task.'), findsOneWidget);
    expect(find.text('How it could answer the task'), findsNothing);
    expect(find.textContaining('This fixes the English'), findsNothing);
  });

  testWidgets('a review from an older server looks as it did before', (
    tester,
  ) async {
    await revision(tester, response());
    expect(find.text('Did it answer the task?'), findsNothing);
    expect(find.text('Content · 3/5'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test(
    'rate limits, connection errors and timeouts have useful messages',
    () async {
      final cases = <(Future<http.Response> Function(http.Request), String)>[
        (
          (_) async => http.Response('private upstream details', 429),
          'wait a few minutes',
        ),
        (
          (_) async => throw http.ClientException('network'),
          'internet connection',
        ),
        ((_) async => throw TimeoutException('timeout'), 'took too long'),
      ];
      for (final (send, message) in cases) {
        final api = client(send);
        await expectLater(
          api.review('b2-p1-tech', draft),
          throwsA(
            isA<WritingReviewException>().having(
              (e) => e.message,
              'message',
              contains(message),
            ),
          ),
        );
        api.close();
      }
    },
  );

  testWidgets(
    'review is opt-in, shows feedback, caches it and preserves the original',
    (tester) async {
      var calls = 0;
      final pending = Completer<http.Response>();
      final state = await editor(
        tester,
        client((_) {
          calls++;
          return pending.future;
        }),
      );
      expect(
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Review my writing'),
            )
            .onPressed,
        isNull,
      );
      await tester.enterText(find.byType(TextField), draft);
      await tester.pump();
      expect(calls, 0);
      await tester.tap(find.text('Review my writing'));
      await tester.pump();
      expect(calls, 1);
      expect(find.text('Reviewing your writing…'), findsOneWidget);
      expect(tester.widget<TextField>(find.byType(TextField)).readOnly, isTrue);
      pending.complete(http.Response(jsonEncode(response()), 200));
      await tester.pumpAndSettle();
      expect(find.byType(WritingFeedbackScreen), findsOneWidget);
      expect(find.text('Practice estimate · 12/20'), findsOneWidget);
      Navigator.of(tester.element(find.byType(WritingFeedbackScreen))).pop();
      await tester.pumpAndSettle();
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        draft,
      );
      expect(state.writingDraft('b2-p1-tech'), draft);
      await tester.tap(find.text('View my review'));
      await tester.pumpAndSettle();
      expect(calls, 1);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('an error keeps the draft and offers another request', (
    tester,
  ) async {
    var calls = 0;
    await editor(
      tester,
      client((_) async {
        calls++;
        return http.Response('', 503);
      }),
    );
    await tester.enterText(find.byType(TextField), draft);
    await tester.pump();
    await tester.tap(find.text('Review my writing'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Your draft is safe.'), findsOneWidget);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      draft,
    );
    await tester.tap(find.text('Review my writing'));
    await tester.pumpAndSettle();
    expect(calls, 2);
  });

  testWidgets('leaving immediately saves the last keystrokes', (tester) async {
    final state = await editor(
      tester,
      client((_) async => throw StateError('Must not send')),
    );
    await tester.enterText(find.byType(TextField), 'Last unsaved words');
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(state.writingDraft('b2-p1-tech'), 'Last unsaved words');
  });

  testWidgets(
    'B1 has real tasks, the correct word target and a usable small editor',
    (tester) async {
      final b1 = writingTasksFor(ExamLevel.b1);
      expect(
        b1.map((t) => t.kind),
        containsAll([TextType.email, TextType.article, TextType.story]),
      );
      expect(b1.first.wordTarget, 'about 100 words');
      tester.view.physicalSize = const Size(360, 740);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final state = await AppState.open();
      await tester.pumpWidget(
        AppScope(
          state: state,
          child: MaterialApp(
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.4)),
              child: child!,
            ),
            home: WritingEditor(task: b1.first),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('words · aim for about 100 words'), findsOneWidget);
      expect(tester.getSize(find.byType(TextField)).height, greaterThan(40));
      expect(tester.takeException(), isNull);
    },
  );
}
