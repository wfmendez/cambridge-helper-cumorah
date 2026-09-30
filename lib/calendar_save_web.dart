import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

Future<String> saveCalendarReminder(String contents) async {
  final blob = web.Blob(
    [contents.toJS].toJS,
    web.BlobPropertyBag(type: 'text/calendar;charset=utf-8'),
  );
  final url = web.URL.createObjectURL(blob);
  final anchor = web.HTMLAnchorElement()
    ..href = url
    ..download = 'cil-study-reminder.ics';
  anchor.click();
  Timer(const Duration(seconds: 30), () => web.URL.revokeObjectURL(url));
  return 'Open cil-study-reminder.ics in your calendar. Confirm the daily repeat and alert to activate it.';
}
