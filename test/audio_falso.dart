import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

// No usa micrófono ni reproduce audio en las pruebas de disposición.
void simularAudio() {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'),
        (_) async => 'build/test-recordings',
      );
  for (final channel in [
    'xyz.luan/audioplayers.global/events',
    'xyz.luan/audioplayers.global',
    'xyz.luan/audioplayers',
    'com.llfbandit.record/messages',
  ]) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(MethodChannel(channel), (call) async {
          if (channel == 'xyz.luan/audioplayers' && call.method == 'create') {
            final id = (call.arguments as Map)['playerId'];
            TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
                .setMockMethodCallHandler(
                  MethodChannel('xyz.luan/audioplayers/events/$id'),
                  (_) async => null,
                );
          }
          return null;
        });
  }
}
