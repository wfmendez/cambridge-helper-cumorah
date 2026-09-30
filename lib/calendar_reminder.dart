import 'dart:convert';

import 'learner_profile.dart';

export 'calendar_save_stub.dart'
    if (dart.library.js_interop) 'calendar_save_web.dart'
    if (dart.library.io) 'calendar_save_native.dart';

/// A floating local time keeps the chosen hour when the calendar changes DST.
/// The calendar, not an open browser tab, delivers the daily alert.
String createCalendarReminder(
  LearnerProfile profile,
  String level, {
  required DateTime now,
  required String id,
}) {
  var start = DateTime(
    now.year,
    now.month,
    now.day,
    profile.reminderHour,
    profile.reminderMinute,
  );
  if (!start.isAfter(now)) {
    start = DateTime(
      now.year,
      now.month,
      now.day + 1,
      profile.reminderHour,
      profile.reminderMinute,
    );
  }
  String stamp(DateTime date) =>
      '${dayKey(date).replaceAll('-', '')}T'
      '${date.hour.toString().padLeft(2, '0')}'
      '${date.minute.toString().padLeft(2, '0')}00';
  String escape(String text) => text
      .replaceAll('\\', '\\\\')
      .replaceAll('\r\n', '\n')
      .replaceAll('\r', '\n')
      .replaceAll('\n', r'\n')
      .replaceAll(';', r'\;')
      .replaceAll(',', r'\,');
  // RFC 5545 folds by UTF-8 octets, not by Dart string length.
  String fold(String line) {
    final out = StringBuffer();
    var bytes = 0;
    for (final rune in line.runes) {
      final char = String.fromCharCode(rune);
      final length = utf8.encode(char).length;
      if (bytes + length > 75) {
        out.write('\r\n ');
        bytes = 1;
      }
      out.write(char);
      bytes += length;
    }
    return out.toString();
  }

  final description =
      '${profile.dailyQuestions} practice questions towards $level. '
      'One small step at a time.\n'
      '${profile.reason.isEmpty ? '' : '${profile.reason}\n'}'
      'Open Cíl: https://cambridge-helper-cumorah.vercel.app/';
  return [
    'BEGIN:VCALENDAR',
    'VERSION:2.0',
    'PRODID:-//Cil//Study reminder//EN',
    'CALSCALE:GREGORIAN',
    'BEGIN:VEVENT',
    'UID:${escape(id)}@cil.practice',
    'DTSTAMP:${stamp(now.toUtc())}Z',
    'DTSTART:${stamp(start)}',
    'DURATION:PT15M',
    'RRULE:FREQ=DAILY',
    'SUMMARY:${escape('Cíl · a little closer to $level')}',
    'DESCRIPTION:${escape(description)}',
    'URL:https://cambridge-helper-cumorah.vercel.app/',
    'BEGIN:VALARM',
    'TRIGGER:PT0M',
    'ACTION:DISPLAY',
    'DESCRIPTION:Time for a little English. You can do this.',
    'END:VALARM',
    'END:VEVENT',
    'END:VCALENDAR',
    '',
  ].map(fold).join('\r\n');
}
