import 'package:flutter/material.dart';

import '../cambridge.dart';
import '../cambridge_theme.dart';
import '../disposicion.dart';
import '../listening_resources.dart';
import '../widgets.dart';
import 'enlace.dart';

class ListeningLibrary extends StatefulWidget {
  const ListeningLibrary({super.key, required this.level});
  final ExamLevel level;

  @override
  State<ListeningLibrary> createState() => _ListeningLibraryState();
}

class _ListeningLibraryState extends State<ListeningLibrary> {
  late ExamLevel level = widget.level;

  Future<void> _open(ListeningResource resource) async {
    final opened = await abrirEnlace(resource.url);
    if (!mounted || opened) return;
    copyToClipboard(
      context,
      resource.url,
      'Could not open a browser. Link copied — paste it into your browser.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colour = cambridgeReadable(cambridgeCyan, theme.colorScheme);
    return Scaffold(
      appBar: AppBar(title: const Text('Free listening practice')),
      body: Pagina(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Centrado(
            ancho: anchoLectura,
            child: ContentCard(
              border: colour.withValues(alpha: 0.35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Listen, check, listen again',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '12 free British Council lessons with audio, a transcript and exercises. '
                    'They open on the publisher’s website and need internet. These are listening '
                    'lessons, not full Cambridge mock tests.',
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    '1. Listen once for the main idea.\n'
                    '2. Try the exercises, then listen for details.\n'
                    '3. Check the transcript and replay a difficult section.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final value in ExamLevel.values)
                ChoiceChip(
                  label: Text('${value.cefr} · 4 lessons'),
                  selected: level == value,
                  onSelected: (_) => setState(() => level = value),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Rejilla(
            maxColumnas: 2,
            children: [
              for (final resource in listeningResources.where(
                (r) => r.level == level,
              ))
                ContentCard(
                  border: colour.withValues(alpha: 0.3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(resource.title, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(resource.focus),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          Pill('Audio', color: colour, icon: Icons.headphones),
                          Pill('Transcript', color: colour),
                          Pill('Exercises', color: colour),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'British Council · LearnEnglish',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          FilledButton.icon(
                            onPressed: () => _open(resource),
                            icon: const Icon(Icons.open_in_new),
                            label: const Text('Open lesson'),
                          ),
                          TextButton.icon(
                            onPressed: () => copyToClipboard(
                              context,
                              resource.url,
                              'Lesson link copied.',
                            ),
                            icon: const Icon(Icons.copy_outlined),
                            label: const Text('Copy link'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
