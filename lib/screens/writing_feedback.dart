import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../cambridge_theme.dart';
import '../disposicion.dart';
import '../widgets.dart';
import '../writing_review.dart';
import '../encouragement.dart';
import '../state.dart';

class WritingFeedbackScreen extends StatelessWidget {
  const WritingFeedbackScreen({
    super.key,
    required this.feedback,
    required this.original,
  });
  final WritingFeedback feedback;
  final String original;

  @override
  Widget build(BuildContext context) => Theme(
    data: paperTheme(),
    child: Scaffold(
      appBar: AppBar(title: const Text('Your writing review')),
      body: Pagina(
        ancho: anchoLectura,
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        children: [
          EncouragementCard(
            title: sessionEncouragement(
              feedback.total,
              20,
              AppScope.of(context).profile.name,
            ),
            message: 'Putting your ideas into English is worth celebrating. Choose one suggestion to work on in your next draft.',
            celebrate: feedback.total >= 14,
          ),
          const SizedBox(height: 20),
          Text(
            'Practice estimate · ${feedback.total}/20',
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'AI feedback from ${feedback.provider}. This is not an official '
            'Cambridge mark. Review the suggestions before using them.',
            style: const TextStyle(color: paperGrey, height: 1.5),
          ),
          const SizedBox(height: 20),
          SelectableText(feedback.summary, style: const TextStyle(height: 1.6)),
          const SizedBox(height: 24),
          // Antes que las notas: si no respondiste a lo que se pedía, eso es lo
          // primero que hay que saber, y lo que más nota cuesta.
          if (feedback.taskResponse case final respuesta?) ...[
            _RespuestaTarea(respuesta: respuesta),
            const SizedBox(height: 24),
          ],
          for (final criterion in feedback.criteria) ...[
            ContentCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${criterion.name} · ${criterion.score}/5',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(criterion.reason, style: const TextStyle(height: 1.5)),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
          _ListSection(title: 'What works', items: feedback.strengths),
          _ListSection(title: 'Try this next', items: feedback.improvements),
          const Text(
            'Corrections explained',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          if (feedback.corrections.isEmpty)
            const Text(
              'No specific language corrections were suggested. Check the task feedback above.',
            ),
          for (final correction in feedback.corrections) ...[
            ContentCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'You wrote',
                    style: TextStyle(color: paperGrey, fontSize: 12),
                  ),
                  SelectableText(
                    correction.original,
                    style: const TextStyle(height: 1.5),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Suggested correction',
                    style: TextStyle(color: paperGrey, fontSize: 12),
                  ),
                  SelectableText(
                    correction.replacement,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    correction.explanation,
                    style: const TextStyle(height: 1.5),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
          const SizedBox(height: 16),
          const Text(
            'Corrected version',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your original draft has not been changed.',
            style: TextStyle(color: paperGrey),
          ),
          // Sin esto, pulir el inglés de una respuesta que no responde a la
          // tarea parece un arreglo, y no lo es.
          if (feedback.taskResponse?.relevance
              case TaskRelevance.partly || TaskRelevance.offTask) ...[
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // El naranja solo en el icono: sobre papel blanco da 3:1, que
                // basta para un icono y no para texto.
                const Icon(
                  Icons.info_outline_rounded,
                  size: 18,
                  color: cambridgeOrange,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feedback.taskResponse!.relevance == TaskRelevance.offTask
                        ? 'This fixes the English of what you wrote. It does '
                              'not make it answer the task — see “How it could '
                              'answer the task” above.'
                        : 'This fixes the English of what you wrote. It does '
                              'not add what is missing from the task — see the '
                              'points above.',
                    style: const TextStyle(height: 1.5),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          SelectableText(
            feedback.correctedText,
            style: const TextStyle(fontSize: 16, height: 1.7),
          ),
          const SizedBox(height: 12),
          Builder(
            builder: (context) => Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.copy_rounded),
                label: const Text('Copy corrected version'),
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: feedback.correctedText),
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Copied')));
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          ExpansionTile(
            title: const Text('Your submitted answer'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SelectableText(
                  original,
                  style: const TextStyle(height: 1.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back to my draft'),
          ),
        ],
      ),
    ),
  );
}

/// Did the answer do what the task asked — overall, point by point, and if
/// not, how it could.
///
/// Colour carries meaning only on icons and borders. On white paper the
/// palette's green and orange reach 3:1, enough for an icon and not for text,
/// so every word stays in ink and the status is also written out.
class _RespuestaTarea extends StatelessWidget {
  const _RespuestaTarea({required this.respuesta});
  final TaskResponse respuesta;

  @override
  Widget build(BuildContext context) {
    final (icono, color, veredicto) = switch (respuesta.relevance) {
      TaskRelevance.onTask => (
        Icons.check_circle_rounded,
        cambridgeGreen,
        'Yes — it answers the task.',
      ),
      TaskRelevance.partly => (
        Icons.incomplete_circle_rounded,
        cambridgeOrange,
        'Partly — some of what the task asks is missing.',
      ),
      TaskRelevance.offTask => (
        Icons.error_outline_rounded,
        cambridgeRed,
        'Not yet — it answers a different question.',
      ),
    };
    final redirect = respuesta.redirect;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Did it answer the task?',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Icon(icono, color: color),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                veredicto,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        for (final p in respuesta.points) _PuntoTarea(punto: p),
        if (!redirect.isEmpty) ...[
          const SizedBox(height: 8),
          ContentCard(
            border: color.withValues(alpha: 0.6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How it could answer the task',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(redirect.explanation, style: const TextStyle(height: 1.5)),
                const SizedBox(height: 12),
                for (final (i, paso) in redirect.plan.indexed)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          child: Text(
                            '${i + 1}.',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            paso,
                            style: const TextStyle(height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (redirect.opening.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  const Text(
                    'You could start like this',
                    style: TextStyle(color: paperGrey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  SelectableText(
                    redirect.opening,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                const Text(
                  'A plan, not an answer: the writing is still yours to do.',
                  style: TextStyle(color: paperGrey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _PuntoTarea extends StatelessWidget {
  const _PuntoTarea({required this.punto});
  final TaskPoint punto;

  @override
  Widget build(BuildContext context) {
    final (icono, color, estado) = switch (punto.status) {
      PointStatus.covered => (Icons.check_rounded, cambridgeGreen, 'Covered'),
      PointStatus.partly => (Icons.remove_rounded, cambridgeOrange, 'Partly'),
      PointStatus.missing => (Icons.close_rounded, cambridgeRed, 'Missing'),
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, size: 20, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(punto.point, style: const TextStyle(height: 1.4)),
                const SizedBox(height: 2),
                Text(
                  punto.evidence.isEmpty
                      ? estado
                      : '$estado · “${punto.evidence}”',
                  style: const TextStyle(
                    color: paperGrey,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ListSection extends StatelessWidget {
  const _ListSection({required this.title, required this.items});
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('• $item', style: const TextStyle(height: 1.5)),
          ),
      ],
    ),
  );
}
