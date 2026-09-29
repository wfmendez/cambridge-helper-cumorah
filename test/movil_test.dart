import 'package:cil/main.dart';
import 'package:cil/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'audio_falso.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(simularAudio);
  for (final oscuro in [false, true]) {
    testWidgets('mobile appearance ${oscuro ? 'dark' : 'light'}', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      SharedPreferences.setMockInitialValues({'tutorial_seen': true});
      final state = await AppState.open();
      if (oscuro) {
        tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
        addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
      }
      await tester.pumpWidget(CilApp(state: state));
      await tester.pumpAndSettle();
      for (final destino in ['Practice', 'Writing', 'Mock test', 'Progress']) {
        await tester.tap(find.text(destino));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await expectLater(
          find.byType(Scaffold).first,
          matchesGoldenFile(
            'goldens/${destino.replaceAll(' ', '_')}_${oscuro ? 'dark' : 'light'}.png',
          ),
        );
      }
    });
  }
}
