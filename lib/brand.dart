/// What makes Cíl look like Cíl and not like a default Flutter app.
///
/// Three things carry the identity, and they are used everywhere:
///
/// 1. **The mark** — a target with the shot arcing into it. *Cíl* means
///    goal, and a goal is something you are on your way to, not something
///    you look at: the gold line is the point of the logo. The same rings
///    come back as the progress indicator and as the bullet in front of a
///    heading. One idea, reused, reads as design; three different ideas read
///    as decoration.
/// 2. **The typefaces** — Fraunces for anything that announces something, and
///    Inter for everything you actually read. A serif on the headings is what
///    stops an exam app from looking like a settings screen.
/// 3. **The rule** — a 3px vertical bar to the left of a card, in the colour
///    of whatever that card is about.
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Ink, paper and gold.
///
/// The old deep blue came over from Píle and was the same blue every app
/// uses. This palette is chosen against Cambridge's own six colours rather
/// than alongside them: those six are saturated mid-tones used to tell the
/// papers apart, so the brand needs somewhere they are not. Nothing in their
/// range is dark, and nothing is warm-neutral.
///
/// Ink and paper also happen to be what the app is about.
const Color cilInk = Color(0xFF12203A);
const Color cilGold = Color(0xFFE3A72F);
const Color cilPaper = Color(0xFFFAF7F0);

/// A softer ink for surfaces that sit on top of the background in dark mode.
const Color cilInkLift = Color(0xFF1B2C4A);

/// Kept so older references still resolve; new code uses [cilInk].
const Color cilAzul = cilInk;

/// The display face: used for the app name, screen titles and numbers that
/// matter. Fraunces has a “wonk” to it that keeps it from feeling corporate.
const String caraTitular = 'Fraunces';

/// The reading face. Boring on purpose — it is carrying the explanations.
const String caraTexto = 'Inter';

/// The version shown on screen, so that a student can tell you which build
/// they are running and you can tell whether it is the current one.
///
/// A test checks it against pubspec.yaml, which is the number that actually
/// goes into the APK: two places to change, but never two different answers.
const String cilVersion = '1.2.0';

/// Variable-font weights. These have to be requested explicitly: setting
/// `fontWeight` alone leaves a variable font on its default instance.
List<FontVariation> peso(double w) => [FontVariation('wght', w)];

/// The Cíl mark: a target, and the shot going into it.
///
/// Drawn rather than shipped as an image so it takes the colour it is given
/// and stays sharp at any size. The numbers are the same ones `marca.py`
/// uses for the launcher icon — the icon and the mark on screen are one
/// drawing described twice, so a change here needs the same change there.
class MarcaCil extends StatelessWidget {
  const MarcaCil({
    super.key,
    this.size = 24,
    this.color,
    this.accent,
    this.progress,
    this.vuelo = 1,
    this.simple,
  });

  final double size;
  final Color? color;

  /// The shot: the trajectory and the arrowhead. Gold unless told otherwise.
  final Color? accent;

  /// 0–1 turns the outer ring into an arc, so the mark doubles as a progress
  /// indicator. Null draws the ring closed.
  final double? progress;

  /// How far along its flight the arrow is. 1 has it in the middle.
  final double vuelo;

  /// Rings and a gold centre, without the shot.
  ///
  /// Below about 20px the trajectory is two stray pixels and the arrowhead a
  /// smudge, so the small sizes drop them — the same reason a favicon is not
  /// the logo shrunk. Pass it explicitly to force one or the other.
  final bool? simple;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PintorMarca(
          color: color ?? Theme.of(context).colorScheme.onSurface,
          accent: accent,
          progress: progress,
          vuelo: vuelo,
          simple: simple ?? size < 20,
        ),
      ),
    );
  }
}

// Fracciones del lado. Espejo de las constantes de marca.py.
const double _rFuera = 0.355, _wFuera = 0.085;
const double _rDentro = 0.195, _wDentro = 0.075;
const double _wTiro = 0.058, _hueco = 0.028, _punta = 0.155;

class _PintorMarca extends CustomPainter {
  _PintorMarca({
    required this.color,
    required this.vuelo,
    required this.simple,
    this.accent,
    this.progress,
  });

  final Color color;
  final Color? accent;
  final double? progress;
  final double vuelo;
  final bool simple;

  @override
  void paint(Canvas canvas, Size size) {
    final n = size.width;
    final centro = Offset(n / 2, n / 2);
    final oro = accent ?? cilGold;

    Paint trazo(Color c, double w) => Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * n
      ..strokeCap = StrokeCap.round;

    // Todo va en una capa aparte para poder abrir hueco con BlendMode.clear
    // donde el tiro cruza un anillo. Sin ese hueco el oro se apoya encima y
    // el dibujo se lee como dos cosas apiladas; con él, la flecha atraviesa.
    canvas.saveLayer(Offset.zero & size, Paint());

    if (progress != null) {
      canvas.drawCircle(
        centro,
        _rFuera * n,
        trazo(color.withValues(alpha: 0.16), _wFuera),
      );
      canvas.drawArc(
        Rect.fromCircle(center: centro, radius: _rFuera * n),
        -math.pi / 2,
        2 * math.pi * progress!.clamp(0.0, 1.0),
        false,
        trazo(color, _wFuera),
      );
    } else {
      canvas.drawCircle(centro, _rFuera * n, trazo(color, _wFuera));
    }
    canvas.drawCircle(centro, _rDentro * n, trazo(color, _wDentro));

    if (simple) {
      canvas.drawCircle(centro, _wDentro * n * 0.8, Paint()..color = oro);
      canvas.restore();
      return;
    }

    // El tiro: entra por abajo a la izquierda, arqueado, y acaba en el
    // centro. Empieza fuera del lienzo a propósito, para que la línea entre
    // en el icono en vez de empezar dentro de él.
    final camino = Path()
      ..moveTo(-0.030 * n, 0.880 * n)
      ..quadraticBezierTo(0.180 * n, 0.400 * n, 0.500 * n, 0.500 * n);
    final metrica = camino.computeMetrics().first;
    final recorrido = metrica.length * vuelo.clamp(0.0, 1.0);
    final morro = metrica.getTangentForOffset(recorrido);
    if (morro == null || recorrido <= 0) {
      canvas.restore();
      return;
    }
    final cuerpo = math.max(0.0, recorrido - _punta * n * 0.62);

    // Se ensancha al llegar. Flutter no sabe estrechar un trazo, así que van
    // tres tramos de anchura creciente; con cabos redondos no se ve la
    // unión. Los huecos se abren todos antes de pintar el oro, porque si no
    // el hueco de un tramo se comería el oro del anterior.
    const reparto = [0.0, 0.45, 0.75, 1.0];
    const anchos = [0.45, 0.72, 1.0];
    final tramos = [
      for (var i = 0; i < 3; i++)
        metrica.extractPath(cuerpo * reparto[i], cuerpo * reparto[i + 1]),
    ];
    for (var i = 0; i < 3; i++) {
      canvas.drawPath(
        tramos[i],
        Paint()
          ..blendMode = BlendMode.clear
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = (_wTiro * anchos[i] + _hueco * 2) * n,
      );
    }
    for (var i = 0; i < 3; i++) {
      canvas.drawPath(tramos[i], trazo(oro, _wTiro * anchos[i]));
    }

    final punta = _punta * n;
    Path cabeza(double largo) {
      final a = math.atan2(morro.vector.dy, morro.vector.dx);
      Offset en(double giro, double d) =>
          morro.position +
          Offset(math.cos(a + giro) * d, math.sin(a + giro) * d);
      final ala = math.pi - _rad(24);
      return Path()
        ..moveTo(morro.position.dx, morro.position.dy)
        ..lineTo(en(ala, largo).dx, en(ala, largo).dy)
        ..lineTo(en(math.pi, largo * 0.46).dx, en(math.pi, largo * 0.46).dy)
        ..lineTo(en(-ala, largo).dx, en(-ala, largo).dy)
        ..close();
    }

    canvas.drawPath(
      cabeza(punta + _hueco * 1.4 * n),
      Paint()..blendMode = BlendMode.clear,
    );
    canvas.drawPath(cabeza(punta), Paint()..color = oro);
    canvas.restore();
  }

  static double _rad(double grados) => grados * math.pi / 180;

  @override
  bool shouldRepaint(_PintorMarca old) =>
      old.color != color ||
      old.progress != progress ||
      old.vuelo != vuelo ||
      old.simple != simple ||
      old.accent != accent;
}

/// The masthead: the mark, the name, and what the name means.
///
/// Every screen that is not the answer sheet starts with this, so the app
/// introduces itself the same way each time.
class Cabecera extends StatelessWidget {
  const Cabecera({super.key, required this.subtitulo, this.trailing});

  final String subtitulo;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4, right: 12),
          child: const MarcaAnimada(size: 34),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cíl es la palabra corta, la del icono; el nombre entero va
              // al lado porque es el que se entiende. Es un Wrap y no un Row
              // porque con el texto al 160 % los dos juntos no caben, y un
              // Row se sale de la pantalla en vez de bajar de línea.
              Wrap(
                spacing: 8,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Text('Cíl', style: theme.textTheme.headlineMedium),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      'My English Goal',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                subtitulo,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

/// A heading with the mark in front of it, small.
///
/// Replaces the plain small-caps label so that even a section title carries
/// the identity.
class TituloMarcado extends StatelessWidget {
  const TituloMarcado(this.texto, {super.key, this.color, this.trailing});

  final String texto;
  final Color? color;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = color ?? theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 26, bottom: 10),
      child: Row(
        children: [
          MarcaCil(size: 13, color: c),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              texto.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                // Un color pedido tiñe también el texto, no solo la marca:
                // teñir un símbolo de 13 px no distingue nada de lejos. Sin
                // color pedido se queda gris, que es como está el resto.
                color: color == null ? theme.colorScheme.onSurfaceVariant : c,
                letterSpacing: 1.3,
                fontVariations: peso(700),
              ),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

/// The mark, drawing itself once when it appears.
///
/// Used where the app introduces itself — the welcome, the masthead. It is a
/// short animation on purpose: anything longer than about a second stops
/// being a flourish and starts being a wait.
class MarcaAnimada extends StatefulWidget {
  const MarcaAnimada({super.key, this.size = 34, this.color, this.accent});

  final double size;
  final Color? color;
  final Color? accent;

  @override
  State<MarcaAnimada> createState() => _MarcaAnimadaState();
}

class _MarcaAnimadaState extends State<MarcaAnimada>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1050),
  )..forward();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  /// Recorta un tramo de la animación y lo devuelve como 0–1.
  double _tramo(double desde, double hasta) =>
      ((_c.value - desde) / (hasta - desde)).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      // Primero se cierra el anillo, luego entra la flecha y se solapan un
      // poco: la diana existe antes de que le disparen.
      builder: (_, _) => MarcaCil(
        size: widget.size,
        color: widget.color,
        accent: widget.accent,
        progress: Curves.easeOutCubic.transform(_tramo(0, 0.62)),
        vuelo: Curves.easeInOutCubic.transform(_tramo(0.34, 1)),
      ),
    );
  }
}

/// Illustrations for the walkthrough and the empty states.
///
/// Drawn from the same parts as the mark — rings, rules, a sheet of paper —
/// rather than dropped in as stock art. Stock illustrations are the fastest
/// way to make an app look like every other app.
enum Escena { meta, practica, simulacro, escribir, privado }

class Ilustracion extends StatelessWidget {
  const Ilustracion({
    super.key,
    required this.escena,
    required this.color,
    this.size = 150,
  });

  final Escena escena;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: size,
      child: CustomPaint(
        painter: _PintorEscena(
          escena: escena,
          color: color,
          tenue: theme.colorScheme.outlineVariant,
          papel: theme.colorScheme.surfaceContainerLowest,
        ),
      ),
    );
  }
}

class _PintorEscena extends CustomPainter {
  _PintorEscena({
    required this.escena,
    required this.color,
    required this.tenue,
    required this.papel,
  });

  final Escena escena;
  final Color color;
  final Color tenue;
  final Color papel;

  @override
  void paint(Canvas canvas, Size size) {
    final h = size.height;
    final cx = size.width / 2;

    Paint linea(Color c, double w) => Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = w
      ..strokeCap = StrokeCap.round;
    Paint relleno(Color c) => Paint()..color = c;

    switch (escena) {
      case Escena.meta:
        // Tres dianas de tamaño creciente: los tres niveles.
        for (var i = 0; i < 3; i++) {
          final r = h * (0.16 + i * 0.075);
          final x = cx + (i - 1) * h * 0.42;
          final c = i == 2 ? color : tenue;
          canvas.drawCircle(Offset(x, h / 2), r, linea(c, h * 0.045));
          canvas.drawCircle(Offset(x, h / 2), r * 0.42, linea(c, h * 0.04));
          if (i == 2) {
            canvas.drawCircle(Offset(x, h / 2), r * 0.14, relleno(cilGold));
          }
        }

      case Escena.practica:
        // Una pila de tarjetas con una marca encima.
        for (var i = 2; i >= 0; i--) {
          final r = RRect.fromRectAndRadius(
            Rect.fromCenter(
              center: Offset(cx + i * h * 0.05, h / 2 + i * h * 0.06),
              width: h * 0.95,
              height: h * 0.5,
            ),
            Radius.circular(h * 0.06),
          );
          canvas.drawRRect(r, relleno(i == 0 ? papel : tenue));
          canvas.drawRRect(r, linea(i == 0 ? color : tenue, h * 0.022));
        }
        for (var i = 0; i < 3; i++) {
          final y = h / 2 - h * 0.11 + i * h * 0.1;
          canvas.drawLine(
            Offset(cx - h * 0.33, y),
            Offset(cx + h * (i == 2 ? 0.05 : 0.28), y),
            linea(tenue, h * 0.03),
          );
        }
        canvas.drawCircle(
          Offset(cx + h * 0.3, h / 2 + h * 0.1),
          h * 0.055,
          relleno(cilGold),
        );

      case Escena.simulacro:
        // Una hoja rayada y un reloj.
        final hoja = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(cx - h * 0.12, h / 2),
            width: h * 0.62,
            height: h * 0.82,
          ),
          Radius.circular(h * 0.03),
        );
        canvas.drawRRect(hoja, relleno(papel));
        canvas.drawRRect(hoja, linea(color, h * 0.025));
        for (var i = 0; i < 6; i++) {
          final y = h * 0.2 + i * h * 0.11;
          canvas.drawLine(
            Offset(cx - h * 0.38, y),
            Offset(cx + h * (i.isEven ? 0.1 : 0.02), y),
            linea(tenue, h * 0.028),
          );
        }
        final reloj = Offset(cx + h * 0.36, h * 0.62);
        canvas.drawCircle(reloj, h * 0.19, linea(color, h * 0.04));
        canvas.drawLine(
          reloj,
          reloj + Offset(0, -h * 0.11),
          linea(cilGold, h * 0.035),
        );
        canvas.drawLine(
          reloj,
          reloj + Offset(h * 0.08, 0),
          linea(cilGold, h * 0.035),
        );

      case Escena.escribir:
        // Una hoja con el contador de palabras como anillo.
        final hoja = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(cx - h * 0.08, h / 2),
            width: h * 0.7,
            height: h * 0.86,
          ),
          Radius.circular(h * 0.03),
        );
        canvas.drawRRect(hoja, relleno(papel));
        canvas.drawRRect(hoja, linea(color, h * 0.025));
        for (var i = 0; i < 7; i++) {
          final y = h * 0.16 + i * h * 0.1;
          canvas.drawLine(
            Offset(cx - h * 0.38, y),
            Offset(cx + h * (i == 6 ? -0.08 : 0.18), y),
            linea(tenue, h * 0.026),
          );
        }
        final anillo = Offset(cx + h * 0.38, h * 0.66);
        canvas.drawCircle(anillo, h * 0.17, linea(tenue, h * 0.05));
        canvas.drawArc(
          Rect.fromCircle(center: anillo, radius: h * 0.17),
          -1.5708,
          4.4,
          false,
          linea(cilGold, h * 0.05),
        );

      case Escena.privado:
        // Un teléfono con la diana dentro y nada saliendo de él.
        final tel = RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset(cx, h / 2),
            width: h * 0.52,
            height: h * 0.9,
          ),
          Radius.circular(h * 0.09),
        );
        canvas.drawRRect(tel, relleno(papel));
        canvas.drawRRect(tel, linea(color, h * 0.03));
        canvas.drawCircle(Offset(cx, h / 2), h * 0.15, linea(color, h * 0.04));
        canvas.drawCircle(Offset(cx, h / 2), h * 0.05, relleno(cilGold));
        // Dos arcos que no llegan: nada sale del teléfono.
        for (final lado in [-1.0, 1.0]) {
          for (var i = 1; i <= 2; i++) {
            final r = h * (0.36 + i * 0.12);
            canvas.drawArc(
              Rect.fromCircle(center: Offset(cx, h / 2), radius: r),
              lado > 0 ? -0.6 : 2.54,
              1.2,
              false,
              linea(tenue.withValues(alpha: 0.55), h * 0.025),
            );
          }
        }
    }
  }

  @override
  bool shouldRepaint(_PintorEscena old) =>
      old.escena != escena || old.color != color;
}
