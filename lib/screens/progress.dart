/// What you have done so far.
///
/// Every mock test was already being saved — score, date, minutes and the
/// answers themselves — and nothing ever read it back. A practice app that
/// cannot show you whether you are improving is a workbook with a battery.
///
/// The per-part breakdown is not stored: it is recomputed by marking the
/// saved answers against the paper again. Storing a derived number twice is
/// how the two of them end up disagreeing.
library;

import 'package:flutter/material.dart';

import '../disposicion.dart';

import '../brand.dart';
import '../cambridge.dart';
import '../cambridge_data.dart';
import '../cambridge_theme.dart';
import '../practice.dart';
import '../state.dart';
import '../theme.dart';
import '../widgets.dart';
import 'profile.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final intentos = state.attempts;
    final temas = _temasPracticados(state);

    if (intentos.isEmpty && temas.isEmpty) {
      return const _Vacio();
    }

    // Un paper por tarjeta, el de la última vez arriba: lo que quieres ver al
    // abrir es lo que acabas de hacer.
    final porPaper = <String, List<Attempt>>{};
    for (final i in intentos) {
      (porPaper[i.paperId] ??= []).add(i);
    }

    return Pagina(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      children: [
        const GoalCard(),
        const SizedBox(height: 20),
        Centrado(
          ancho: anchoLectura,
          child: _Resumen(intentos: intentos, temas: temas),
        ),
        if (porPaper.isNotEmpty)
          Seccion(
            titulo: const TituloMarcado('Mock tests'),
            children: [
              for (final entrada in porPaper.entries)
                _TarjetaPaper(paperId: entrada.key, intentos: entrada.value),
            ],
          ),
        if (temas.isNotEmpty) ...[
          const TituloMarcado('Practice by topic'),
          Centrado(
            ancho: anchoLectura,
            child: _Temas(temas: temas),
          ),
        ],
        const TituloMarcado('Your data'),
        Centrado(ancho: anchoLectura, child: const _Borrar()),
      ],
    );
  }
}

/// Temas con al menos una respuesta, del peor al mejor.
List<({Topic topic, int ok, int wrong})> _temasPracticados(AppState state) {
  final out = <({Topic topic, int ok, int wrong})>[];
  for (final t in topics) {
    final (ok, mal) = state.scoreFor(t.id);
    if (ok + mal > 0) out.add((topic: t, ok: ok, wrong: mal));
  }
  out.sort((a, b) {
    final ta = a.ok / (a.ok + a.wrong);
    final tb = b.ok / (b.ok + b.wrong);
    return ta.compareTo(tb);
  });
  return out;
}

class _Vacio extends StatelessWidget {
  const _Vacio();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Pagina(
      ancho: anchoLectura,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
      children: [
        const GoalCard(),
        const SizedBox(height: 24),
        Text(
          'Nothing to show yet',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 10),
        Text(
          'Answer a few practice questions or sit a mock test, and this is '
          'where your scores, your weakest topics and whether you are getting '
          'better will show up.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 24),
        const TituloMarcado('Your data'),
        const _Borrar(),
      ],
    );
  }
}

class _Resumen extends StatelessWidget {
  const _Resumen({required this.intentos, required this.temas});

  final List<Attempt> intentos;
  final List<({Topic topic, int ok, int wrong})> temas;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ok = temas.fold<int>(0, (n, t) => n + t.ok);
    final mal = temas.fold<int>(0, (n, t) => n + t.wrong);
    final preguntas = ok + mal;

    return ContentCard(
      color: theme.colorScheme.surfaceContainerLowest,
      child: Row(
        children: [
          _Cifra(
            valor: '${intentos.length}',
            pie: intentos.length == 1 ? 'mock test' : 'mock tests',
          ),
          _Cifra(
            valor: '$preguntas',
            pie: preguntas == 1 ? 'question' : 'questions',
          ),
          _Cifra(
            valor: preguntas == 0 ? '—' : '${(ok * 100 / preguntas).round()}%',
            pie: 'correct',
          ),
        ],
      ),
    );
  }
}

class _Cifra extends StatelessWidget {
  const _Cifra({required this.valor, required this.pie});

  final String valor;
  final String pie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        children: [
          Text(valor, style: theme.textTheme.headlineMedium),
          const SizedBox(height: 2),
          Text(
            pie,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _TarjetaPaper extends StatefulWidget {
  const _TarjetaPaper({required this.paperId, required this.intentos});

  final String paperId;

  /// Newest first, as the state keeps them.
  final List<Attempt> intentos;

  @override
  State<_TarjetaPaper> createState() => _TarjetaPaperState();
}

class _TarjetaPaperState extends State<_TarjetaPaper> {
  bool _abierto = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paper = paperById(widget.paperId);
    final ultimo = widget.intentos.first;
    final colour = cambridgeReadable(
      colourFor(paper?.level ?? ExamLevel.b2),
      theme.colorScheme,
    );

    // El anterior del mismo paper, para decir si subiste o bajaste. Con un
    // solo intento no hay nada que comparar y no se enseña nada.
    final previo = widget.intentos.length > 1 ? widget.intentos[1] : null;
    final delta = previo == null
        ? null
        : (ultimo.fraction - previo.fraction) * 100;

    return ContentCard(
      onTap: () => setState(() => _abierto = !_abierto),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      paper?.name ?? widget.paperId,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        if (paper != null)
                          Pill(paper.level.chip, color: colour),
                        Pill(
                          _fecha(ultimo.date),
                          color: theme.colorScheme.outline,
                        ),
                        if (ultimo.minutes != null)
                          Pill(
                            '${ultimo.minutes} min',
                            color: theme.colorScheme.outline,
                            icon: Icons.schedule_rounded,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${(ultimo.fraction * 100).round()}%',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: ultimo.passing
                          ? okGreen(theme.colorScheme)
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    '${ultimo.marks}/${ultimo.maxMarks}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (widget.intentos.length > 1) ...[
            const SizedBox(height: 14),
            _Historial(intentos: widget.intentos, color: colour),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  delta! >= 0
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,
                  size: 17,
                  color: delta >= 0
                      ? okGreen(theme.colorScheme)
                      : theme.colorScheme.error,
                ),
                const SizedBox(width: 6),
                Text(
                  delta >= 0
                      ? '${delta.round()} points up on last time'
                      : '${delta.abs().round()} points down on last time',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
          if (_abierto && paper != null) ...[
            const Divider(height: 26),
            for (final r in markPaper(paper, ultimo.responses))
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ProgressBar(
                  value: r.fraction,
                  label:
                      '${r.part.name} · ${r.marks}/${r.part.maxMarks}'
                      '${r.wrong.isEmpty ? '' : '  ·  missed '
                                '${r.wrong.join(', ')}'}',
                  color: colour,
                ),
              ),
            const SizedBox(height: 2),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _confirmarBorrado(context, ultimo),
                icon: const Icon(Icons.delete_outline_rounded, size: 18),
                label: const Text('Delete this attempt'),
              ),
            ),
          ] else
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Tap for the breakdown',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _confirmarBorrado(BuildContext context, Attempt intento) async {
    final state = AppScope.of(context);
    final si = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete this attempt?'),
        content: const Text(
          'The score and the answers you typed go with it. Your other '
          'attempts at this paper stay.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Keep'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (si ?? false) await state.deleteAttempt(intento.id);
  }
}

/// Una barra por intento, del más viejo al más nuevo.
///
/// Es un gráfico de dos líneas de código y dice de un vistazo lo que una
/// tabla de porcentajes no dice: si la cosa sube.
class _Historial extends StatelessWidget {
  const _Historial({required this.intentos, required this.color});

  final List<Attempt> intentos;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viejos = intentos.reversed.toList();

    return SizedBox(
      height: 42,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < viejos.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 3),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: viejos[i].fraction.clamp(0, 1)),
                  duration: Duration(milliseconds: 420 + i * 60),
                  curve: Curves.easeOutCubic,
                  builder: (_, v, _) => Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 6 + v * 36,
                      decoration: BoxDecoration(
                        color: i == viejos.length - 1
                            ? color
                            : color.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
          Text(
            'last ${viejos.length}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}

class _Temas extends StatelessWidget {
  const _Temas({required this.temas});

  final List<({Topic topic, int ok, int wrong})> temas;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ContentCard(
      child: Column(
        children: [
          for (var i = 0; i < temas.length; i++) ...[
            if (i > 0) const Divider(height: 22),
            Builder(
              builder: (_) {
                final t = temas[i];
                final total = t.ok + t.wrong;
                final tasa = t.ok / total;
                return ProgressBar(
                  value: tasa,
                  // El peor va primero y se pinta en rojo solo si de verdad
                  // va mal: por debajo del 60, que es donde Cambridge aprueba.
                  color: tasa >= 0.6
                      ? okGreen(theme.colorScheme)
                      : theme.colorScheme.error,
                  label:
                      '${t.topic.name} · ${t.ok}/$total '
                      '(${(tasa * 100).round()}%)',
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _Borrar extends StatelessWidget {
  const _Borrar();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ContentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your progress and personal goal are saved on this device. '
            'Back them up before you change devices or uninstall the app.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: () => _copiar(context),
                icon: const Icon(Icons.save_alt_rounded, size: 18),
                label: const Text('Back up'),
              ),
              OutlinedButton.icon(
                onPressed: () => _restaurar(context),
                icon: const Icon(
                  Icons.settings_backup_restore_rounded,
                  size: 18,
                ),
                label: const Text('Restore'),
              ),
              OutlinedButton.icon(
                onPressed: () => _confirmar(context),
                icon: const Icon(Icons.restart_alt_rounded, size: 18),
                label: const Text('Start over'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Cíl $cilVersion',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }

  /// La copia sale al portapapeles y no a un archivo: un archivo dentro de la
  /// app se borra con la app, que es justo el caso del que hay que salvarse.
  /// Pegado en un correo a uno mismo, sobrevive al teléfono.
  void _copiar(BuildContext context) {
    final texto = AppScope.of(context).exportarTodo();
    copyToClipboard(
      context,
      texto,
      'Copied. Paste it into an email to yourself.',
    );
  }

  Future<void> _restaurar(BuildContext context) async {
    final campo = TextEditingController();
    final texto = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Restore a backup'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paste the text you copied. Everything currently on this phone '
              'is replaced by it.',
            ),
            const SizedBox(height: 12),
            TextField(
              controller: campo,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Paste here',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, campo.text),
            child: const Text('Restore'),
          ),
        ],
      ),
    );
    campo.dispose();
    if (texto == null || texto.trim().isEmpty || !context.mounted) return;

    final state = AppScope.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final ok = await state.importarTodo(texto);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Restored.'
              : 'That does not look like a Cíl backup. Nothing was changed.',
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _confirmar(BuildContext context) async {
    final state = AppScope.of(context);
    final si = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete everything?'),
        scrollable: true,
        content: const Text(
          'This deletes your profile, scores, mock attempts and drafts, and '
          'cancels Android reminders. Your exam level and theme stay. '
          'Remove calendar reminders in your calendar. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete everything'),
          ),
        ],
      ),
    );
    if (si ?? false) {
      try {
        await state.clearAll();
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Could not reset your data and reminders. Please try again.',
              ),
            ),
          );
        }
      }
    }
  }
}

String _fecha(DateTime d) {
  const meses = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${d.day} ${meses[d.month - 1]}';
}
