/// Smoke tests: the screens actually build.
///
/// Everything else in the suite checks data. These check that the widgets
/// around the data survive being rendered, including at the text size someone
/// with poor eyesight will be using — which is how a real overflow was caught
/// in the sister app, on a header that looked fine on my own phone.
library;

import 'package:cil/main.dart';
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
      await tester.tap(find.text('Writing'));
      await tester.pumpAndSettle();
      expect(find.text('PART 1 · COMPULSORY'), findsOneWidget);
      tester.view.physicalSize = Size(width == 1920 ? 360 : 1920, 900);
      await tester.pumpAndSettle();
      expect(find.text('PART 1 · COMPULSORY'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

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
