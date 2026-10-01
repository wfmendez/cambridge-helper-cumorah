import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../cambridge.dart';
import '../disposicion.dart';

import '../speaking_data.dart';
import '../cambridge_theme.dart';
import '../widgets.dart';
import 'enlace.dart';
import 'recorder.dart';

/// Speaking practice: a clock, a prompt, and the phrases to answer with.
///
/// Nothing here is marked, because nothing here can be. What the app can do is
/// make you talk for the full minute instead of forty seconds, and put the
/// useful language in front of you while you do it.
/// A screen with its own bar, for when this is opened from a mock test. The
/// same list without the bar is [SpeakingBody], which is what the Speaking tab
/// shows.
class SpeakingScreen extends StatelessWidget {
  const SpeakingScreen({super.key, required this.level});

  final ExamLevel level;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Speaking practice')),
    body: SpeakingBody(level: level),
  );
}

class SpeakingBody extends StatelessWidget {
  const SpeakingBody({super.key, required this.level});

  /// Part 2 is a different task at B1 — one photograph to describe, not two
  /// to compare — so the level decides which parts are shown.
  final ExamLevel level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Pagina(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        Seccion(
          explicacion: ContentCard(
            color: cambridgeOrange.withValues(alpha: 0.07),
            border: cambridgeOrange.withValues(alpha: 0.3),
            child: Text(
              'Nobody can mark your speaking but an examiner. What this can do '
              'is hold you to the clock, give you the language, and record you '
              'so that you can hear what an examiner would. Say your answers '
              'out loud — reading them in your head trains nothing.',
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ),
          maxColumnas: 2,
          anchoMinimo: 360,
          rellenoCompacto: const EdgeInsets.only(top: 12),
          children: [
            for (final p in speakingPartsFor(level))
              // La clave lleva el nivel: al cambiar de meta, la tarjeta de la
              // Part 2 es otra tarea y no debe heredar el reloj ni la foto.
              _TarjetaParte(
                key: ValueKey('${level.name}-${p.number}'),
                part: p,
              ),
          ],
        ),
      ],
    );
  }
}

class _TarjetaParte extends StatefulWidget {
  const _TarjetaParte({super.key, required this.part});
  final SpeakingPart part;

  @override
  State<_TarjetaParte> createState() => _TarjetaParteState();
}

class _TarjetaParteState extends State<_TarjetaParte> {
  final _azar = Random();
  late int _indice;
  Timer? _tic;
  int _restan = 0;
  bool _corriendo = false;

  @override
  void initState() {
    super.initState();
    _indice = _azar.nextInt(widget.part.variants);
    _restan = widget.part.seconds;
  }

  @override
  void dispose() {
    _tic?.cancel();
    super.dispose();
  }

  /// Otro distinto del que hay: pulsar "otro" y que salga el mismo parece un
  /// botón roto, y con seis fotos pasaba una vez de cada seis.
  void _otroPrompt() {
    final n = widget.part.variants;
    if (n < 2) return;
    setState(() => _indice = (_indice + 1 + _azar.nextInt(n - 1)) % n);
  }

  void _alternarReloj() {
    if (_corriendo) {
      _tic?.cancel();
      setState(() => _corriendo = false);
      return;
    }
    setState(() {
      _corriendo = true;
      if (_restan == 0) _restan = widget.part.seconds;
    });
    _tic = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() => _restan--);
      if (_restan <= 0) {
        t.cancel();
        setState(() => _corriendo = false);
      }
    });
  }

  void _reiniciar() {
    _tic?.cancel();
    setState(() {
      _corriendo = false;
      _restan = widget.part.seconds;
    });
  }

  String get _reloj {
    final m = _restan ~/ 60;
    final s = (_restan % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = widget.part;
    final color = cambridgeReadable(cambridgeOrange, theme.colorScheme);
    final seAcabo = _restan == 0;

    return ContentCard(
      border: color.withValues(alpha: 0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 4, height: 18, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Part ${p.number} · ${p.name}',
                  style: theme.textTheme.titleSmall,
                ),
              ),
              Text(
                _reloj,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: seAcabo ? cambridgeRed : color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            p.whatToDo,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),
          // The prompt sits on paper, like the card they hand you.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: paperBg,
              border: Border.all(color: paperRule),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.promptAt(_indice),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: paperInk,
                    height: 1.5,
                  ),
                ),
                // La pregunta arriba y las fotos debajo, como en la hoja del
                // examen.
                if (p.photosAt(_indice).isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _Fotos(fotos: p.photosAt(_indice)),
                ],
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _alternarReloj,
                  icon: Icon(
                    _corriendo ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 20,
                  ),
                  label: Text(_corriendo ? 'Pause' : 'Start talking'),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _reiniciar,
                icon: const Icon(Icons.restart_alt_rounded),
                tooltip: 'Reset the clock',
              ),
              IconButton(
                onPressed: _otroPrompt,
                icon: const Icon(Icons.shuffle_rounded),
                tooltip: 'Another prompt',
              ),
            ],
          ),
          const SizedBox(height: 10),
          Grabadora(slot: 'part-${p.number}', color: color),
          if (seAcabo) ...[
            const SizedBox(height: 8),
            Text(
              'Time. Did you fill it, or did you run out of things to say at '
              'forty seconds?',
              style: theme.textTheme.bodySmall?.copyWith(color: cambridgeRed),
            ),
          ],
          const SizedBox(height: 16),
          _Lista(title: 'Ways to start', color: color, items: p.openers),
          if (p.tip != null) ...[
            const SizedBox(height: 14),
            Text(
              p.tip!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.45,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The photograph or photographs of a Part 2 task.
///
/// Two sit side by side when there is room, as on the exam sheet, and one
/// above the other when there is not: at 150 pixels wide nobody can see what
/// is in them.
class _Fotos extends StatelessWidget {
  const _Fotos({required this.fotos});
  final List<SpeakingPhoto> fotos;

  /// La celda tiene que medir esto para que dos fotos lado a lado pasen de
  /// 200 px cada una, descontado el relleno de la tarjeta y del papel.
  static const _celdaParaDos = 480.0;

  @override
  Widget build(BuildContext context) {
    // El ancho se le pregunta a la rejilla y no a un LayoutBuilder: las filas
    // de igual altura miden con IntrinsicHeight, y ahí no puede haber uno.
    final celda =
        AnchoCelda.maybeOf(context) ?? MediaQuery.sizeOf(context).width;
    final piezas = [
      for (final (i, f) in fotos.indexed)
        _Foto(
          foto: f,
          letra: fotos.length > 1 ? String.fromCharCode(65 + i) : null,
        ),
    ];
    if (piezas.length > 1 && celda >= _celdaParaDos) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (i, pieza) in piezas.indexed) ...[
            if (i > 0) const SizedBox(width: 10),
            Expanded(child: pieza),
          ],
        ],
      );
    }
    return Column(
      children: [
        for (final (i, pieza) in piezas.indexed) ...[
          if (i > 0) const SizedBox(height: 10),
          pieza,
        ],
      ],
    );
  }
}

class _Foto extends StatelessWidget {
  const _Foto({required this.foto, this.letra});
  final SpeakingPhoto foto;

  /// A or B when there are two, so the answer can say which one it means.
  final String? letra;

  String get _nombre => letra == null ? 'Photograph' : 'Photograph $letra';

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // La etiqueta dice que es una foto y que se amplía, no lo que hay en
      // ella: describirla es justo el ejercicio.
      // container: sin él la etiqueta y el toque se funden con el nodo de la
      // tarjeta, y un lector de pantalla anuncia la tarjeta entera como un
      // botón que amplía la foto.
      Semantics(
        container: true,
        button: true,
        label: '$_nombre. Tap to enlarge.',
        child: InkWell(
          onTap: () => _ampliar(context),
          child: AspectRatio(
            aspectRatio: 3 / 2,
            // El color de fondo ocupa el sitio mientras la imagen llega, para
            // que la tarjeta no salte de tamaño al cargarla.
            child: ColoredBox(
              color: paperRule,
              child: Image.asset(
                foto.asset,
                fit: BoxFit.cover,
                excludeFromSemantics: true,
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        '${letra == null ? '' : '$letra · '}Photo: ${foto.by} / Unsplash',
        style: const TextStyle(color: paperGrey, fontSize: 11),
      ),
    ],
  );

  void _ampliar(BuildContext context) => showDialog<void>(
    context: context,
    builder: (dialogo) => Dialog(
      insetPadding: const EdgeInsets.all(12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: InteractiveViewer(
              maxScale: 4,
              child: Image.asset(
                foto.asset,
                fit: BoxFit.contain,
                excludeFromSemantics: true,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  // El crédito enlaza con el original: es la forma de
                  // atribución que de verdad le sirve a quien hizo la foto.
                  child: TextButton(
                    onPressed: () => abrirEnlace(foto.page),
                    child: Text('Photo: ${foto.by} / Unsplash'),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(dialogo).pop(),
                icon: const Icon(Icons.close_rounded),
                tooltip: 'Close',
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _Lista extends StatelessWidget {
  const _Lista({required this.title, required this.items, required this.color});

  final String title;
  final List<String> items;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        for (final e in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    e,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.45,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
