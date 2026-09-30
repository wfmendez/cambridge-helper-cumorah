import 'dart:async';
import 'dart:math' as math;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'brand.dart';
import 'state.dart';
import 'theme.dart';
import 'widgets.dart';

String addressed(String message, String name) =>
    name.isEmpty ? message : '$message, $name';

String answerEncouragement({
  required bool correct,
  required int index,
  required int streak,
  required String name,
}) {
  if (correct && streak >= 3 && streak % 3 == 0) {
    return addressed('$streak in a row — well done', name);
  }
  final phrases = correct
      ? ['Well done', 'You got it', 'Nice work', 'One step forward']
      : [
          'Keep going',
          'You can learn from this',
          'Give yourself time',
          'This is part of learning',
        ];
  return addressed(phrases[index % phrases.length], name);
}

String sessionEncouragement(int correct, int total, String name) {
  if (correct == total && total > 0) {
    return addressed('Excellent work', name);
  }
  if (total > 0 && correct / total >= 0.7) {
    return addressed('Your practice is paying off', name);
  }
  return addressed('Every attempt is a step forward', name);
}

/// Optional, brief sounds. A playback failure must never interrupt an answer.
class FeedbackSounds {
  AudioPlayer? _player;
  bool _disposed = false;

  Future<void> play({
    required bool enabled,
    bool correct = true,
    bool milestone = false,
  }) async {
    if (!enabled || _disposed) return;
    try {
      final player = _player ??= AudioPlayer();
      await player.stop();
      if (_disposed) return;
      await player.play(
        AssetSource(
          'sounds/${milestone
              ? 'celebrate'
              : correct
              ? 'correct'
              : 'try-again'}.wav',
        ),
        volume: 0.3,
      );
    } catch (_) {
      // Browsers may decline audio; the same feedback is always visible.
    }
  }

  void dispose() {
    _disposed = true;
    final player = _player;
    if (player != null) unawaited(player.dispose());
  }
}

class EncouragementCard extends StatelessWidget {
  const EncouragementCard({
    super.key,
    required this.title,
    required this.message,
    this.celebrate = false,
  });

  final String title;
  final String message;
  final bool celebrate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colour = celebrate
        ? byBrightness(
            theme.colorScheme,
            light: const Color(0xFF166534),
            dark: const Color(0xFF86EFAC),
          )
        : theme.colorScheme.onSecondaryContainer;
    final animate =
        celebrate &&
        AppScope.of(context).profile.effects &&
        !MediaQuery.disableAnimationsOf(context) &&
        TickerMode.valuesOf(context).enabled;
    return Semantics(
      liveRegion: true,
      child: ContentCard(
        color: celebrate
            ? colour.withValues(alpha: 0.07)
            : theme.colorScheme.secondaryContainer.withValues(alpha: 0.5),
        border: colour.withValues(alpha: 0.25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (celebrate)
              ExcludeSemantics(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: animate ? 0 : 1, end: 1),
                  duration: Duration(milliseconds: animate ? 900 : 0),
                  builder: (_, value, child) => SizedBox(
                    height: 68,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: _CelebrationPainter(value, colour),
                      child: Center(child: child),
                    ),
                  ),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    color: colour,
                    size: 32,
                  ),
                ),
              ),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(color: colour),
            ),
            const SizedBox(height: 8),
            Text(message, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _CelebrationPainter extends CustomPainter {
  _CelebrationPainter(this.progress, this.colour);
  final double progress;
  final Color colour;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= 1) return;
    final centre = Offset(size.width / 2, size.height / 2);
    for (var i = 0; i < 12; i++) {
      final angle = i * math.pi / 6;
      final radius = 20 + 30 * Curves.easeOut.transform(progress);
      final offset = Offset(
        math.cos(angle) * radius * 1.6,
        math.sin(angle) * radius * 0.55,
      );
      final paint = Paint()
        ..color = (i.isEven ? colour : cilGold).withValues(
          alpha: (1 - progress) * 0.85,
        )
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(centre + offset, centre + offset * 1.12, paint);
    }
  }

  @override
  bool shouldRepaint(_CelebrationPainter old) =>
      progress != old.progress || colour != old.colour;
}
