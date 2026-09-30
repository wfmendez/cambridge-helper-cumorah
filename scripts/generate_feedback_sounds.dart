// Original soft chimes; no external audio downloads or runtime synthesis.
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

void main() {
  Directory('assets/sounds').createSync(recursive: true);
  for (final entry in {
    'correct': [523.25, 659.25],
    'try-again': [392.0],
    'celebrate': [523.25, 659.25, 783.99],
  }.entries) {
    const rate = 22050;
    const noteSeconds = 0.18;
    final samples = (rate * (entry.value.length * noteSeconds + 0.14)).ceil();
    final data = ByteData(44 + samples * 2);
    void ascii(int offset, String text) {
      for (var i = 0; i < text.length; i++) {
        data.setUint8(offset + i, text.codeUnitAt(i));
      }
    }

    ascii(0, 'RIFF');
    data.setUint32(4, 36 + samples * 2, Endian.little);
    ascii(8, 'WAVE');
    ascii(12, 'fmt ');
    data.setUint32(16, 16, Endian.little);
    data.setUint16(20, 1, Endian.little);
    data.setUint16(22, 1, Endian.little);
    data.setUint32(24, rate, Endian.little);
    data.setUint32(28, rate * 2, Endian.little);
    data.setUint16(32, 2, Endian.little);
    data.setUint16(34, 16, Endian.little);
    ascii(36, 'data');
    data.setUint32(40, samples * 2, Endian.little);
    for (var i = 0; i < samples; i++) {
      final t = i / rate;
      var signal = 0.0;
      for (var n = 0; n < entry.value.length; n++) {
        final age = t - n * noteSeconds;
        if (age < 0 || age > 0.32) continue;
        final envelope = min(1.0, age / 0.015) * pow(1 - age / 0.32, 3);
        signal += sin(2 * pi * entry.value[n] * age) * envelope * 0.4;
      }
      data.setInt16(
        44 + i * 2,
        (signal.clamp(-1, 1) * 32767).round(),
        Endian.little,
      );
    }
    File('assets/sounds/${entry.key}.wav')
        .writeAsBytesSync(data.buffer.asUint8List());
  }
}
