import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../speaking_data.dart';
import '../cambridge_theme.dart';
import '../widgets.dart';
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
  const SpeakingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Speaking practice')),
    body: const SpeakingBody(),
  );
}

class SpeakingBody extends StatelessWidget {
  const SpeakingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        ContentCard(
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
        for (final p in speakingParts)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: _TarjetaParte(part: p),
          ),
      ],
    );
  }
}

class _TarjetaParte extends StatefulWidget {
  const _TarjetaParte({required this.part});
  final SpeakingPart part;

  @override
  State<_TarjetaParte> createState() => _TarjetaParteState();
}

class _TarjetaParteState extends State<_TarjetaParte> {
  final _azar = Random();
  late String _prompt;
  Timer? _tic;
  int _restan = 0;
  bool _corriendo = false;

  @override
  void initState() {
    super.initState();
    _prompt = widget.part.prompts[_azar.nextInt(widget.part.prompts.length)];
    _restan = widget.part.seconds;
  }

  @override
  void dispose() {
    _tic?.cancel();
    super.dispose();
  }

  void _otroPrompt() {
    setState(() {
      _prompt = widget.part.prompts[_azar.nextInt(widget.part.prompts.length)];
    });
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
            child: Text(
              _prompt,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: paperInk,
                height: 1.5,
              ),
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
