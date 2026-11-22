/// The for Schools mode: what it is, and how the screens say which material
/// has been adapted to it and which has not.
///
/// What Cambridge's own format pages say (checked November 2026):
///
/// * A2 Key, B1 Preliminary and B2 First have a for Schools version. C1
///   Advanced does not: schools that take C1 sit the same C1 Advanced.
/// * Format, timing, marking and the certificate are the same. What changes
///   is the content — topics and texts for school-age learners rather than
///   work and adult life.
/// * Writing is the one paper with a difference in the task list, and only
///   at B2: Part 2 can be a story in B2 First for Schools and never a report;
///   in B2 First it can be a report and never a story. At B1 both versions
///   offer an article or a story in Part 2.
///
/// The app does not pretend: where there is no for Schools material yet, the
/// general one is shown with [GeneralMaterialNote] saying so.
library;

import 'package:flutter/material.dart';

import 'cambridge.dart';
import 'cambridge_theme.dart';
import 'widgets.dart';

/// The colour of everything for Schools. Cyan, because the five Cambridge
/// colours already each mean a paper and this is not one.
const Color schoolsColour = cambridgeCyan;

/// What the mode is, in one sentence, for the line under the switch.
const String schoolsSummary =
    'Same format and marks, with topics for teenagers. There is no C1 '
    'Advanced for Schools, so C1 is not offered.';

/// "This is general material" — shown in for Schools mode wherever the
/// content has not been adapted yet.
class GeneralMaterialNote extends StatelessWidget {
  const GeneralMaterialNote({
    super.key,
    required this.level,
    required this.what,
  });

  final ExamLevel level;

  /// What the note is about: 'These practice questions', 'These papers'.
  final String what;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colour = cambridgeReadable(schoolsColour, theme.colorScheme);
    return ContentCard(
      color: schoolsColour.withValues(alpha: 0.07),
      border: schoolsColour.withValues(alpha: 0.4),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, size: 20, color: colour),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$what are written for ${level.name}, not yet for '
              '${level.examName(schools: true)}. The format and marking are '
              'the same; some topics are about work and adult life, which '
              'the for Schools exam avoids.',
              style: theme.textTheme.bodySmall?.copyWith(height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}

/// What for Schools mode means, at the top of Practice: the exam you are
/// preparing, why C1 is not offered, and that this tab's material is still
/// the general one.
class SchoolsModeCard extends StatelessWidget {
  const SchoolsModeCard({super.key, required this.level});

  final ExamLevel level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colour = cambridgeReadable(schoolsColour, theme.colorScheme);
    final cuerpo = theme.textTheme.bodySmall?.copyWith(height: 1.45);
    return ContentCard(
      color: schoolsColour.withValues(alpha: 0.07),
      border: schoolsColour.withValues(alpha: 0.4),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.backpack_outlined, size: 20, color: colour),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Preparing ${level.examName(schools: true)}',
                  style: theme.textTheme.titleSmall?.copyWith(color: colour),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(schoolsSummary, style: cuerpo),
          const SizedBox(height: 6),
          Text(
            'Speaking and Writing have tasks written for '
            '${level.examName(schools: true)}. These practice questions and '
            'word lists are written for ${level.name}, not yet for the for '
            'Schools exam: same format, but some topics are about work and '
            'adult life.',
            style: cuerpo,
          ),
        ],
      ),
    );
  }
}

/// A small label: 'For Schools' on adapted material, 'General' on the rest.
class AudiencePill extends StatelessWidget {
  const AudiencePill({super.key, required this.schools});

  final bool schools;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return schools
        ? Pill(
            'For Schools',
            color: cambridgeReadable(schoolsColour, scheme),
            icon: Icons.backpack_outlined,
          )
        : Pill('General', color: scheme.onSurfaceVariant);
  }
}
