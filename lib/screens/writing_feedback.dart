import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../cambridge_theme.dart';
import '../disposicion.dart';
import '../widgets.dart';
import '../writing_review.dart';

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
