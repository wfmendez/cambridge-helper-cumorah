/// B2 First · Sample Paper 2, and C1 Advanced from the official handbook.
///
/// The keys are transcribed from Cambridge's own *Answer keys* pages. Writing
/// and Speaking have no key — they are judged on examiner scales — so only
/// their structure and timing are recorded.
library;

import 'b1_data.dart';
import 'cambridge.dart';
import 'cil_paper.dart';
import 'cil_paper_2.dart';

final List<ExamPaper> cambridgePapers = [
  b1Reading,
  b1Listening,
  b1Writing,
  b1Speaking,
  cilPaper1,
  cilPaper2,
  _readingUseOfEnglish,
  _writing,
  _listening,
  _speaking,
  _c1Reading,
  _c1Writing,
  _c1Listening,
  _c1Speaking,
];

/// One paper by its id, or null if it is not one of ours.
///
/// Saved attempts keep the id rather than the paper, so this is how a result
/// finds its way back to what it was a result of.
ExamPaper? paperById(String id) {
  for (final p in cambridgePapers) {
    if (p.id == id) return p;
  }
  return null;
}

/// The papers of one level, in the order they are sat on the day.
List<ExamPaper> papersFor(ExamLevel level) =>
    cambridgePapers.where((p) => p.level == level).toList();

const ExamPaper _readingUseOfEnglish = ExamPaper(
  id: 'b2-sp2-reading',
  whereToFind:
      'B2 First Reading and Use of English Sample Paper 2 — open the '
      'PDF or the printout beside you.',
  level: ExamLevel.b2,
  name: 'Reading and Use of English',
  minutes: 75,
  file: 'B2 First Reading and Use of English Sample Paper 2.pdf',
  note:
      'The longest paper and the one that decides most of your mark. '
      'Parts 1 to 4 are Use of English — grammar and vocabulary — and 5 to '
      '7 are reading.',
  parts: [
    ExamPart(
      number: 1,
      name: 'Multiple-choice cloze',
      blurb: 'Pick the word that fits each gap.',
      howToAnswer: 'One letter: A, B, C or D.',
      from: 1,
      to: 8,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {1: 'D', 2: 'A', 3: 'D', 4: 'C', 5: 'C', 6: 'A', 7: 'D', 8: 'C'},
    ),
    ExamPart(
      number: 2,
      name: 'Open cloze',
      blurb: 'Write the missing word. One word per gap, always.',
      howToAnswer: 'Exactly one word. Usually a preposition, article, auxiliary or pronoun.',
      from: 9,
      to: 16,
      type: AnswerType.word,
      marksPerQuestion: 1,
      answers: {
        9: 'took',
        10: 'rather',
        11: 'off/out/sail',
        12: 'in',
        13: 'did',
        14: 'came',
        15: 'after',
        16: 'on/for',
      },
    ),
    ExamPart(
      number: 3,
      name: 'Word formation',
      blurb: 'Change the word given so it fits the gap.',
      howToAnswer:
          'One word, formed from the word in CAPITALS beside the line.',
      from: 17,
      to: 24,
      type: AnswerType.word,
      marksPerQuestion: 1,
      answers: {
        17: 'proved',
        18: 'variety',
        19: 'enjoyment',
        20: 'safety',
        21: 'unusual',
        22: 'riders',
        23: 'environmental',
        24: 'suggestions',
      },
    ),
    ExamPart(
      number: 4,
      name: 'Key word transformation',
      blurb:
          'Rewrite the sentence using the word given, unchanged. Each '
          'half is worth a mark, so half an answer still scores.',
      howToAnswer: 'Two to five words, including the word given, which cannot change. Each half scores separately.',
      from: 25,
      to: 30,
      type: AnswerType.transformation,
      marksPerQuestion: 2,
      answers: {
        25: 'looking forward | to hearing',
        26: 'see the point | in/of buying OR see any point | (in) buying',
        27: 'was not | as/so expensive',
        28: 'wish | (that) I could come',
        29: '(completely) sold out | of (the)',
        30: "didn't/did not mean | to delete",
      },
    ),
    ExamPart(
      number: 5,
      name: 'Multiple choice',
      blurb: 'Comprehension of one long text.',
      howToAnswer: 'One letter: A, B, C or D.',
      from: 31,
      to: 36,
      type: AnswerType.choice,
      marksPerQuestion: 2,
      answers: {31: 'C', 32: 'A', 33: 'B', 34: 'D', 35: 'A', 36: 'A'},
    ),
    ExamPart(
      number: 6,
      name: 'Gapped text',
      blurb: 'Put the missing sentences back into the text.',
      howToAnswer: 'One letter, A to G. One sentence is never used.',
      from: 37,
      to: 42,
      type: AnswerType.choice,
      marksPerQuestion: 2,
      answers: {37: 'E', 38: 'B', 39: 'G', 40: 'F', 41: 'D', 42: 'A'},
    ),
    ExamPart(
      number: 7,
      name: 'Multiple matching',
      blurb: 'Match each question to the text that answers it.',
      howToAnswer: 'One letter. Sections can be used more than once.',
      from: 43,
      to: 52,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {
        43: 'C',
        44: 'D',
        45: 'A',
        46: 'B',
        47: 'E',
        48: 'C',
        49: 'A',
        50: 'E',
        51: 'B',
        52: 'D',
      },
    ),
  ],
);

const ExamPaper _listening = ExamPaper(
  id: 'b2-sp2-listening',
  // The recording is Cambridge's, so it is linked rather than shipped — the
  // same way B1 and C1 already do it. It used to be bundled, which was
  // defensible while the app was an APK passed between classmates and is not
  // once it is a public URL.
  audioFrom: 'https://www.cambridgeenglish.org/Images/178516-b2-first-sample-paper-2.zip',
  whereToFind:
      'B2 First sample paper 2 Listening — download the official ZIP below '
      'for the question PDF and all four audio tracks.',
  level: ExamLevel.b2,
  name: 'Listening',
  minutes: 40,
  file: 'B2 First sample paper 2 Listening 2022.pdf',
  note:
      'Everything is played twice. In Part 2, anything shown in brackets in '
      'the key does not have to be written.',
  parts: [
    ExamPart(
      number: 1,
      name: 'Multiple choice',
      blurb: 'Eight unrelated extracts, one question each.',
      howToAnswer:
          'One letter: A, B or C. Eight separate extracts, each played twice.',
      from: 1,
      to: 8,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {1: 'C', 2: 'A', 3: 'C', 4: 'B', 5: 'C', 6: 'B', 7: 'A', 8: 'C'},
    ),
    ExamPart(
      number: 2,
      name: 'Sentence completion',
      blurb: 'Complete the sentences with what you hear. Do not rephrase.',
      howToAnswer: 'Up to three words, normally one or two. Write what you hear — do not rephrase. Small spelling slips are forgiven.',
      from: 9,
      to: 18,
      type: AnswerType.word,
      marksPerQuestion: 1,
      answers: {
        9: 'internet',
        10: 'history',
        11: 'caravan',
        12: 'party',
        13: 'sun(-)rise',
        14: 'shoulders',
        15: 'tracks',
        16: 'plants',
        17: 'airport',
        18: 'January',
      },
    ),
    ExamPart(
      number: 3,
      name: 'Multiple matching',
      blurb: 'Five speakers, eight options: three are never used.',
      howToAnswer: 'One letter, A to H, for each of the five speakers. Three options are never used.',
      from: 19,
      to: 23,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {19: 'D', 20: 'H', 21: 'A', 22: 'G', 23: 'C'},
    ),
    ExamPart(
      number: 4,
      name: 'Multiple choice',
      blurb: 'One long interview with seven questions.',
      howToAnswer: 'One letter: A, B or C. One long interview.',
      from: 24,
      to: 30,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {24: 'B', 25: 'B', 26: 'A', 27: 'B', 28: 'C', 29: 'A', 30: 'C'},
    ),
  ],
);

const ExamPaper _writing = ExamPaper(
  id: 'b2-sp2-writing',
  level: ExamLevel.b2,
  name: 'Writing',
  minutes: 80,
  file: 'B2 First sample paper 2 Writing.pdf',
  selfMarked: false,
  note:
      'Two tasks of 140-190 words: Part 1 is a compulsory essay and Part 2 is '
      'chosen from several options. Marked on four scales — Content, '
      'Communicative Achievement, Organisation and Language — each 0 to 5. '
      'The PDF includes real scripts with the examiner comments, which is the '
      'clearest way to see what separates a 3 from a 5.',
  parts: [],
);

const ExamPaper _speaking = ExamPaper(
  id: 'b2-sp2-speaking',
  level: ExamLevel.b2,
  name: 'Speaking',
  minutes: 14,
  file: 'cambridge-english-first-2015-sample-paper-2-speaking v2.pdf',
  selfMarked: false,
  note:
      'In pairs, with two examiners. Four parts: interview, long turn on '
      'photos, collaborative task and discussion. This is the one you cannot '
      'practise alone — you need someone opposite you.',
  parts: [],
);

// ── C1 Advanced · sample paper from the official handbook ────────────────────

/// Transcribed from the *C1 Advanced Handbook for Teachers*, answer keys.
///
/// There is no audio for the Listening: the handbook publishes the keys but
/// not the recordings. It still marks fine if you source the audio elsewhere.
const ExamPaper _c1Reading = ExamPaper(
  id: 'c1-sp-reading',
  whereToFind:
      'C1 Advanced Handbook for Teachers — the sample Reading and '
      'Use of English paper.',
  level: ExamLevel.c1,
  name: 'Reading and Use of English',
  minutes: 90,
  file: '167804-c1-advanced-handbook.pdf',
  note:
      'Eight parts and 56 questions against seven and 52 at B2, and fifteen '
      'minutes longer. Part 6 does not exist at B2.',
  parts: [
    ExamPart(
      number: 1,
      name: 'Multiple-choice cloze',
      blurb: 'Vocabulary: collocations, fixed phrases, phrasal verbs.',
      howToAnswer: 'One letter: A, B, C or D.',
      from: 1,
      to: 8,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {1: 'D', 2: 'D', 3: 'B', 4: 'A', 5: 'A', 6: 'C', 7: 'B', 8: 'C'},
    ),
    ExamPart(
      number: 2,
      name: 'Open cloze',
      blurb: 'One word per gap. Grammar and fixed phrases.',
      howToAnswer: 'Exactly one word. CAPITALS on the real answer sheet.',
      from: 9,
      to: 16,
      type: AnswerType.word,
      marksPerQuestion: 1,
      answers: {
        9: 'such',
        10: 'at',
        11: 'put',
        12: 'than',
        13: 'with/by',
        14: 'like',
        15: 'least',
        16: 'despite',
      },
    ),
    ExamPart(
      number: 3,
      name: 'Word formation',
      blurb: 'More internal spelling changes than at B2.',
      howToAnswer: 'One word from the stem given. Often two changes at once: a prefix and a suffix.',
      from: 17,
      to: 24,
      type: AnswerType.word,
      marksPerQuestion: 1,
      answers: {
        17: 'pursuit',
        18: 'unpredictable',
        19: 'enthusiasts',
        20: 'distinguish',
        21: 'competitors',
        22: 'increasingly',
        23: 'replacements',
        24: 'innovative',
      },
    ),
    ExamPart(
      number: 4,
      name: 'Key word transformation',
      blurb: 'Three to six words, not two to five as at B2.',
      howToAnswer: 'Three to six words at C1, including the word given, unchanged. Each half scores separately.',
      from: 25,
      to: 30,
      type: AnswerType.transformation,
      marksPerQuestion: 2,
      answers: {
        25: 'you give | a clear explanation of/about',
        26: 'is alleged | to have damaged',
        // The official key reads "makes no/(very) little difference": there
        // the slash separates two whole phrases, not two words. Written with
        // OR, which is how the comparer expresses full alternatives.
        27:
            'makes no difference | to me OR '
            'makes (very) little difference | to me',
        28: "hadn't/had not been | for Joe's",
        29: 'do what(ever)/everything/all/anything | it takes',
        30: 'was withdrawn | in (the) light of',
      },
    ),
    ExamPart(
      number: 5,
      name: 'Multiple choice',
      blurb: 'One long text, six questions with four options.',
      howToAnswer: 'One letter: A, B, C or D.',
      from: 31,
      to: 36,
      type: AnswerType.choice,
      marksPerQuestion: 2,
      answers: {31: 'C', 32: 'B', 33: 'D', 34: 'A', 35: 'D', 36: 'A'},
    ),
    ExamPart(
      number: 6,
      name: 'Cross-text multiple matching',
      blurb:
          'The new one: four texts giving opinions on the same subject, '
          'and you compare who agrees with whom.',
      howToAnswer:
          'One letter, A to D: which of the four texts. You are '
          'comparing opinions across all four at once.',
      from: 37,
      to: 40,
      type: AnswerType.choice,
      marksPerQuestion: 2,
      answers: {37: 'D', 38: 'B', 39: 'A', 40: 'D'},
    ),
    ExamPart(
      number: 7,
      name: 'Gapped text',
      blurb: 'Whole paragraphs are removed, not single sentences.',
      howToAnswer: 'One letter, A to G. One paragraph is never used.',
      from: 41,
      to: 46,
      type: AnswerType.choice,
      marksPerQuestion: 2,
      answers: {41: 'F', 42: 'D', 43: 'C', 44: 'B', 45: 'A', 46: 'G'},
    ),
    ExamPart(
      number: 8,
      name: 'Multiple matching',
      blurb: 'Ten questions, one mark each: do not overspend time here.',
      howToAnswer: 'One letter. Sections can be used more than once.',
      from: 47,
      to: 56,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {
        47: 'C',
        48: 'D',
        49: 'B',
        50: 'A',
        51: 'C',
        52: 'A',
        53: 'C',
        54: 'D',
        55: 'B',
        56: 'D',
      },
    ),
  ],
);

const ExamPaper _c1Listening = ExamPaper(
  id: 'c1-sp-listening',
  audioFrom:
      'https://www.cambridgeenglish.org/exams-and-tests/advanced/preparation/',
  whereToFind:
      'C1 Advanced Handbook for Teachers — sample Listening. No '
      'audio available for this one.',
  level: ExamLevel.c1,
  name: 'Listening',
  minutes: 40,
  file: '167804-c1-advanced-handbook.pdf',
  note:
      'Thirty questions as at B2, but split differently. In Part 4 you '
      'answer twice about the same five speakers: 21-25 is the first task '
      'and 26-30 the second.\n\nNo audio here: the handbook publishes the keys '
      'but not the recordings.',
  parts: [
    ExamPart(
      number: 1,
      name: 'Short extracts',
      blurb: 'Three extracts, two questions each.',
      howToAnswer:
          'One letter: A, B or C. Three extracts, two questions '
          'each.',
      from: 1,
      to: 6,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {1: 'C', 2: 'B', 3: 'C', 4: 'A', 5: 'C', 6: 'A'},
    ),
    ExamPart(
      number: 2,
      name: 'Sentence completion',
      blurb: 'Write the words you hear. Do not rephrase.',
      howToAnswer: 'Up to three words. Write what you hear, unchanged.',
      from: 7,
      to: 14,
      type: AnswerType.word,
      marksPerQuestion: 1,
      answers: {
        7: 'climate change',
        8: 'oil',
        9: 'raw materials',
        10: '(small) stones',
        11: 'brown',
        12: 'single(-)use',
        13: 'surf(-)board',
        14: 'seaweed',
      },
    ),
    ExamPart(
      number: 3,
      name: 'Multiple choice',
      blurb: 'Four options, not three as at B2.',
      howToAnswer:
          'One letter: A, B, C or D — four options at C1, not '
          'three.',
      from: 15,
      to: 20,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {15: 'B', 16: 'C', 17: 'D', 18: 'A', 19: 'C', 20: 'A'},
    ),
    ExamPart(
      number: 4,
      name: 'Multiple matching · two tasks',
      blurb: 'Five monologues and two lists: 21-25 and 26-30.',
      howToAnswer:
          'Two separate tasks over the same five speakers. '
          'Questions 21-25 are the first list, 26-30 the second. One letter '
          'A to H in each.',
      from: 21,
      to: 30,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      answers: {
        21: 'F',
        22: 'H',
        23: 'D',
        24: 'B',
        25: 'G',
        26: 'E',
        27: 'F',
        28: 'A',
        29: 'C',
        30: 'D',
      },
    ),
  ],
);

const ExamPaper _c1Writing = ExamPaper(
  id: 'c1-sp-writing',
  level: ExamLevel.c1,
  name: 'Writing',
  minutes: 90,
  file: '167804-c1-advanced-handbook.pdf',
  selfMarked: false,
  note:
      'Two tasks of 220-260 words against 140-190 at B2. Part 1 is always '
      'an essay with no choice; Part 2 is chosen from three. At C1 covering '
      'the points is not enough: you have to say which matters most and why.',
  parts: [],
);

const ExamPaper _c1Speaking = ExamPaper(
  id: 'c1-sp-speaking',
  level: ExamLevel.c1,
  name: 'Speaking',
  minutes: 15,
  file: '167804-c1-advanced-handbook.pdf',
  selfMarked: false,
  note:
      'Fifteen minutes in pairs, twenty-three in a group of three. Four '
      'parts as at B2, but on more abstract topics and with less room for '
      'short answers.',
  parts: [],
);
