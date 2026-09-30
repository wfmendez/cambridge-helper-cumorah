import 'dart:convert';

import 'package:cil/calendar_reminder.dart';
import 'package:cil/learner_profile.dart';
import 'package:cil/reminders_native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('calendar reminder rolls forward, repeats, and escapes personal text', () {
    final ics = createCalendarReminder(
      LearnerProfile(
        reason:
            'University; travel, English\nBEGIN:VEVENT ${List.filled(45, 'á').join()}',
        reminderHour: 18,
        reminderMinute: 15,
      ),
      'B2',
      now: DateTime(2026, 12, 31, 19),
      id: 'test-goal',
    );
    final unfolded = ics.replaceAll('\r\n ', '');
    expect(unfolded, contains('DTSTART:20270101T181500\r\n'));
    expect(unfolded, contains('RRULE:FREQ=DAILY\r\n'));
    expect(unfolded, contains('BEGIN:VALARM\r\nTRIGGER:PT0M'));
    expect(unfolded, contains(r'University\; travel\, English\nBEGIN:VEVENT'));
    expect(RegExp(r'(^|\r\n)BEGIN:VEVENT').allMatches(ics), hasLength(1));
    for (final line in ics.split('\r\n')) {
      expect(utf8.encode(line).length, lessThanOrEqualTo(75));
    }
  });

  test(
    'Android reminder requests permission only on opt-in and can be cancelled',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      addTearDown(() => debugDefaultTargetPlatformOverride = null);
      SharedPreferences.setMockInitialValues({});
      AndroidFlutterLocalNotificationsPlugin.registerWith();
      final messenger =
          TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
      const channel = MethodChannel(
        'dexterous.com/flutter/local_notifications',
      );
      const timezone = MethodChannel('flutter_timezone');
      final calls = <MethodCall>[];
      var granted = false;
      messenger.setMockMethodCallHandler(
        timezone,
        (_) async => 'America/Caracas',
      );
      messenger.setMockMethodCallHandler(channel, (call) async {
        calls.add(call);
        if (call.method == 'initialize') return true;
        if (call.method == 'requestNotificationsPermission') return granted;
        return null;
      });
      addTearDown(() {
        messenger.setMockMethodCallHandler(channel, null);
        messenger.setMockMethodCallHandler(timezone, null);
      });
      const profile = LearnerProfile(
        name: 'Ana',
        reminderHour: 7,
        reminderMinute: 30,
      );
      await restoreLocalReminder(profile, 'B2');
      expect(calls, isEmpty);
      await expectLater(
        setLocalReminder(true, profile, 'B2'),
        throwsStateError,
      );
      expect(await localReminderEnabled(), false);
      expect(calls.where((call) => call.method == 'zonedSchedule'), isEmpty);
      granted = true;
      await setLocalReminder(true, profile, 'B2');
      expect(await localReminderEnabled(), true);
      final scheduled =
          calls.lastWhere((call) => call.method == 'zonedSchedule').arguments
              as Map;
      expect(scheduled['timeZoneName'], 'America/Caracas');
      expect(scheduled['scheduledDateTime'], contains('T07:30:00'));
      expect(scheduled['body'], contains('Ana'));
      calls.clear();
      await restoreLocalReminder(profile, 'B2');
      expect(
        calls.where((call) => call.method == 'requestNotificationsPermission'),
        isEmpty,
      );
      await cancelLocalReminder();
      expect(await localReminderEnabled(), false);
      expect(calls.last.method, 'cancel');
    },
  );
}
