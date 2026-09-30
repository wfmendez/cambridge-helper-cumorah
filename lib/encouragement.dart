import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'motivation_art.dart';
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
    final art = MotivationArt(
      scene: celebrate ? MotivationScene.celebration : MotivationScene.growth,
      width: 112,
      height: 96,
    );
    final heading = Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(color: colour),
    );
    final body = Text(message, style: theme.textTheme.bodyMedium);
    return Semantics(
      liveRegion: true,
      child: ContentCard(
        color: celebrate
            ? colour.withValues(alpha: 0.07)
            : theme.colorScheme.secondaryContainer.withValues(alpha: 0.5),
        border: colour.withValues(alpha: 0.25),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final largeText = MediaQuery.textScalerOf(context).scale(16) > 22;
            if (constraints.maxWidth >= 480 && !largeText) {
              return Row(
                children: [
                  art,
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [heading, const SizedBox(height: 8), body],
                    ),
                  ),
                ],
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (largeText) ...[
                  Center(child: art),
                  const SizedBox(height: 8),
                  heading,
                ] else
                  Row(
                    children: [
                      art,
                      const SizedBox(width: 12),
                      Expanded(child: heading),
                    ],
                  ),
                const SizedBox(height: 8),
                body,
              ],
            );
          },
        ),
      ),
    );
  }
}
