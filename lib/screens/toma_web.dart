/// The take as a blob URL, in a browser. See toma.dart.
library;

import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';
import 'package:web/web.dart' as web;

class AlmacenTomas {
  const AlmacenTomas();

  /// Cada navegador graba en lo suyo: Safari sabe MPEG-4/AAC y Chrome y
  /// Firefox saben WebM/Opus. Se pregunta en vez de suponer, y se pide
  /// primero AAC para que la toma salga igual que en el móvil cuando se
  /// puede.
  Future<RecordConfig> config() async {
    final grabador = AudioRecorder();
    try {
      for (final encoder in [AudioEncoder.aacLc, AudioEncoder.opus]) {
        if (await grabador.isEncoderSupported(encoder)) {
          return RecordConfig(encoder: encoder, bitRate: 64000, numChannels: 1);
        }
      }
    } finally {
      grabador.dispose();
    }
    // Ningún navegador conocido llega hasta aquí; si lo hace, que falle al
    // grabar con un formato nombrado y no con una lista vacía.
    return const RecordConfig(
      encoder: AudioEncoder.opus,
      bitRate: 64000,
      numChannels: 1,
    );
  }

  /// El navegador decide dónde va el dato y `record` ignora esta ruta, pero
  /// la API la exige. La toma real llega como blob URL al parar.
  Future<String> destino(String slot) async => '';

  /// Un blob URL vive en la memoria de la pestaña, así que no hay nada que
  /// recuperar: al volver a la pantalla la toma anterior ya no existe.
  Future<String?> previa(String slot) async => null;

  Source fuente(String ruta) => UrlSource(ruta);

  /// Sin esto el blob se queda en memoria hasta que se recargue la página.
  Future<void> borrar(String ruta) async {
    if (ruta.isNotEmpty) web.URL.revokeObjectURL(ruta);
  }
}
