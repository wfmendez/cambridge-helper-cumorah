import 'package:flutter/material.dart';

import 'cambridge.dart';
import 'cambridge_theme.dart';

/// One mock-test answer. Feedback and the key stay hidden until marking.
class ExamAnswerField extends StatelessWidget {
  const ExamAnswerField({
    super.key,
    required this.part,
    required this.number,
    required this.controller,
    required this.graded,
    this.isListening = false,
  });

  final ExamPart part;
  final int number;
  final TextEditingController controller;
  final bool graded;
  final bool isListening;

  @override
  Widget build(BuildContext context) {
    final item = part.itemFor(number);
    final hasStem = item?.stem != null && item!.stem != '$number';
    final earned = graded
        ? marksForAnswer(part, number, controller.text)
        : null;
    final correct = earned == part.marksPerQuestion;
    final partial = earned != null && earned > 0 && !correct;
    final blank = controller.text.trim().isEmpty;
    final color = earned == null
        ? paperGrey
        : correct
        ? const Color(0xFF166534)
        : partial
        ? const Color(0xFF92400E)
        : blank
        ? paperGrey
        : cambridgeRed;
    final status = correct
        ? 'Correct'
        : partial
        ? 'Partly correct'
        : blank
        ? 'Not answered'
        : 'Not quite';
    final encouragement = correct
        ? 'Well done!'
        : partial
        ? 'You have part of it. Build on that.'
        : blank
        ? 'Try this one next time. Every attempt helps.'
        : 'Keep going. Use this clue for your next attempt.';
    final icon = correct
        ? Icons.check_circle_outline
        : partial
        ? Icons.adjust
        : blank
        ? Icons.edit_note
        : Icons.lightbulb_outline;

    return Padding(
      padding: EdgeInsets.only(bottom: graded || hasStem ? 18 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasStem)
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 6),
              child: Text(
                item.stem!,
                style: const TextStyle(
                  color: paperInk,
                  height: 1.55,
                  fontSize: 15,
                ),
              ),
            ),
          if (item != null && item.options.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 8),
              child: Wrap(
                spacing: 14,
                runSpacing: 4,
                children: [
                  for (final (i, option) in item.options.indexed)
                    Text(
                      '${String.fromCharCode(65 + i)}  $option',
                      style: const TextStyle(color: paperInk, fontSize: 14),
                    ),
                ],
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    '$number',
                    style: const TextStyle(color: paperGrey),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: !graded,
                  autocorrect: false,
                  maxLines: part.type == AnswerType.transformation ? 2 : 1,
                  textCapitalization: TextCapitalization.none,
                  decoration: InputDecoration(
                    isDense: true,
                    border: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: paperRule),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: color, width: 1.6),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (graded)
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 8),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.05),
                  border: Border(left: BorderSide(color: color, width: 3)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    color: paperInk,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            earned == null ? Icons.help_outline : icon,
                            size: 20,
                            color: color,
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Text(
                              earned == null
                                  ? 'Not graded'
                                  : '$status · $earned/${part.marksPerQuestion} '
                                        '${part.marksPerQuestion == 1 ? 'mark' : 'marks'}',
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      if (earned == null)
                        const Text(
                          'There is no answer key for this question yet.',
                        )
                      else ...[
                        Text(encouragement),
                        const SizedBox(height: 6),
                        Text(
                          'Answer: ${_answerLabel(part.answers[number]!, item)}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item?.explanation ?? _reviewHint(part, isListening),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

String _answerLabel(String key, ExamItem? item) {
  if (key.length == 1 && item != null) {
    final index = key.codeUnitAt(0) - 65;
    if (index >= 0 && index < item.options.length) {
      return '$key · ${item.options[index]}';
    }
  }
  return key.replaceAll(' | ', ' ');
}

String _reviewHint(ExamPart part, bool isListening) {
  if (isListening) {
    return 'Replay this section and check the transcript in the official '
        'materials. Listen for the words that support the answer.';
  }
  return switch (part.type) {
    AnswerType.transformation =>
      'Compare both halves with the key. Keep the given word unchanged and '
          'preserve the meaning of the original sentence. Each half earns one mark.',
    AnswerType.word =>
      'Read the complete sentence in the official PDF. Check the meaning, '
          'grammar and spelling of the word in the gap.',
    AnswerType.choice =>
      'Find the supporting sentence or phrase in the official PDF. Check '
          'the surrounding context as well as the option you chose.',
  };
}
