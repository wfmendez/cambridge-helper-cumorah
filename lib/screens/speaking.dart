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

/// Speaking practice: a whole test, a clock for each part, and the phrases
/// to answer with.
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

class SpeakingBody extends StatefulWidget {
  const SpeakingBody({super.key, required this.level});

  /// Part 2 is a different task at B1 — one photograph to describe, not two
  /// to compare — so the level decides which parts are shown.
  final ExamLevel level;

  @override
  State<SpeakingBody> createState() => _SpeakingBodyState();
}

class _SpeakingBodyState extends State<SpeakingBody> {
  final _azar = Random();
  late int _test;

  List<SpeakingTest> get _tests => speakingTestsFor(widget.level);

  @override
  void initState() {
    super.initState();
    _test = _azar.nextInt(_tests.length);
  }

  @override
  void didUpdateWidget(SpeakingBody anterior) {
    super.didUpdateWidget(anterior);
    // B2 tiene más tests que los otros dos niveles: el número de antes puede
    // no existir en el nuevo.
    if (anterior.level != widget.level) _test = _azar.nextInt(_tests.length);
  }

  /// Otro distinto del que hay: pulsar "otro" y que salga el mismo parece un
  /// botón roto.
  void _otroTest() {
    final n = _tests.length;
    if (n < 2) return;
    setState(() => _test = (_test + 1 + _azar.nextInt(n - 1)) % n);
  }

  /// Desde el botón del final: el test nuevo empieza arriba, en la Part 1.
  void _otroTestDesdeAbajo(BuildContext context) {
    _otroTest();
    Scrollable.maybeOf(context)?.position.animateTo(
      0,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final test = _tests[_test];

    return Pagina(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        Seccion(
          explicacion: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ContentCard(
                color: cambridgeOrange.withValues(alpha: 0.07),
                border: cambridgeOrange.withValues(alpha: 0.3),
                child: Text(
                  'Nobody can mark your speaking but an examiner. What this '
                  'can do is hold you to the clock, give you the language, and '
                  'record you so that you can hear what an examiner would. Say '
                  'your answers out loud — reading them in your head trains '
                  'nothing.',
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
              ),
              const SizedBox(height: 12),
              _Selector(
                numero: _test + 1,
                de: _tests.length,
                onOtro: _otroTest,
              ),
            ],
          ),
          maxColumnas: 2,
          anchoMinimo: 360,
          rellenoCompacto: const EdgeInsets.only(top: 12),
          children: [
            for (final p in speakingPartsFor(widget.level))
              // La clave lleva el nivel y el test: otro test es otra tarea, y
              // no debe heredar el reloj a medias del anterior.
              _TarjetaParte(
                key: ValueKey('${widget.level.name}-$_test-${p.number}'),
                part: p,
                test: test,
              ),
          ],
        ),
        const SizedBox(height: 8),
        Center(
          child: Builder(
            builder: (context) => OutlinedButton.icon(
              onPressed: () => _otroTestDesdeAbajo(context),
              icon: const Icon(Icons.shuffle_rounded, size: 18),
              label: const Text('Try another test'),
            ),
          ),
        ),
      ],
    );
  }
}

/// Which test this is, and the way to another one.
class _Selector extends StatelessWidget {
  const _Selector({
    required this.numero,
    required this.de,
    required this.onOtro,
  });

  final int numero;
  final int de;
  final VoidCallback onOtro;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = cambridgeReadable(cambridgeOrange, theme.colorScheme);

    return ContentCard(
      border: color.withValues(alpha: 0.35),
      // En columna y no en fila: en escritorio esto va en la franja de 280 de
      // la izquierda, donde el botón al lado del texto no cabe.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Test $numero of $de',
            style: theme.textTheme.titleSmall?.copyWith(color: color),
          ),
          const SizedBox(height: 2),
          Text(
            'All four parts change together. Part 4 follows the topic of '
            'Part 3, as in the exam.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 10),
          FilledButton.tonalIcon(
            onPressed: onOtro,
            icon: const Icon(Icons.shuffle_rounded, size: 18),
            label: const Text('Another test'),
          ),
        ],
      ),
    );
  }
}

class _TarjetaParte extends StatefulWidget {
  const _TarjetaParte({super.key, required this.part, required this.test});
  final SpeakingPart part;
  final SpeakingTest test;

  @override
  State<_TarjetaParte> createState() => _TarjetaParteState();
}

class _TarjetaParteState extends State<_TarjetaParte> {
  Timer? _tic;
  int _restan = 0;
  bool _corriendo = false;

  @override
  void initState() {
    super.initState();
    _restan = widget.part.seconds;
  }

  @override
  void dispose() {
    _tic?.cancel();
    super.dispose();
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

  /// Lo que va en el papel: lo que el examinador pregunta o entrega en esta
  /// parte.
  Widget _tarea(TextStyle? estilo) {
    final t = widget.test;
    return switch (widget.part.number) {
      1 => _Preguntas(preguntas: t.interview, estilo: estilo),
      2 => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // La pregunta arriba y las fotos debajo, como en la hoja del
          // examen.
          Text(t.photos.question, style: estilo),
          const SizedBox(height: 12),
          _Fotos(fotos: t.photos.photos),
        ],
      ),
      3 => _Diagrama(tarea: t.diagram, estilo: estilo),
      _ => _Preguntas(preguntas: t.discussion, estilo: estilo),
    };
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
          // The task sits on paper, like the sheet they hand you.
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: paperBg,
              border: Border.all(color: paperRule),
            ),
            child: _tarea(
              theme.textTheme.bodyLarge?.copyWith(color: paperInk, height: 1.5),
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

/// The questions of Parts 1 and 4, in the order the examiner asks them.
class _Preguntas extends StatelessWidget {
  const _Preguntas({required this.preguntas, required this.estilo});
  final List<String> preguntas;
  final TextStyle? estilo;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final (i, q) in preguntas.indexed) ...[
        if (i > 0) const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 22,
              child: Text(
                '${i + 1}.',
                style: estilo?.copyWith(
                  color: paperGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(child: Text(q, style: estilo)),
          ],
        ),
      ],
    ],
  );
}

/// The Part 3 sheet: the question in a box in the middle, the ideas in boxes
/// around it, a line from each idea to the question.
///
/// Where the card is wide, the ideas sit to the left, to the right and below,
/// as on the exam sheet. On a phone a third of the width is too narrow for
/// “volunteering” to fit on a line, so the ideas go above and below instead,
/// two to a row.
class _Diagrama extends StatelessWidget {
  const _Diagrama({required this.tarea, required this.estilo});
  final DiagramTask tarea;
  final TextStyle? estilo;

  /// Lo que la tarjeta y el papel le quitan de ancho al diagrama.
  static const _relleno = 62.0;

  /// Por debajo de esto, las cajas de los lados no caben.
  static const _anchoAmplio = 430.0;

  static const _enlace = 14.0;
  static const _hueco = 12.0;

  /// Si el diagrama va con las ideas a los lados, dentro de una celda de este
  /// ancho.
  static bool amplio(double celda) => celda - _relleno >= _anchoAmplio;

  @override
  Widget build(BuildContext context) {
    // Como en _Fotos: el ancho se le pregunta a la rejilla, porque las filas
    // de igual altura miden con IntrinsicHeight y ahí no cabe un LayoutBuilder.
    final celda =
        AnchoCelda.maybeOf(context) ?? MediaQuery.sizeOf(context).width;
    final ideas = tarea.options;
    final dibujo = amplio(celda) ? _aLosLados(ideas) : _arribaYAbajo(ideas);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (tarea.situation != null) ...[
          Text(tarea.situation!, style: estilo),
          const SizedBox(height: 12),
        ],
        // Un lector de pantalla no puede seguir las líneas: se le lee la
        // pregunta y después las ideas, en orden.
        Semantics(
          container: true,
          label: '${tarea.question} Ideas: ${ideas.join(', ')}.',
          child: ExcludeSemantics(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: dibujo,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Then decide: ',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              TextSpan(text: tarea.decision),
            ],
          ),
          style: estilo,
        ),
      ],
    );
  }

  /// Como en la hoja: ideas a izquierda y derecha, y la que sobra debajo.
  Widget _aLosLados(List<String> ideas) {
    final abajo = ideas.length.isOdd ? ideas.last : null;
    final resto = abajo == null ? ideas : ideas.sublist(0, ideas.length - 1);
    final izquierda = [for (var i = 0; i < resto.length; i += 2) resto[i]];
    final derecha = [for (var i = 1; i < resto.length; i += 2) resto[i]];

    Widget columna(List<String> textos) => Column(
      children: [
        for (final (i, t) in textos.indexed) ...[
          if (i > 0) const SizedBox(height: _hueco),
          Expanded(child: _Caja(texto: t)),
        ],
      ],
    );

    // Una raya a la altura de cada caja del lado.
    Widget rayas(int cuantas) => SizedBox(
      width: _enlace,
      child: Column(
        children: [
          for (var i = 0; i < cuantas; i++) ...[
            if (i > 0) const SizedBox(height: _hueco),
            const Expanded(child: Center(child: _Raya.horizontal())),
          ],
        ],
      ),
    );

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 3, child: columna(izquierda)),
              rayas(izquierda.length),
              Expanded(
                flex: 4,
                child: _Caja(texto: tarea.question, central: true),
              ),
              rayas(derecha.length),
              Expanded(flex: 3, child: columna(derecha)),
            ],
          ),
        ),
        if (abajo != null)
          Row(
            children: [
              const Spacer(flex: 3),
              const SizedBox(width: _enlace),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    const _Raya.vertical(),
                    _Caja(texto: abajo),
                  ],
                ),
              ),
              const SizedBox(width: _enlace),
              const Spacer(flex: 3),
            ],
          ),
      ],
    );
  }

  /// En un teléfono: dos ideas encima, la pregunta a todo lo ancho, dos
  /// debajo y la quinta debajo de esas, colgada de una raya que baja desde la
  /// pregunta por el hueco entre las dos.
  Widget _arribaYAbajo(List<String> ideas) {
    final arriba = ideas.take(2).toList();
    final abajo = ideas.skip(2).take(2).toList();
    final ultima = ideas.length > 4 ? ideas[4] : null;

    // Dos cajas de igual altura, y entre ellas el hueco, con la raya que pasa
    // hacia la última si la hay.
    Widget par(List<String> textos, {bool pasa = false}) => IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, t) in textos.indexed) ...[
            if (i > 0)
              SizedBox(
                width: _hueco,
                child: pasa
                    ? const Center(child: _Raya.vertical(alto: null))
                    : null,
              ),
            Expanded(child: _Caja(texto: t)),
          ],
        ],
      ),
    );

    // Las rayas cortas entre un par y la pregunta, una por caja, más la del
    // centro cuando sigue hacia la última.
    Widget rayas(int cuantas, {bool centro = false}) => Row(
      children: [
        for (var i = 0; i < cuantas; i++) ...[
          if (i > 0)
            SizedBox(
              width: _hueco,
              child: centro ? const Center(child: _Raya.vertical()) : null,
            ),
          const Expanded(child: Center(child: _Raya.vertical())),
        ],
      ],
    );

    final pasa = ultima != null && abajo.length == 2;
    return Column(
      children: [
        if (arriba.isNotEmpty) ...[par(arriba), rayas(arriba.length)],
        _Caja(texto: tarea.question, central: true),
        if (abajo.isNotEmpty) ...[
          rayas(abajo.length, centro: pasa),
          par(abajo, pasa: pasa),
        ],
        if (ultima != null) ...[
          const _Raya.vertical(),
          FractionallySizedBox(widthFactor: 0.5, child: _Caja(texto: ultima)),
        ],
      ],
    );
  }
}

class _Caja extends StatelessWidget {
  const _Caja({required this.texto, this.central = false});
  final String texto;

  /// La de la pregunta, más marcada que las de las ideas.
  final bool central;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(
      horizontal: central ? 12 : 8,
      vertical: central ? 14 : 12,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(central ? 14 : 12),
      border: Border.all(
        color: central ? paperGrey : paperRule,
        width: central ? 1.6 : 1.2,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1F000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Center(
      child: Text(
        texto,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: paperInk,
          fontSize: central ? 14.5 : 13.5,
          height: 1.35,
          fontWeight: central ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    ),
  );
}

/// The line that joins an idea to the question.
class _Raya extends StatelessWidget {
  const _Raya.horizontal() : vertical = false, alto = null;

  /// Sin [alto], ocupa todo el alto que tiene.
  const _Raya.vertical({this.alto = 14}) : vertical = true;

  final bool vertical;
  final double? alto;

  // Sin el lado largo fijado, el Container se estira hasta donde le dejen; un
  // double.infinity haría que IntrinsicHeight midiera una altura infinita.
  @override
  Widget build(BuildContext context) => vertical
      ? Container(width: 1.4, height: alto, color: paperGrey)
      : Container(height: 1.4, color: paperGrey);
}

/// The photograph or photographs of a Part 2 task.
///
/// Two sit side by side when there is room, as on the exam sheet, and one
/// above the other when there is not: at 150 pixels wide nobody can see what
/// is in them.
class _Fotos extends StatelessWidget {
  const _Fotos({required this.fotos});
  final List<SpeakingPhoto> fotos;

  /// Lo que la tarjeta y el papel le quitan de ancho a las fotos.
  static const _relleno = 62.0;
  static const _hueco = 10.0;

  /// Por debajo de esto una foto no se ve lo bastante para compararla.
  static const _anchoMinimo = 200.0;

  /// Si las fotos caben en fila dentro de una celda de este ancho. Vale igual
  /// para las dos de B2 que para las tres de C1.
  static bool enFila(int fotos, double celda) =>
      fotos > 1 &&
      (celda - _relleno - _hueco * (fotos - 1)) / fotos >= _anchoMinimo;

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
    if (enFila(piezas.length, celda)) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (i, pieza) in piezas.indexed) ...[
            if (i > 0) const SizedBox(width: _hueco),
            Expanded(child: pieza),
          ],
        ],
      );
    }
    return Column(
      children: [
        for (final (i, pieza) in piezas.indexed) ...[
          if (i > 0) const SizedBox(height: _hueco),
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
