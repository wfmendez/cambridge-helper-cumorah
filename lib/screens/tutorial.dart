import 'package:flutter/material.dart';

import '../disposicion.dart';

import '../brand.dart';
import '../cambridge_theme.dart';
import '../state.dart';
import '../widgets.dart';

/// One step of the walkthrough.
class PasoTutorial {
  const PasoTutorial({
    required this.title,
    required this.body,
    required this.escena,
    required this.colour,
    this.points = const [],
  });

  final String title;
  final String body;
  final Escena escena;
  final Color colour;
  final List<String> points;
}

const List<PasoTutorial> pasosTutorial = [
  PasoTutorial(
    title: 'Pick what you are aiming at',
    body:
        'The chips at the top set your goal: B1 Preliminary, B2 First or '
        'C1 Advanced — the exams you may know as PET, FCE and CAE. '
        'Everything else follows from it.',
    escena: Escena.meta,
    colour: cambridgeRed,
    points: [
      'Cambridge renamed these in 2019. B1 = PET, B2 = FCE, C1 = CAE; same '
          'exams, two names. “The exam” explains the rest.',
      'You see the material at your level and below, never above it.',
      'Aiming higher adds work rather than replacing it — a C1 candidate '
          'still drills the B1 basics.',
      'Change it whenever you like. Nothing is lost.',
    ],
  ),
  PasoTutorial(
    title: 'Practice: learn why, not just what',
    body:
        'Short exercises grouped by topic. You answer, it marks you, and '
        'then it explains why that is the answer — which is the part a '
        'workbook never does.',
    escena: Escena.practica,
    colour: cambridgeBlue,
    points: [
      'Start with “How the tasks work” if terms like cloze or gapped text '
          'mean nothing to you yet.',
      'Each topic keeps your score, and the app points at your weakest area.',
      'There is a hint on the harder items, before you give up and look.',
    ],
  ),
  PasoTutorial(
    title: 'Mock test: two kinds',
    body:
        'Papers written for Cíl carry their own texts, so you sit them '
        'entirely on the phone. Official Cambridge papers do not: for those '
        'you read from the PDF and type your answers in to be marked.',
    escena: Escena.simulacro,
    colour: cambridgeGreen,
    points: [
      'The sheet is black and white on purpose: it imitates the booklet.',
      'A clock counts up so you learn how long you really take.',
      'Marking is by part, so you see where the marks went, not just a total.',
      'Cambridge papers are free to download from their own site.',
    ],
  ),
  PasoTutorial(
    title: 'Writing and Speaking',
    body:
        'The two papers nobody can mark for you. The app does the parts it '
        'honestly can.',
    escena: Escena.escribir,
    colour: cambridgePurple,
    points: [
      'Writing gives you a real task, a live word count and a clock. The '
          'count matters: 140–190 words at B2 is not something you judge '
          'by eye.',
      'Your draft saves as you type.',
      'Speaking gives you a timer, a prompt that shuffles and the phrases '
          'examiners listen for. Say the answers out loud — reading them in '
          'your head trains nothing.',
    ],
  ),
  PasoTutorial(
    title: 'It is all yours and it stays here',
    body:
        'No account, no sign-up, nothing sent anywhere. Everything you '
        'practise is stored on this phone and works with the plane mode on.',
    escena: Escena.privado,
    colour: cambridgeCyan,
    points: [
      'Uninstalling the app deletes your scores. There is no backup.',
      'The Listening audio is inside the app: no data needed to play it.',
      'Nothing here is official. Cíl is a study aid, not Cambridge.',
    ],
  ),
];

/// The first-run walkthrough, shown once and reachable afterwards from
/// The exam.
///
/// Shown once because a tutorial that keeps appearing is an annoyance;
/// reachable afterwards because nobody remembers a walkthrough they swiped
/// through on day one.
class PantallaTutorial extends StatefulWidget {
  const PantallaTutorial({super.key, this.primeraVez = false});

  /// On first run it ends with “Start”; later it is just something you read.
  final bool primeraVez;

  @override
  State<PantallaTutorial> createState() => _PantallaTutorialState();
}

class _PantallaTutorialState extends State<PantallaTutorial> {
  final _paginas = PageController();
  int _indice = 0;

  @override
  void dispose() {
    _paginas.dispose();
    super.dispose();
  }

  bool get _ultima => _indice == pasosTutorial.length - 1;

  Future<void> _terminar() async {
    if (widget.primeraVez) {
      await AppScope.of(context).markTutorialSeen();
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Centrado(
              ancho: anchoLectura,
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
              child: Row(
                children: [
                  const MarcaAnimada(size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      widget.primeraVez ? 'Welcome to Cíl' : 'How Cíl works',
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  if (widget.primeraVez && !_ultima)
                    TextButton(onPressed: _terminar, child: const Text('Skip')),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _paginas,
                itemCount: pasosTutorial.length,
                onPageChanged: (i) => setState(() => _indice = i),
                itemBuilder: (_, i) => _Pagina(paso: pasosTutorial[i]),
              ),
            ),
            Centrado(
              ancho: anchoLectura,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Row(
                children: [
                  for (var i = 0; i < pasosTutorial.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 6),
                      width: i == _indice ? 20 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: i == _indice
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outlineVariant,
                      ),
                    ),
                  const Spacer(),
                  FilledButton(
                    onPressed: _ultima
                        ? _terminar
                        : () => _paginas.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          ),
                    child: Text(
                      _ultima ? (widget.primeraVez ? 'Start' : 'Done') : 'Next',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pagina extends StatelessWidget {
  const _Pagina({required this.paso});

  final PasoTutorial paso;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colour = cambridgeReadable(paso.colour, theme.colorScheme);

    return Pagina(
      ancho: anchoLectura,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
      children: [
        Ilustracion(escena: paso.escena, color: colour, size: 165),
        const SizedBox(height: 26),
        Text(paso.title, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 12),
        Text(
          paso.body,
          style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
        const SizedBox(height: 20),
        for (final p in paso.points)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: MarcaCil(size: 11, color: colour),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    p,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
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

/// The card in The exam that reopens the walkthrough.
class TarjetaTutorial extends StatelessWidget {
  const TarjetaTutorial({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ContentCard(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const PantallaTutorial())),
      border: theme.colorScheme.primary.withValues(alpha: 0.35),
      child: Row(
        children: [
          const MarcaCil(size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('How Cíl works', style: theme.textTheme.titleSmall),
                const SizedBox(height: 2),
                Text(
                  'The walkthrough again, in five screens',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
