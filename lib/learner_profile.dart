/// Personal preferences stay on this device, alongside practice progress.
library;

class LearnerProfile {
  const LearnerProfile({
    this.name = '',
    this.reason = '',
    this.targetDate,
    this.dailyQuestions = 5,
    this.sounds = false,
    this.effects = true,
    this.reminderHour = 18,
    this.reminderMinute = 0,
    this.configured = false,
  });

  final String name;
  final String reason;
  final DateTime? targetDate;
  final int dailyQuestions;
  final bool sounds;
  final bool effects;
  final int reminderHour;
  final int reminderMinute;
  final bool configured;

  Map<String, dynamic> toJson() => {
    'name': name,
    'reason': reason,
    'targetDate': targetDate == null ? null : dayKey(targetDate!),
    'dailyQuestions': dailyQuestions,
    'sounds': sounds,
    'effects': effects,
    'reminderHour': reminderHour,
    'reminderMinute': reminderMinute,
    'configured': configured,
  };

  factory LearnerProfile.fromJson(Object? value) {
    final data = value is Map ? value : const {};
    String text(String key, int limit) {
      final raw = data[key];
      if (raw is! String) return '';
      final clean = raw.replaceAll(RegExp(r'\s+'), ' ').trim();
      return String.fromCharCodes(clean.runes.take(limit));
    }

    int number(String key, int fallback, int min, int max) {
      final raw = data[key];
      return raw is int && raw >= min && raw <= max ? raw : fallback;
    }

    final date = data['targetDate'];
    final parsed = date is String ? DateTime.tryParse(date) : null;
    return LearnerProfile(
      name: text('name', 32),
      reason: text('reason', 160),
      targetDate: parsed == null
          ? null
          : DateTime(parsed.year, parsed.month, parsed.day),
      dailyQuestions: number('dailyQuestions', 5, 1, 50),
      sounds: data['sounds'] == true,
      effects: data['effects'] != false,
      reminderHour: number('reminderHour', 18, 0, 23),
      reminderMinute: number('reminderMinute', 0, 0, 59),
      configured: data['configured'] == true,
    );
  }
}

String dayKey(DateTime day) =>
    '${day.year}-${day.month.toString().padLeft(2, '0')}-'
    '${day.day.toString().padLeft(2, '0')}';

int daysUntil(DateTime target, DateTime now) => DateTime.utc(
  target.year,
  target.month,
  target.day,
).difference(DateTime.utc(now.year, now.month, now.day)).inDays;
