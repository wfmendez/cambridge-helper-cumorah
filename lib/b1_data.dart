/// B1 Preliminary — the official sample paper from the handbook.
///
/// Added because not everyone is aiming at B2 yet. B1 Preliminary is a
/// different exam with a different shape: Reading is one paper of six parts
/// and 32 questions, and there is no separate Use of English component — the
/// grammar is tested inside Reading Part 6.
///
/// Keys transcribed from the *B1 Preliminary Handbook for Teachers*.
library;

import 'cambridge.dart';

const ExamPaper b1Reading = ExamPaper(
  id: 'b1-sp-reading',
  level: ExamLevel.b1,
  name: 'Reading',
  minutes: 45,
  file: '168150-b1-preliminary-teachers-handbook.pdf',
  whereToFind:
      'B1 Preliminary Handbook for Teachers — the sample Reading '
      'paper. Open the PDF beside you.',
  note:
      'Six parts, 32 questions, 45 minutes. There is no separate Use of '
      'English paper at B1: Part 6 is where the grammar is tested.',
  parts: [
    ExamPart(
      number: 1,
      name: 'Signs and short messages',
      blurb:
          'Five very short texts — a notice, a text message, a label — each '
          'with one question.',
      howToAnswer:
          'One letter: A, B or C. Ask yourself who wrote it and who '
          'is meant to read it.',
      from: 1,
      to: 5,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {1: 'A', 2: 'C', 3: 'C', 4: 'B', 5: 'A'},
    ),
    ExamPart(
      number: 2,
      name: 'Matching',
      blurb: 'Five people with requirements, eight short descriptions.',
      howToAnswer: 'One letter, A to H. Three descriptions are never used.',
      from: 6,
      to: 10,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {6: 'F', 7: 'G', 8: 'B', 9: 'C', 10: 'H'},
    ),
    ExamPart(
      number: 3,
      name: 'Multiple choice',
      blurb: 'One longer text with five questions on detail and opinion.',
      howToAnswer: 'One letter: A, B, C or D.',
      from: 11,
      to: 15,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {11: 'C', 12: 'C', 13: 'D', 14: 'A', 15: 'B'},
    ),
    ExamPart(
      number: 4,
      name: 'Gapped text',
      blurb: 'Five sentences removed from a text, eight to choose from.',
      howToAnswer: 'One letter, A to H. Three sentences are never used.',
      from: 16,
      to: 20,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {16: 'G', 17: 'E', 18: 'F', 19: 'B', 20: 'D'},
    ),
    ExamPart(
      number: 5,
      name: 'Multiple-choice cloze',
      blurb: 'Vocabulary: six gaps with four options each.',
      howToAnswer: 'One letter: A, B, C or D.',
      from: 21,
      to: 26,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {21: 'C', 22: 'A', 23: 'B', 24: 'A', 25: 'C', 26: 'D'},
    ),
    ExamPart(
      number: 6,
      name: 'Open cloze',
      blurb:
          'Grammar: six gaps, one word each. This is the closest B1 gets '
          'to a Use of English paper.',
      howToAnswer: 'Exactly one word.',
      from: 27,
      to: 32,
      type: AnswerType.word,
      marksPerQuestion: 1,
      answers: {
        27: 'every/each',
        28: 'if',
        29: 'to',
        30: 'so',
        31: 'of',
        32: 'your',
      },
    ),
  ],
);

const ExamPaper b1Listening = ExamPaper(
  id: 'b1-sp-listening',
  audioFrom: 'https://www.cambridgeenglish.org/exams-and-tests/preliminary/preparation/',
  level: ExamLevel.b1,
  name: 'Listening',
  minutes: 30,
  file: '168150-b1-preliminary-teachers-handbook.pdf',
  whereToFind:
      'B1 Preliminary Handbook for Teachers — sample Listening. No '
      'audio available for this one.',
  note:
      'Four parts, 25 questions, about 30 minutes. Shorter than B2 and with '
      'pictures in Part 1.',
  parts: [
    ExamPart(
      number: 1,
      name: 'Multiple choice with pictures',
      blurb: 'Seven short recordings, each with three pictures.',
      howToAnswer: 'One letter: A, B or C. The pictures are in the PDF.',
      from: 1,
      to: 7,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {1: 'B', 2: 'B', 3: 'A', 4: 'C', 5: 'B', 6: 'B', 7: 'C'},
    ),
    ExamPart(
      number: 2,
      name: 'Multiple choice',
      blurb: 'Six short monologues or dialogues, one question each.',
      howToAnswer: 'One letter: A, B or C.',
      from: 8,
      to: 13,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {8: 'A', 9: 'B', 10: 'C', 11: 'A', 12: 'A', 13: 'A'},
    ),
    ExamPart(
      number: 3,
      name: 'Gap fill',
      blurb: 'One monologue; complete six gaps in a set of notes.',
      howToAnswer:
          'One or two words, or a number. Articles shown in brackets '
          'in the key are optional.',
      from: 14,
      to: 19,
      type: AnswerType.word,
      marksPerQuestion: 1,
      answers: {
        14: '(a/an/the) (fantastic) waterfall(s)',
        15: '(a/an/the) shark(s)',
        16: '(a/an/the/her) horse',
        17: '(a/an/the) musical (show/play)',
        18: 'sugar',
        19: '(some) ring(s)',
      },
    ),
    ExamPart(
      number: 4,
      name: 'Multiple choice',
      blurb: 'One longer interview with six questions.',
      howToAnswer: 'One letter: A, B or C.',
      from: 20,
      to: 25,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {20: 'C', 21: 'A', 22: 'B', 23: 'A', 24: 'A', 25: 'C'},
    ),
  ],
);

const ExamPaper b1Writing = ExamPaper(
  id: 'b1-sp-writing',
  level: ExamLevel.b1,
  name: 'Writing',
  minutes: 45,
  file: '168150-b1-preliminary-teachers-handbook.pdf',
  selfMarked: false,
  note:
      'Two parts in 45 minutes. Part 1 is a compulsory email of about 100 '
      'words; Part 2 is an article or a story, also about 100 words. Much '
      'shorter than B2, and the marking scales are simpler.',
  parts: [],
);

const ExamPaper b1Speaking = ExamPaper(
  id: 'b1-sp-speaking',
  level: ExamLevel.b1,
  name: 'Speaking',
  minutes: 12,
  file: '168150-b1-preliminary-teachers-handbook.pdf',
  selfMarked: false,
  note:
      '10–12 minutes in pairs, 15–17 in a group of three. Four parts: '
      'interview, a simulated situation with pictures, describing a '
      'photograph, and a general discussion.',
  parts: [],
);
