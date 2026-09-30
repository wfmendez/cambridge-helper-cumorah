import 'dart:convert';

import 'package:cil/cambridge.dart';
import 'package:cil/encouragement.dart';
import 'package:cil/learner_profile.dart';
import 'package:cil/main.dart';
import 'package:cil/motivation_art.dart';
import 'package:cil/screens/profile.dart';
import 'package:cil/state.dart';
import 'package:cil/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio_falso.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    SharedPreferences.setMockInitialValues({'tutorial_seen': true});
    simularAudio();
  });

  test(
    'profile and daily attempts survive restart, backup, and reset',
    () async {
      final state = await AppState.open();
      await state.saveProfile(
        LearnerProfile(
          name: '  María  ',
          reason: 'For university',
          targetDate: DateTime(2027, 6, 5),
          dailyQuestions: 10,
          sounds: true,
          effects: false,
          reminderHour: 7,
          reminderMinute: 30,
          configured: true,
        ),
      );
      await state.recordPractice('passive', 'b1-pa-1', false);
      await state.recordPractice('passive', 'b1-pa-1', true);
      final reopened = await AppState.open();
      expect(reopened.profile.name, 'María');
      expect(reopened.profile.targetDate, DateTime(2027, 6, 5));
      expect(reopened.profile.sounds, true);
      expect(reopened.profile.effects, false);
      expect(reopened.todayQuestions, 2);
      expect(reopened.activeDaysThisWeek(DateTime.now()), 1);
      final backup = reopened.exportarTodo();
      await reopened.clearAll();
      expect(reopened.profile.name, isEmpty);
      expect(reopened.todayQuestions, 0);
      expect(await reopened.importarTodo(backup), true);
      expect(reopened.profile.reason, 'For university');
      expect(reopened.profile.reminderMinute, 30);
      expect(reopened.todayQuestions, 2);
    },
  );

  test('old backups and malformed preferences remain usable', () async {
    SharedPreferences.setMockInitialValues({
      'learner_profile': '{broken',
      'daily_practice': jsonEncode({'bad-date': 4, '2026-01-01': -5}),
    });
    final state = await AppState.open();
    expect(state.profile.dailyQuestions, 5);
    expect(state.todayQuestions, 0);
    expect(
      await state.importarTodo(
        jsonEncode({'cil': 1, 'goal': 'B1 Preliminary'}),
      ),
      true,
    );
    expect(state.goal, ExamLevel.b1);
    expect(state.profile.name, '');
    final profile = LearnerProfile.fromJson({
      'name': List.filled(90, 'a').join(),
      'dailyQuestions': 0,
      'reminderHour': 99,
      'targetDate': 'oops',
    });
    expect(profile.name.length, 32);
    expect(profile.dailyQuestions, 5);
    expect(profile.reminderHour, 18);
    expect(profile.targetDate, isNull);
  });

  test(
    'daily counts reset at the calendar boundary without losing history',
    () async {
      final now = DateTime.now();
      final yesterday = DateTime(now.year, now.month, now.day - 1);
      SharedPreferences.setMockInitialValues({
        'daily_practice': jsonEncode({dayKey(yesterday): 8}),
      });
      final state = await AppState.open();
      expect(state.todayQuestions, 0);
      expect(state.practiceOn(yesterday), 8);
      await state.recordPractice('passive', 'b1-pa-1', false);
      expect(state.todayQuestions, 1);
      expect(state.activeDaysThisWeek(now), 2);
      expect(
        daysUntil(DateTime(2026, 11, 1), DateTime(2026, 10, 31, 23, 59)),
        1,
      );
    },
  );

  for (final width in [360.0, 1280.0]) {
    testWidgets('profile saves a personal goal at $width with larger text', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.6;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final state = await AppState.open();
      await tester.pumpWidget(
        AppScope(
          state: state,
          child: MaterialApp(
            theme: lightTheme(),
            home: Builder(
              builder: (context) => Scaffold(
                body: TextButton(
                  onPressed: () => openProfile(context),
                  child: const Text('Open profile'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open profile'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(0), 'Ana');
      await tester.ensureVisible(find.text('C1 Advanced'));
      await tester.tap(find.text('C1 Advanced'));
      await tester.enterText(find.byType(TextField).at(1), 'Study abroad');
      await tester.scrollUntilVisible(
        find.text('10 questions'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('10 questions'));
      await tester.scrollUntilVisible(
        find.text('Save my goal'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Save my goal'));
      await tester.pumpAndSettle();
      expect(state.profile.name, 'Ana');
      expect(state.profile.reason, 'Study abroad');
      expect(state.profile.dailyQuestions, 10);
      expect(state.goal, ExamLevel.c1);
      expect(find.byType(ProfileScreen), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('a wrong answer encourages, counts once, and can be retried', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1100);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final state = await AppState.open();
    await state.setGoal(ExamLevel.b1);
    await state.saveProfile(
      const LearnerProfile(
        name: 'Ana',
        configured: true,
        dailyQuestions: 1,
        effects: false,
      ),
    );
    await tester.pumpWidget(CilApp(state: state));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Passive voice'));
    await tester.tap(find.text('Passive voice'));
    await tester.pumpAndSettle();
    // The B1 passive deck has one question, so this exercises finishing and retrying.
    final options = find.text('made');
    expect(options, findsOneWidget);
    await tester.tap(options);
    await tester.pump();
    await tester.tap(find.text('Check'));
    await tester.pumpAndSettle();
    expect(state.todayQuestions, 1);
    expect(find.text('Daily goal complete, Ana'), findsOneWidget);
    await tester.ensureVisible(find.text('Finish'));
    await tester.tap(find.text('Finish'));
    await tester.pumpAndSettle();
    expect(find.text('Practice complete'), findsOneWidget);
    expect(state.todayQuestions, 1);
    await tester.ensureVisible(find.text('Try this question again'));
    await tester.tap(find.text('Try this question again'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('was made'));
    await tester.pump();
    await tester.tap(find.text('Check'));
    await tester.pumpAndSettle();
    expect(state.todayQuestions, 2);
    expect(state.mistakes, isEmpty);
    expect(find.text('Well done, Ana'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('celebrations respect reduced motion', (tester) async {
    final state = await AppState.open();
    await tester.pumpWidget(
      AppScope(
        state: state,
        child: MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: const Scaffold(
              body: EncouragementCard(
                title: 'Well done',
                message: 'Every attempt counts.',
                celebrate: true,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(tester.binding.hasScheduledFrame, false);
    expect(find.text('Well done'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'illustrations finish, and disabling effects stops motion immediately',
    (tester) async {
      final state = await AppState.open();
      await tester.pumpWidget(
        AppScope(
          state: state,
          child: MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  for (final scene in MotivationScene.values)
                    MotivationArt(scene: scene),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));
      expect(tester.binding.hasScheduledFrame, true);
      await state.saveProfile(const LearnerProfile(effects: false));
      await tester.pump();
      await tester.pump();
      expect(tester.binding.hasScheduledFrame, false);
      expect(find.byType(MotivationArt), findsNWidgets(3));
      await state.saveProfile(const LearnerProfile(effects: true));
      await tester.pump();
      expect(tester.binding.hasScheduledFrame, false);
      // A fresh illustration can animate, but never loops indefinitely.
      await tester.pumpWidget(const SizedBox());
      await tester.pumpWidget(
        AppScope(
          state: state,
          child: const MaterialApp(
            home: Scaffold(body: MotivationArt(scene: MotivationScene.growth)),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 200));
      expect(tester.binding.hasScheduledFrame, true);
      await tester.pump(const Duration(seconds: 2));
      expect(tester.binding.hasScheduledFrame, false);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'all artwork stays still with reduced motion or an inactive tab',
    (tester) async {
      final state = await AppState.open();
      for (final reducedMotion in [true, false]) {
        await tester.pumpWidget(
          AppScope(
            state: state,
            child: MaterialApp(
              home: MediaQuery(
                data: MediaQueryData(disableAnimations: reducedMotion),
                child: TickerMode(
                  enabled: reducedMotion,
                  child: Scaffold(
                    body: Row(
                      children: [
                        for (final scene in MotivationScene.values)
                          MotivationArt(scene: scene),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pump();
        expect(tester.binding.hasScheduledFrame, false);
        expect(find.byType(MotivationArt), findsNWidgets(3));
        expect(tester.takeException(), isNull);
        await tester.pumpWidget(const SizedBox());
      }
    },
  );

  testWidgets(
    'illustrated feedback fits small screens and enlarged text in both themes',
    (tester) async {
      tester.view.physicalSize = const Size(320, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final state = await AppState.open();
      for (final theme in [lightTheme(), darkTheme()]) {
        for (final scale in [1.0, 2.0]) {
          await tester.pumpWidget(
            AppScope(
              state: state,
              child: MaterialApp(
                theme: theme,
                home: MediaQuery(
                  data: MediaQueryData(textScaler: TextScaler.linear(scale)),
                  child: const Scaffold(
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          GoalCard(),
                          EncouragementCard(
                            title: 'Well done, Ana',
                            message: 'You made time for your goal today.',
                            celebrate: true,
                          ),
                          EncouragementCard(
                            title: 'Keep going, Ana',
                            message: 'Every attempt is a step forward.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          expect(find.text('Well done, Ana'), findsOneWidget);
          expect(find.text('Keep going, Ana'), findsOneWidget);
        }
      }
    },
  );
}
