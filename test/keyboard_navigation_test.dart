import 'package:cil/cambridge.dart';
import 'package:cil/main.dart';
import 'package:cil/screens/descargas.dart';
import 'package:cil/screens/profile.dart';
import 'package:cil/screens/task_types.dart';
import 'package:cil/screens/tutorial.dart';
import 'package:cil/screens/vocab.dart';
import 'package:cil/screens/writing.dart';
import 'package:cil/state.dart';
import 'package:cil/writing_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio_falso.dart';

Future<void> press(WidgetTester tester, LogicalKeyboardKey key) async {
  await tester.sendKeyEvent(key);
  await tester.pumpAndSettle();
}

ScrollPosition listPosition(WidgetTester tester) => tester
    .state<ScrollableState>(
      find
          .descendant(
            of: find.byType(ListView).first,
            matching: find.byType(Scrollable),
          )
          .first,
    )
    .position;

Future<void> start(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1280, 560);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(CilApp(state: await AppState.open()));
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({'tutorial_seen': true});
    simularAudio();
  });

  testWidgets('arrows and page keys scroll the profile from its header', (
    tester,
  ) async {
    await start(tester);
    await tester.tap(find.text('Set up my goal').first);
    await tester.pumpAndSettle();
    final position = listPosition(tester);
    expect(position.pixels, 0);
    await press(tester, LogicalKeyboardKey.arrowDown);
    final afterArrow = position.pixels;
    expect(afterArrow, greaterThan(0));
    await press(tester, LogicalKeyboardKey.pageDown);
    expect(position.pixels, greaterThan(afterArrow));
    await press(tester, LogicalKeyboardKey.pageUp);
    expect(position.pixels, closeTo(afterArrow, 1));
    await press(tester, LogicalKeyboardKey.arrowUp);
    expect(position.pixels, closeTo(0, 1));
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(ProfileScreen), findsNothing);
    expect(tester.takeException(), isNull);
  }, variant: TargetPlatformVariant.only(TargetPlatform.windows));

  testWidgets('keyboard scrolling only moves the selected main destination', (
    tester,
  ) async {
    await start(tester);
    final positions = <ScrollPosition>[];
    for (final label in [
      'Practice',
      'Writing',
      'Speaking',
      'Mock test',
      'Progress',
    ]) {
      await tester.tap(find.text(label).first);
      await tester.pumpAndSettle();
      final position = listPosition(tester);
      final previousOffsets = [
        for (final previous in positions) previous.pixels,
      ];
      expect(position.maxScrollExtent, greaterThan(0), reason: label);
      final before = position.pixels;
      await press(tester, LogicalKeyboardKey.arrowDown);
      expect(position.pixels, greaterThan(before), reason: label);
      for (var i = 0; i < positions.length; i++) {
        expect(
          positions[i].pixels,
          previousOffsets[i],
          reason: 'Inactive tab moved',
        );
      }
      positions.add(position);
    }
    await tester.tap(find.text('Practice').first);
    await tester.pumpAndSettle();
    expect(listPosition(tester), same(positions.first));
    expect(positions.first.pixels, greaterThan(0));
    expect(tester.takeException(), isNull);
  }, variant: TargetPlatformVariant.only(TargetPlatform.windows));

  testWidgets('reference pages and tutorial scroll immediately after opening', (
    tester,
  ) async {
    await start(tester);
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    for (final page in <Widget>[
      const DescargasScreen(),
      const TaskTypesScreen(),
      const VocabScreen(),
      const PantallaTutorial(),
    ]) {
      navigator.push(MaterialPageRoute<void>(builder: (_) => page));
      await tester.pumpAndSettle();
      final position = listPosition(tester);
      expect(position.maxScrollExtent, greaterThan(0));
      await press(tester, LogicalKeyboardKey.pageDown);
      expect(position.pixels, greaterThan(0));
      if (page is PantallaTutorial) {
        await tester.tap(find.text('Next'));
        await tester.pumpAndSettle();
        await press(tester, LogicalKeyboardKey.arrowDown);
      }
      expect(tester.takeException(), isNull);
      navigator.pop();
      await tester.pumpAndSettle();
    }
  }, variant: TargetPlatformVariant.only(TargetPlatform.windows));

  testWidgets('arrow keys edit profile text without scrolling the page', (
    tester,
  ) async {
    await start(tester);
    await tester.tap(find.text('Set up my goal').first);
    await tester.pumpAndSettle();
    final field = find.byWidgetPredicate(
      (widget) =>
          widget is TextField &&
          widget.decoration?.labelText == 'Why does this matter to you?',
    );
    await tester.ensureVisible(field);
    await tester.enterText(field, 'My first line\nMy second line');
    await tester.pumpAndSettle();
    final controller = tester.widget<TextField>(field).controller!;
    final offset = listPosition(tester).pixels;
    final cursor = controller.selection.baseOffset;
    await press(tester, LogicalKeyboardKey.arrowUp);
    expect(controller.selection.baseOffset, lessThan(cursor));
    expect(listPosition(tester).pixels, offset);
    await press(tester, LogicalKeyboardKey.arrowDown);
    expect(controller.selection.baseOffset, cursor);
    expect(listPosition(tester).pixels, offset);
    expect(tester.takeException(), isNull);
  }, variant: TargetPlatformVariant.only(TargetPlatform.windows));

  testWidgets(
    'Writing scrolls its prompt, and arrows inside the draft keep editing',
    (tester) async {
      await start(tester);
      final navigator = tester.state<NavigatorState>(find.byType(Navigator));
      navigator.push(
        MaterialPageRoute<void>(
          builder: (_) =>
              WritingEditor(task: writingTasksFor(ExamLevel.b2).first),
        ),
      );
      await tester.pumpAndSettle();
      final prompt = tester
          .state<ScrollableState>(
            find
                .descendant(
                  of: find.byWidgetPredicate(
                    (w) => w is SingleChildScrollView && w.primary == true,
                  ),
                  matching: find.byType(Scrollable),
                )
                .first,
          )
          .position;
      expect(prompt.maxScrollExtent, greaterThan(0));
      await press(tester, LogicalKeyboardKey.pageDown);
      expect(prompt.pixels, greaterThan(0));
      final field = find.byType(TextField);
      await tester.enterText(field, 'A first idea\nA second idea');
      await tester.pumpAndSettle();
      final controller = tester.widget<TextField>(field).controller!;
      final cursor = controller.selection.baseOffset;
      final promptOffset = prompt.pixels;
      await press(tester, LogicalKeyboardKey.arrowUp);
      expect(controller.selection.baseOffset, lessThan(cursor));
      expect(prompt.pixels, promptOffset);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
    },
    variant: TargetPlatformVariant.only(TargetPlatform.windows),
  );
}
