import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'learner_profile.dart';

const _key = 'local_reminder_enabled';
const _id = 4201;
final _notifications = FlutterLocalNotificationsPlugin();
bool _ready = false;

// The distributed Android app can schedule offline. Web and the portable
// Windows build use the calendar option; Windows ZIPs have no package identity.
bool get supportsLocalReminders =>
    defaultTargetPlatform == TargetPlatform.android;

Future<void> _initialize() async {
  if (_ready) return;
  tz.initializeTimeZones();
  final zone = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(zone.identifier));
  await _notifications.initialize(
    settings: const InitializationSettings(
      android: AndroidInitializationSettings('ic_notification'),
    ),
  );
  _ready = true;
}

Future<bool> localReminderEnabled() async =>
    supportsLocalReminders &&
    ((await SharedPreferences.getInstance()).getBool(_key) ?? false);

Future<void> _schedule(LearnerProfile profile, String level) async {
  final now = tz.TZDateTime.now(tz.local);
  var next = tz.TZDateTime(
    tz.local,
    now.year,
    now.month,
    now.day,
    profile.reminderHour,
    profile.reminderMinute,
  );
  if (!next.isAfter(now)) {
    next = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day + 1,
      profile.reminderHour,
      profile.reminderMinute,
    );
  }
  await _notifications.zonedSchedule(
    id: _id,
    title: 'Cíl · a little closer to $level',
    body:
        '${profile.name.isEmpty ? 'Ready for a little English?' : '${profile.name}, ready for a little English?'} '
        '${profile.dailyQuestions} practice questions. One small step at a time.',
    scheduledDate: next,
    notificationDetails: const NotificationDetails(
      android: AndroidNotificationDetails(
        'cil_daily_goal',
        'Daily study reminder',
        channelDescription: 'Your optional daily English practice reminder',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,
  );
}

Future<void> setLocalReminder(
  bool enabled,
  LearnerProfile profile,
  String level,
) async {
  if (!supportsLocalReminders) return;
  if (!enabled) return cancelLocalReminder();
  await _initialize();
  final android = _notifications
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()!;
  final granted = await android.requestNotificationsPermission();
  if (granted != true) {
    throw StateError(
      'Notifications are disabled. Allow them in Android settings, then try again.',
    );
  }
  await _schedule(profile, level);
  await (await SharedPreferences.getInstance()).setBool(_key, true);
}

Future<void> cancelLocalReminder() async {
  final prefs = await SharedPreferences.getInstance();
  if (supportsLocalReminders && (prefs.getBool(_key) ?? false)) {
    await _initialize();
    await _notifications.cancel(id: _id);
  }
  await prefs.remove(_key);
}

Future<void> restoreLocalReminder(LearnerProfile profile, String level) async {
  if (!await localReminderEnabled()) return;
  try {
    await _initialize();
    // Refresh the timezone after travelling; never prompt on launch.
    await _schedule(profile, level);
  } catch (_) {
    // Offline practice must still open if the OS declines notifications.
  }
}
