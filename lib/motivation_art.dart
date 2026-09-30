import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'brand.dart';
import 'state.dart';

enum MotivationScene { celebration, growth, journey }

/// Small ink-and-paper illustrations, drawn locally and animated just once.
/// The message beside the artwork carries its meaning for screen readers.
class MotivationArt extends StatefulWidget {
  const MotivationArt({
    super.key,
    required this.scene,
    this.width = 112,
    this.height = 96,
  });

  final MotivationScene scene;
  final double width;
  final double height;

  @override
  State<MotivationArt> createState() => _MotivationArtState();
}

class _MotivationArtState extends State<MotivationArt>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );
  bool? _motion;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final enabled =
        AppScope.of(context).profile.effects &&
        !MediaQuery.disableAnimationsOf(context) &&
        TickerMode.valuesOf(context).enabled;
    if (_motion == null && enabled) {
      _controller.forward();
    } else if (!enabled) {
      _controller.value = 1;
    }
    // Returning to a tab or rebuilding preferences does not replay the art.
    _motion = enabled;
  }

  @override
  void didUpdateWidget(MotivationArt oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scene != widget.scene && _motion == true) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final dark = colors.brightness == Brightness.dark;
    return ExcludeSemantics(
      child: RepaintBoundary(
        child: ClipRect(
          child: SizedBox(
            width: widget.width,
            height: widget.height,
            child: CustomPaint(
              painter: _MotivationPainter(
                scene: widget.scene,
                animation: _controller,
                ink: colors.onSurface,
                paper: colors.surfaceContainerLowest,
                green: dark ? const Color(0xFF93CCAB) : const Color(0xFF39795E),
                blue: dark ? const Color(0xFF9DBDDD) : const Color(0xFF637F9F),
                dark: dark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MotivationPainter extends CustomPainter {
  _MotivationPainter({
    required this.scene,
    required this.animation,
    required this.ink,
    required this.paper,
    required this.green,
    required this.blue,
    required this.dark,
  }) : super(repaint: animation);

  final MotivationScene scene;
  final Animation<double> animation;
  final Color ink, paper, green, blue;
  final bool dark;

  Paint fill(Color color) => Paint()..color = color;
  Paint line(Color color, [double width = 2]) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = width
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = math.min(size.width / 160, size.height / 136);
    canvas.save();
    canvas.translate(
      (size.width - 160 * scale) / 2,
      (size.height - 136 * scale) / 2,
    );
    canvas.scale(scale);
    final progress = animation.value;
    switch (scene) {
      case MotivationScene.celebration:
        _medal(canvas, progress);
      case MotivationScene.growth:
        _growth(canvas, progress);
      case MotivationScene.journey:
        _journey(canvas, progress);
    }
    canvas.restore();
  }

  void _star(Canvas canvas, Offset center, double radius, Color color) {
    final path = Path();
    for (var i = 0; i < 10; i++) {
      final angle = -math.pi / 2 + i * math.pi / 5;
      final r = i.isEven ? radius : radius * 0.46;
      final p = center + Offset(math.cos(angle), math.sin(angle)) * r;
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    canvas.drawPath(path..close(), fill(color));
  }

  void _spark(Canvas canvas, Offset center, double radius, Color color) {
    final path = Path()
      ..moveTo(center.dx, center.dy - radius)
      ..quadraticBezierTo(
        center.dx + 1,
        center.dy - 1,
        center.dx + radius,
        center.dy,
      )
      ..quadraticBezierTo(
        center.dx + 1,
        center.dy + 1,
        center.dx,
        center.dy + radius,
      )
      ..quadraticBezierTo(
        center.dx - 1,
        center.dy + 1,
        center.dx - radius,
        center.dy,
      )
      ..quadraticBezierTo(
        center.dx - 1,
        center.dy - 1,
        center.dx,
        center.dy - radius,
      )
      ..close();
    canvas.drawPath(path, fill(color));
  }

  void _leaf(Canvas canvas, Offset base, Offset tip, Color color) {
    final delta = tip - base;
    final normal = Offset(-delta.dy, delta.dx) * 0.36;
    final middle = base + delta * 0.5;
    canvas.drawPath(
      Path()
        ..moveTo(base.dx, base.dy)
        ..quadraticBezierTo(
          middle.dx + normal.dx,
          middle.dy + normal.dy,
          tip.dx,
          tip.dy,
        )
        ..quadraticBezierTo(
          middle.dx - normal.dx,
          middle.dy - normal.dy,
          base.dx,
          base.dy,
        )
        ..close(),
      fill(color),
    );
  }

  void _medal(Canvas canvas, double t) {
    canvas.drawCircle(
      const Offset(80, 65),
      49,
      fill(cilGold.withValues(alpha: dark ? 0.10 : 0.12)),
    );
    canvas.drawOval(
      const Rect.fromLTWH(42, 119, 76, 6),
      fill(ink.withValues(alpha: 0.06)),
    );
    // Laurel branches frame the medal; they remain visible after the confetti.
    for (final side in [-1, 1]) {
      canvas.save();
      canvas.translate(80, 0);
      canvas.scale(side.toDouble(), 1);
      canvas.drawPath(
        Path()
          ..moveTo(18, 112)
          ..quadraticBezierTo(59, 95, 47, 61),
        line(green, 2),
      );
      _leaf(canvas, const Offset(34, 104), const Offset(36, 85), green);
      _leaf(canvas, const Offset(43, 94), const Offset(61, 81), green);
      _leaf(canvas, const Offset(47, 83), const Offset(39, 66), green);
      _leaf(canvas, const Offset(48, 73), const Offset(59, 57), green);
      canvas.restore();
    }
    canvas.save();
    canvas.translate(80, 58 - math.sin(t * math.pi) * 6);
    canvas.rotate(math.sin(t * math.pi * 2) * (1 - t) * 0.13);
    final ribbon = Path()
      ..moveTo(-23, 18)
      ..lineTo(-29, 57)
      ..lineTo(-13, 49)
      ..lineTo(-3, 59)
      ..lineTo(6, 20)
      ..close();
    canvas.drawPath(ribbon, fill(blue));
    canvas.drawPath(ribbon, line(ink, 1.8));
    canvas.save();
    canvas.scale(-1, 1);
    canvas.drawPath(ribbon, fill(blue));
    canvas.drawPath(ribbon, line(ink, 1.8));
    canvas.restore();
    canvas.drawCircle(Offset.zero, 33, fill(cilGold));
    canvas.drawCircle(Offset.zero, 33, line(ink, 2.2));
    canvas.drawCircle(
      Offset.zero,
      26,
      line(cilPaper.withValues(alpha: 0.8), 1.5),
    );
    _star(canvas, Offset.zero, 17, cilInk);
    canvas.restore();
    _spark(canvas, const Offset(28, 32), 6, cilGold);
    _spark(canvas, const Offset(126, 26), 8, cilGold);
    canvas.drawCircle(const Offset(136, 48), 2.5, fill(green));
    // One short burst, bounded by the illustration's own canvas.
    if (t > 0 && t < 0.9) {
      final burst = Curves.easeOutCubic.transform((t / 0.9).clamp(0, 1));
      for (var i = 0; i < 12; i++) {
        final angle = i * math.pi / 6;
        final radius = 35 + 29 * burst;
        final p = Offset(
          80 + math.cos(angle) * radius,
          59 + math.sin(angle) * radius * 0.72,
        );
        canvas.save();
        canvas.translate(p.dx, p.dy);
        canvas.rotate(angle + t * 2);
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            const Rect.fromLTWH(-2, -4, 4, 8),
            const Radius.circular(1),
          ),
          fill(
            [
              cilGold,
              green,
              blue,
            ][i % 3].withValues(alpha: (1 - t / 0.9) * 0.9),
          ),
        );
        canvas.restore();
      }
    }
  }

  void _growth(Canvas canvas, double t) {
    canvas.drawCircle(
      const Offset(82, 62),
      45,
      fill(green.withValues(alpha: dark ? 0.10 : 0.08)),
    );
    canvas.drawCircle(
      const Offset(119, 28),
      12,
      fill(cilGold.withValues(alpha: 0.28)),
    );
    _spark(canvas, const Offset(36, 40), 5, cilGold);
    canvas.drawOval(
      const Rect.fromLTWH(24, 116, 113, 6),
      fill(ink.withValues(alpha: 0.06)),
    );
    // A new shoot grows out of an open book: mistakes are part of learning.
    canvas.save();
    canvas.translate(80, 93);
    final grow = 0.72 + 0.28 * Curves.easeOutCubic.transform(t);
    canvas.scale(grow, grow);
    canvas.rotate(math.sin(t * math.pi * 2) * (1 - t) * 0.05);
    canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..cubicTo(-9, -20, 10, -40, 3, -65),
      line(green, 3),
    );
    _leaf(canvas, const Offset(0, -27), const Offset(-28, -48), green);
    _leaf(canvas, const Offset(2, -40), const Offset(30, -64), green);
    _leaf(canvas, const Offset(4, -58), const Offset(-7, -77), green);
    canvas.drawPath(
      Path()
        ..moveTo(-3, -31)
        ..lineTo(-17, -41),
      line(paper.withValues(alpha: 0.55), 1),
    );
    canvas.drawPath(
      Path()
        ..moveTo(8, -46)
        ..lineTo(21, -56),
      line(paper.withValues(alpha: 0.55), 1),
    );
    canvas.restore();
    final cover = Path()
      ..moveTo(24, 83)
      ..quadraticBezierTo(51, 75, 80, 89)
      ..quadraticBezierTo(108, 75, 136, 83)
      ..lineTo(136, 115)
      ..quadraticBezierTo(108, 108, 80, 122)
      ..quadraticBezierTo(52, 108, 24, 115)
      ..close();
    canvas.drawPath(cover, fill(blue));
    canvas.drawPath(cover, line(ink, 2));
    final pages = Path()
      ..moveTo(29, 78)
      ..quadraticBezierTo(56, 74, 80, 87)
      ..quadraticBezierTo(104, 74, 131, 78)
      ..lineTo(131, 108)
      ..quadraticBezierTo(106, 104, 80, 116)
      ..quadraticBezierTo(54, 104, 29, 108)
      ..close();
    canvas.drawPath(pages, fill(paper));
    canvas.drawPath(pages, line(ink, 1.8));
    canvas.drawLine(
      const Offset(80, 87),
      const Offset(80, 116),
      line(ink, 1.5),
    );
    for (var i = 0; i < 3; i++) {
      final y = 88.0 + i * 7;
      canvas.drawPath(
        Path()
          ..moveTo(38, y)
          ..quadraticBezierTo(55, y, 69, y + 6),
        line(blue.withValues(alpha: 0.6), 1.5),
      );
      canvas.drawPath(
        Path()
          ..moveTo(91, y + 6)
          ..quadraticBezierTo(107, y, 122, y),
        line(blue.withValues(alpha: 0.6), 1.5),
      );
    }
    canvas.drawPath(
      Path()
        ..moveTo(112, 80)
        ..lineTo(112, 98)
        ..lineTo(118, 93)
        ..lineTo(122, 96)
        ..lineTo(122, 79)
        ..close(),
      fill(cilGold),
    );
  }

  void _journey(Canvas canvas, double t) {
    canvas.drawCircle(
      const Offset(88, 57),
      45,
      fill(blue.withValues(alpha: 0.09)),
    );
    canvas.drawCircle(
      const Offset(125, 29),
      13,
      fill(cilGold.withValues(alpha: 0.6)),
    );
    canvas.drawPath(
      Path()
        ..moveTo(15, 114)
        ..quadraticBezierTo(48, 80, 76, 109)
        ..quadraticBezierTo(119, 78, 145, 112)
        ..lineTo(145, 121)
        ..lineTo(15, 121)
        ..close(),
      fill(green.withValues(alpha: 0.16)),
    );
    canvas.drawPath(
      Path()
        ..moveTo(21, 120)
        ..quadraticBezierTo(47, 88, 74, 111),
      line(green.withValues(alpha: 0.6), 1.8),
    );
    final flight = Path()
      ..moveTo(24, 106)
      ..cubicTo(81, 89, 18, 59, 58, 57)
      ..cubicTo(89, 56, 76, 83, 67, 75)
      ..cubicTo(59, 67, 96, 42, 115, 40);
    final metric = flight.computeMetrics().first;
    final distance =
        metric.length * (0.2 + 0.8 * Curves.easeInOutCubic.transform(t));
    for (var d = 0.0; d < distance - 14; d += 8) {
      final point = metric.getTangentForOffset(d)!.position;
      canvas.drawCircle(point, 1.3, fill(blue.withValues(alpha: 0.65)));
    }
    final tangent = metric.getTangentForOffset(distance)!;
    canvas.save();
    canvas.translate(tangent.position.dx, tangent.position.dy);
    canvas.rotate(math.atan2(tangent.vector.dy, tangent.vector.dx) + 0.25);
    final plane = Path()
      ..moveTo(19, 0)
      ..lineTo(-19, -16)
      ..lineTo(-10, 0)
      ..lineTo(-19, 14)
      ..close();
    canvas.drawPath(plane, fill(paper));
    canvas.drawPath(
      Path()
        ..moveTo(19, 0)
        ..lineTo(-10, 0)
        ..lineTo(-19, 14)
        ..close(),
      fill(cilGold),
    );
    canvas.drawPath(plane, line(ink, 2));
    canvas.drawLine(const Offset(-10, 0), const Offset(19, 0), line(ink, 1.4));
    canvas.restore();
    _spark(canvas, const Offset(32, 34), 5, cilGold);
    canvas.drawPath(
      Path()
        ..moveTo(103, 105)
        ..lineTo(103, 84)
        ..lineTo(117, 88)
        ..lineTo(103, 94),
      line(green, 2),
    );
  }

  @override
  bool shouldRepaint(_MotivationPainter old) =>
      scene != old.scene ||
      animation != old.animation ||
      ink != old.ink ||
      paper != old.paper ||
      green != old.green ||
      blue != old.blue ||
      dark != old.dark;
}
