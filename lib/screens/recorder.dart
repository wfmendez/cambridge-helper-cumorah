/// Record a take and listen back to it.
///
/// Nothing here is marked and nothing is uploaded. The point is narrower and
/// more useful than a score: almost nobody has heard themselves speak English
/// for a full minute, and the first time you do, you hear the pauses, the
/// sentence you start three times and the word you always get wrong. That is
/// a list of things to fix, which is what practice needs.
///
/// One take per part, overwritten each time. A library of old recordings
/// would be something to manage, and nobody goes back to the third-best
/// attempt at Part 2.
///
/// Where that take actually lives differs between a phone and a browser;
/// `toma.dart` holds the difference so this screen does not have to.
library;

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import 'toma.dart';

class Grabadora extends StatefulWidget {
  const Grabadora({super.key, required this.slot, required this.color});

  /// Which part this take belongs to, used as the file name.
  final String slot;

  final Color color;

  @override
  State<Grabadora> createState() => _GrabadoraState();
}

enum _Estado { vacio, grabando, listo, sinPermiso }

class _GrabadoraState extends State<Grabadora> {
  final _grabador = AudioRecorder();
  final _reproductor = AudioPlayer();
  final _almacen = const AlmacenTomas();

  _Estado _estado = _Estado.vacio;
  bool _sonando = false;
  String? _ruta;
  Timer? _tic;
  int _segundos = 0;

  @override
  void initState() {
    super.initState();
    _buscarTomaPrevia();
    _reproductor.onPlayerComplete.listen((_) {
      if (mounted) setState(() => _sonando = false);
    });
  }

  @override
  void dispose() {
    _tic?.cancel();
    _grabador.dispose();
    _reproductor.dispose();
    super.dispose();
  }

  /// Una toma de esta misma sesión sigue ahí si vuelves a la pantalla.
  Future<void> _buscarTomaPrevia() async {
    final ruta = await _almacen.previa(widget.slot);
    if (ruta != null && mounted) {
      setState(() {
        _ruta = ruta;
        _estado = _Estado.listo;
      });
    }
  }

  Future<void> _grabar() async {
    if (!await _grabador.hasPermission()) {
      if (mounted) setState(() => _estado = _Estado.sinPermiso);
      return;
    }
    final ruta = await _almacen.destino(widget.slot);
    await _reproductor.stop();
    await _grabador.start(await _almacen.config(), path: ruta);
    if (!mounted) return;
    setState(() {
      _estado = _Estado.grabando;
      _segundos = 0;
      _sonando = false;
    });
    _tic = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _segundos++);
    });
  }

  Future<void> _parar() async {
    _tic?.cancel();
    final ruta = await _grabador.stop();
    if (!mounted) return;
    setState(() {
      _ruta = ruta;
      _estado = ruta == null ? _Estado.vacio : _Estado.listo;
    });
  }

  Future<void> _oir() async {
    if (_ruta == null) return;
    if (_sonando) {
      await _reproductor.stop();
      if (mounted) setState(() => _sonando = false);
      return;
    }
    await _reproductor.play(_almacen.fuente(_ruta!));
    if (mounted) setState(() => _sonando = true);
  }

  Future<void> _tirar() async {
    await _reproductor.stop();
    final ruta = _ruta;
    if (ruta != null) await _almacen.borrar(ruta);
    if (mounted) {
      setState(() {
        _ruta = null;
        _sonando = false;
        _estado = _Estado.vacio;
      });
    }
  }

  String get _reloj {
    final m = _segundos ~/ 60;
    final s = (_segundos % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_estado == _Estado.sinPermiso) {
      return Text(
        'The microphone permission was turned down, so there is no recording. '
        'Everything else on this card still works.',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          height: 1.4,
        ),
      );
    }

    return Row(
      children: [
        if (_estado == _Estado.grabando) ...[
          Expanded(
            child: FilledButton.icon(
              onPressed: _parar,
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
              icon: const Icon(Icons.stop_rounded, size: 20),
              label: Text('Stop · $_reloj'),
            ),
          ),
        ] else ...[
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _grabar,
              icon: Icon(Icons.mic_rounded, size: 20, color: widget.color),
              label: Text(
                _estado == _Estado.listo ? 'Record again' : 'Record yourself',
              ),
            ),
          ),
          if (_estado == _Estado.listo) ...[
            const SizedBox(width: 8),
            IconButton.filledTonal(
              onPressed: _oir,
              icon: Icon(
                _sonando ? Icons.stop_rounded : Icons.play_arrow_rounded,
              ),
              tooltip: _sonando ? 'Stop' : 'Listen back',
            ),
            IconButton(
              onPressed: _tirar,
              icon: const Icon(Icons.delete_outline_rounded),
              tooltip: 'Delete the take',
            ),
          ],
        ],
      ],
    );
  }
}
