/// Smoke tests: the screens actually build.
///
/// Everything else in the suite checks data. These check that the widgets
/// around the data survive being rendered, including at the text size someone
/// with poor eyesight will be using — which is how a real overflow was caught
/// in the sister app, on a header that looked fine on my own phone.
library;

import 'package:cil/main.dart';
import 'package:cil/cambridge.dart';
import 'package:cil/cambridge_data.dart';
import 'package:cil/screens/descargas.dart';
import 'package:cil/screens/task_types.dart';
import 'package:cil/screens/tutorial.dart';
import 'package:cil/screens/writing.dart';
import 'package:cil/writing_data.dart';
import 'package:cil/widgets.dart';
import 'package:cil/state.dart';
import 'package:cil/screens/vocab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio_falso.dart';

Future<Widget> _app() async {
  final state = await AppState.open();
  return CilApp(state: state);
}

void main() {
  // El tutorial de primera vez tapa la app entera; estas pruebas son sobre
  // lo que hay debajo.
  setUp(() {
    SharedPreferences.setMockInitialValues({'tutorial_seen': true});
    simularAudio();
  });

  for (final width in [360.0, 800.0, 1920.0]) {
    testWidgets('navigation and content width at $width', (tester) async {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(await _app());
      await tester.pumpAndSettle();
      expect(
        find.byType(NavigationRail),
        width >= 840 ? findsOneWidget : findsNothing,
      );
      expect(
        find.byType(NavigationBar),
        width < 840 ? findsOneWidget : findsNothing,
      );
      final cardWidth = tester.getSize(find.byType(ContentCard).first).width;
      if (width == 360) expect(cardWidth, width - 32);
      expect(cardWidth, lessThanOrEqualTo(1200));
      if (width >= 800) {
        final cards = find.byType(ContentCard);
        // The personal goal spans the row above the two quick-start cards.
        final first = tester.getRect(cards.at(1));
        final second = tester.getRect(cards.at(2));
        expect(first.top, second.top);
        expect(first.height, second.height);
        expect(first.right, lessThan(second.left));
        expect(first.width, lessThanOrEqualTo(600));
      }
      await tester.tap(find.text('Writing'));
      await tester.pumpAndSettle();
      expect(find.text('PART 1 · COMPULSORY'), findsOneWidget);
      tester.view.physicalSize = Size(width == 1920 ? 360 : 1920, 900);
      await tester.pumpAndSettle();
      expect(find.text('PART 1 · COMPULSORY'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('wide editor keeps the task visible and the draft on resize', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1920, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final task = writingTasksFor(ExamLevel.b2).first;
    final state = await AppState.open();
    await state.saveDraft(task.id, 'A draft already started');
    await tester.pumpWidget(
      AppScope(
        state: state,
        child: MaterialApp(home: WritingEditor(task: task)),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text(task.question), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_arrow_up_rounded), findsNothing);
    final editor = tester.getRect(find.byType(TextField));
    final prompt = tester.getRect(find.text(task.question));
    expect(prompt.right, lessThan(editor.left));
    expect(editor.width, lessThanOrEqualTo(720));
    await tester.enterText(
      find.byType(TextField),
      'This draft survives resizing',
    );
    tester.view.physicalSize = const Size(360, 900);
    await tester.pumpAndSettle();
    expect(find.text('THE TASK · tap to read again'), findsOneWidget);
    expect(find.text('This draft survives resizing'), findsOneWidget);
    tester.view.physicalSize = const Size(1920, 900);
    await tester.pumpAndSettle();
    expect(find.text(task.question), findsOneWidget);
    expect(find.text('This draft survives resizing'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    expect(state.writingDraft(task.id), 'This draft survives resizing');
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('Speaking retains a running timer across the rail breakpoint', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(await _app());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Speaking'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start talking').first);
    await tester.pump(const Duration(seconds: 3));
    expect(find.text('Pause'), findsOneWidget);
    tester.view.physicalSize = const Size(800, 900);
    await tester.pumpAndSettle();
    expect(find.text('Pause'), findsOneWidget);
    tester.view.physicalSize = const Size(360, 900);
    await tester.pumpAndSettle();
    expect(find.text('Pause'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  for (final width in [360.0, 800.0, 1920.0]) {
    testWidgets('secondary screens fit at $width with larger text', (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 1000);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 1.6;
      addTearDown(tester.view.reset);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      final state = await AppState.open();
      for (final screen in <Widget>[
        const DescargasScreen(),
        const TaskTypesScreen(),
        const VocabScreen(),
        const PantallaTutorial(),
      ]) {
        await tester.pumpWidget(
          AppScope(
            state: state,
            child: MaterialApp(home: screen),
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: '$screen at $width');
        if (screen is DescargasScreen && width >= 800) {
          final cards = find.byType(ContentCard);
          expect(
            tester.getSize(cards.at(1)).height,
            tester.getSize(cards.at(2)).height,
          );
          if (width == 1920) {
            expect(
              tester.getSize(cards.at(2)).height,
              tester.getSize(cards.at(3)).height,
            );
          }
        }
      }
      await tester.pumpWidget(await _app());
      await tester.pumpAndSettle();
      for (final destino in ['Writing', 'Speaking', 'Mock test', 'Progress']) {
        await tester.tap(find.text(destino));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: '$destino at $width');
      }
      await tester.pumpWidget(const SizedBox());
    });
  }

  testWidgets('wide mocks align their groups and show one exam at a time', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final state = await AppState.open();
    await tester.pumpWidget(CilApp(state: state));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mock test'));
    await tester.pumpAndSettle();

    final b2 = find.widgetWithText(ChoiceChip, ExamLevel.b2.name);
    final list = find.byType(Scrollable).first;
    final left = tester.getTopLeft(find.text('Written for Cíl')).dx;
    expect(tester.getTopLeft(find.byType(ContentCard).first).dx, left);
    await tester.scrollUntilVisible(b2, 400, scrollable: list);
    await tester.pumpAndSettle();
    expect(tester.widget<ChoiceChip>(b2).selected, isTrue);
    expect(tester.getTopLeft(find.text('Official Cambridge papers')).dx, left);

    final b1 = find.widgetWithText(ChoiceChip, ExamLevel.b1.name);
    await tester.ensureVisible(b1);
    await tester.tap(b1);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ContentCard, 'Reading'), findsOneWidget);
    expect(state.goal, ExamLevel.b2);

    // La elección local sobrevive al salir del destino y al cambiar de ancho.
    await tester.tap(find.text('Practice'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mock test'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(b1, 400, scrollable: list);
    expect(tester.widget<ChoiceChip>(b1).selected, isTrue);
    tester.view.physicalSize = const Size(800, 1000);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(b1, 400, scrollable: list);
    expect(tester.widget<ChoiceChip>(b1).selected, isTrue);
    expect(tester.takeException(), isNull);
    tester.view.physicalSize = const Size(360, 1000);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(ChoiceChip, ExamLevel.b1.name), findsNothing);
    tester.view.physicalSize = const Size(1920, 1080);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(b1, 400, scrollable: list);
    expect(tester.widget<ChoiceChip>(b1).selected, isTrue);

    await state.setGoal(ExamLevel.c1);
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<ChoiceChip>(
            find.widgetWithText(ChoiceChip, ExamLevel.c1.name),
          )
          .selected,
      isTrue,
    );
    for (final paper in cambridgePapers.where(
      (p) => p.source == PaperSource.official && p.level == ExamLevel.c1,
    )) {
      final card = find.widgetWithText(ContentCard, paper.name);
      await tester.scrollUntilVisible(card, 300, scrollable: list);
      expect(card, findsOneWidget);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('official answers use columns and keep their values on resize', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(await _app());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mock test'));
    await tester.pumpAndSettle();
    final paper = cambridgePapers.firstWhere(
      (p) => p.source == PaperSource.official && p.selfMarked,
    );
    final exam = find.widgetWithText(ChoiceChip, paper.level.name);
    await tester.scrollUntilVisible(
      exam,
      400,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(exam);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text(paper.name));
    await tester.tap(find.text(paper.name));
    await tester.pumpAndSettle();
    final fields = find.byType(TextField);
    final first = tester.getRect(fields.at(0));
    final second = tester.getRect(fields.at(1));
    expect(first.top, second.top);
    expect(first.right, lessThan(second.left));
    await tester.enterText(fields.at(0), 'A');
    tester.view.physicalSize = const Size(360, 1000);
    await tester.pumpAndSettle();
    expect(tester.widget<TextField>(fields.first).controller!.text, 'A');
    expect(
      tester.getTopLeft(fields.at(0)).dy,
      lessThan(tester.getTopLeft(fields.at(1)).dy),
    );
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('the five destinations are all reachable from the bar', (
    tester,
  ) async {
    await tester.pumpWidget(await _app());
    await tester.pumpAndSettle();

    expect(find.text('Practice'), findsOneWidget);
    expect(find.text('Writing'), findsOneWidget);
    expect(find.text('Speaking'), findsOneWidget);
    expect(find.text('Mock test'), findsOneWidget);
    expect(find.text('Progress'), findsOneWidget);
  });

  // Writing y Speaking estuvieron escondidas detrás de Mock test; que estén
  // en la barra es justo lo que este cambio arregla.
  testWidgets('Writing and Speaking open from the bar', (tester) async {
    await tester.pumpWidget(await _app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Writing'));
    await tester.pumpAndSettle();
    // TituloMarcado pinta su texto en mayúsculas.
    expect(find.text('PART 1 · COMPULSORY'), findsOneWidget);

    await tester.tap(find.text('Speaking'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Nobody can mark your speaking'),
      findsOneWidget,
    );
  });

  // La guía dejó de ser pestaña y pasó a la cabecera.
  testWidgets('the exam guide opens from the header', (tester) async {
    await tester.pumpWidget(await _app());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('How the exam works'));
    await tester.pumpAndSettle();
    expect(find.text('The exam'), findsOneWidget);
  });

  testWidgets('the goal chips carry both names', (tester) async {
    await tester.pumpWidget(await _app());
    await tester.pumpAndSettle();

    expect(find.text('B1 · PET'), findsOneWidget);
    expect(find.text('B2 · FCE'), findsOneWidget);
    expect(find.text('C1 · CAE'), findsOneWidget);
  });

  testWidgets('nothing overflows at 1.6x text', (tester) async {
    tester.view.physicalSize = const Size(1080, 2280);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(1.6)),
        child: await _app(),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('Progress says so when there is nothing yet', (tester) async {
    await tester.pumpWidget(await _app());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Progress'));
    await tester.pumpAndSettle();

    expect(find.text('Nothing to show yet'), findsOneWidget);
  });

  testWidgets('the word bank opens and its search filters', (tester) async {
    // Con la meta en C1 se ve el banco entero, que es lo que se busca aquí.
    SharedPreferences.setMockInitialValues({
      'tutorial_seen': true,
      'target_level': 'C1 Advanced',
    });
    await tester.pumpWidget(
      MaterialApp(
        home: AppScope(
          state: await AppState.open(),
          child: const VocabScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Word bank'), findsOneWidget);
    expect(find.text('good / bad at'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'stride');
    await tester.pumpAndSettle();

    expect(find.text('good / bad at'), findsNothing);
    expect(find.text('take something in your stride'), findsOneWidget);
  });
}
