/// The take as a file, on Android and iOS. See toma.dart.
library;

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AlmacenTomas {
  const AlmacenTomas();

  /// AAC mono a 64 kbps: es voz, y el archivo queda pequeño. Nadie va a
  /// masterizar esto.
  Future<RecordConfig> config() async => const RecordConfig(
    encoder: AudioEncoder.aacLc,
    bitRate: 64000,
    numChannels: 1,
  );

  /// One take per part, overwritten each time.
  Future<String> destino(String slot) async {
    final dir = await getTemporaryDirectory();
    return '${dir.path}/cil_speaking_$slot.m4a';
  }

  /// Una toma de esta misma sesión sigue ahí si vuelves a la pantalla.
  Future<String?> previa(String slot) async {
    final ruta = await destino(slot);
    return await File(ruta).exists() ? ruta : null;
  }

  Source fuente(String ruta) => DeviceFileSource(ruta);

  Future<void> borrar(String ruta) async {
    final f = File(ruta);
    if (await f.exists()) await f.delete();
  }
}
