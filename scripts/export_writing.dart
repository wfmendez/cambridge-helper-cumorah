import 'dart:convert';
import 'dart:io';

import 'package:cil/writing_data.dart';

// El servidor elige la consigna por id: nunca acepta una rúbrica del cliente.
// Este catálogo se genera desde los mismos datos que muestra Flutter.
void main(List<String> args) {
  final json =
      '${const JsonEncoder.withIndent('  ').convert({
        for (final task in writingTasks) task.id: {'level': task.level.cefr, 'kind': task.kind.label, 'part': task.part, 'instructions': task.instructions, 'question': task.question, 'notes': task.notes, 'register': task.register, 'checklist': task.checklist, 'wordTarget': task.wordTarget},
      })}\n';
  final file = File('server/writing-tasks.json');
  if (args.contains('--check')) {
    if (!file.existsSync() ||
        file.readAsStringSync().replaceAll('\r\n', '\n') != json) {
      stderr.writeln(
        'Run dart run scripts/export_writing.dart to update the API task catalogue.',
      );
      exitCode = 1;
    }
  } else {
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(json);
  }
}
