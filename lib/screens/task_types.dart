import 'package:flutter/material.dart';

import '../disposicion.dart';

import '../cambridge_tasks.dart';
import '../cambridge_theme.dart';
import '../widgets.dart';

/// The glossary of task types, each with a worked example.
///
/// It sits before the practice on purpose: you cannot train properly for a
/// task whose name you do not understand, and Cambridge's instructions never
/// explain what a *cloze* or a *gapped text* is.
class TaskTypesScreen extends StatelessWidget {
  const TaskTypesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('How the tasks work')),
      body: Pagina(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          ContentCard(
            color: cambridgeBlue.withValues(alpha: 0.07),
            border: cambridgeBlue.withValues(alpha: 0.3),
            child: Text(
              'Every Cambridge paper is built from a fixed set of task types, '
              'and the instructions assume you already know their names. '
              'Here is each one: what it looks like, what it is really '
              'testing, a worked example, and what changes at C1.',
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ),
          const SizedBox(height: 6),
          for (final (i, t) in taskTypes.indexed)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: _FichaTarea(
                tarea: t,
                color: cambridgePalette[i % cambridgePalette.length],
              ),
            ),
        ],
      ),
    );
  }
}

class _FichaTarea extends StatefulWidget {
  const _FichaTarea({required this.tarea, required this.color});

  final TaskType tarea;
  final Color color;

  @override
  State<_FichaTarea> createState() => _FichaTareaState();
}

class _FichaTareaState extends State<_FichaTarea> {
  bool _abierta = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = widget.tarea;
    final color = cambridgeReadable(widget.color, theme.colorScheme);

    return ContentCard(
      border: color.withValues(alpha: 0.35),
      onTap: () => setState(() => _abierta = !_abierta),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 4,
                height: 34,
                margin: const EdgeInsets.only(right: 12),
                color: color,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.name, style: theme.textTheme.titleSmall),
                    const SizedBox(height: 2),
                    Text(
                      t.where,
                      style: theme.textTheme.bodySmall?.copyWith(color: color),
                    ),
                  ],
                ),
              ),
              Icon(
                _abierta
                    ? Icons.keyboard_arrow_up_rounded
                    : Icons.keyboard_arrow_down_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            t.whatItIs,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
          if (_abierta) ...[
            const SizedBox(height: 16),
            _Apartado(title: 'What it tests', text: t.whatItTests),
            const SizedBox(height: 14),
            Text(
              'EXAMPLE',
              style: theme.textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 6),
            // The example sits on paper: it is what the booklet looks like.
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
                    t.example,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: paperInk,
                      height: 1.55,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        size: 17,
                        color: cambridgeGreen,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          t.respuesta,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: paperInk,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _Apartado(title: 'Why', text: t.why),
            if (t.trick != null) ...[
              const SizedBox(height: 14),
              _Apartado(
                title: 'The trick',
                text: t.trick!,
                color: ambarCambridge(theme),
              ),
            ],
            if (t.atC1 != null) ...[
              const SizedBox(height: 14),
              _Apartado(
                title: 'At C1',
                text: t.atC1!,
                color: cambridgeReadable(cambridgePurple, theme.colorScheme),
              ),
            ],
          ],
        ],
      ),
    );
  }

  static Color ambarCambridge(ThemeData theme) =>
      cambridgeReadable(cambridgeOrange, theme.colorScheme);
}

class _Apartado extends StatelessWidget {
  const _Apartado({required this.title, required this.text, this.color});

  final String title;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final c = color ?? theme.colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: c,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.5,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
