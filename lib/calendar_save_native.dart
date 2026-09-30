import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> saveCalendarReminder(String contents) async {
  final folder = await getDownloadsDirectory();
  if (folder == null) throw StateError('Downloads folder unavailable');
  await folder.create(recursive: true);
  final file = File(
    '${folder.path}${Platform.pathSeparator}cil-study-reminder.ics',
  );
  await file.writeAsString(contents);
  return 'Open ${file.path} in your calendar. Confirm the daily repeat and alert to activate it.';
}
