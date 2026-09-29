import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../cambridge_theme.dart';

/// The Listening player, black and white like the rest of the mock.
///
/// In the real exam the audio is in charge: played twice, no stopping. Here it
/// can be stopped, because you are practising — and the scrubber rewinds in
/// small steps, which is what you need to catch the exact word in Part 2
/// without restarting the whole track.
class ListeningPlayer extends StatefulWidget {
  const ListeningPlayer({super.key, required this.part, required this.file});

  final int part;

  /// Path inside `assets/`, without the `assets/` prefix.
  final String file;

  @override
  State<ListeningPlayer> createState() => _ReproductorListeningState();
}

class _ReproductorListeningState extends State<ListeningPlayer> {
  final _reproductor = AudioPlayer();
  Duration _posicion = Duration.zero;
  Duration _total = Duration.zero;
  bool _sonando = false;

  @override
  void initState() {
    super.initState();
    _reproductor.onDurationChanged.listen((d) {
      if (mounted) setState(() => _total = d);
    });
    _reproductor.onPositionChanged.listen((p) {
      if (mounted) setState(() => _posicion = p);
    });
    _reproductor.onPlayerStateChanged.listen((e) {
      if (mounted) setState(() => _sonando = e == PlayerState.playing);
    });
  }

  @override
  void dispose() {
    _reproductor.dispose();
    super.dispose();
  }

  Future<void> _alternar() async {
    if (_sonando) {
      await _reproductor.pause();
    } else {
      await _reproductor.play(AssetSource(widget.file));
    }
  }

  Future<void> _mover(int seconds) async {
    final destino = _posicion + Duration(seconds: seconds);
    await _reproductor.seek(
      destino < Duration.zero
          ? Duration.zero
          : (destino > _total ? _total : destino),
    );
  }

  static String _reloj(Duration d) {
    final m = d.inMinutes.toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
      decoration: BoxDecoration(
        border: Border.all(color: paperRule),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => _mover(-10),
                icon: const Icon(Icons.replay_10_rounded),
                color: paperInk,
                tooltip: 'Back 10 seconds',
              ),
              IconButton(
                onPressed: _alternar,
                iconSize: 40,
                color: paperInk,
                icon: Icon(
                  _sonando
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_circle_fill_rounded,
                ),
              ),
              IconButton(
                onPressed: () => _mover(10),
                icon: const Icon(Icons.forward_10_rounded),
                color: paperInk,
                tooltip: 'Forward 10 seconds',
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Part ${widget.part} audio',
                  style: theme.textTheme.bodySmall,
                ),
              ),
              Text(
                '${_reloj(_posicion)} / ${_reloj(_total)}',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: paperInk,
              inactiveTrackColor: paperRule,
              thumbColor: paperInk,
              overlayColor: paperInk.withValues(alpha: 0.1),
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            ),
            child: Slider(
              value: _total.inMilliseconds == 0
                  ? 0
                  : _posicion.inMilliseconds
                        .clamp(0, _total.inMilliseconds)
                        .toDouble(),
              max: _total.inMilliseconds == 0
                  ? 1
                  : _total.inMilliseconds.toDouble(),
              onChanged: (v) =>
                  _reproductor.seek(Duration(milliseconds: v.round())),
            ),
          ),
        ],
      ),
    );
  }
}
