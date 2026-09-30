import 'learner_profile.dart';

bool get supportsLocalReminders => false;

Future<bool> localReminderEnabled() async => false;
Future<void> restoreLocalReminder(LearnerProfile profile, String level) async {}
Future<void> cancelLocalReminder() async {}
Future<void> setLocalReminder(
  bool enabled,
  LearnerProfile profile,
  String level,
) async {
  if (enabled) {
    throw UnsupportedError('Local reminders are not supported here.');
  }
}
