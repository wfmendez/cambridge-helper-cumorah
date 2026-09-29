/// Cíl Practice Paper 1 — Use of English.
///
/// Written from scratch for this app, which is the whole point: because the
/// text is ours, it can live on the phone. The official papers cannot, so for
/// those the app only marks you while you read from the booklet.
///
/// Same shapes as B2 First Parts 1–4, same number of questions, same marks.
/// Thirty questions, thirty-six marks.
library;

import 'cambridge.dart';

const ExamPaper cilPaper1 = ExamPaper(
  id: 'cil-1-use-of-english',
  level: ExamLevel.b2,
  source: PaperSource.cil,
  name: 'Cíl Paper 1 · Use of English',
  minutes: 40,
  note:
      'Written for this app, so the texts are here and you can sit it on the '
      'phone. Four parts, thirty questions, thirty-six marks.',
  parts: [
    ExamPart(
      number: 1,
      name: 'Multiple-choice cloze',
      blurb: 'Vocabulary: collocations, fixed phrases and phrasal verbs.',
      howToAnswer: 'One letter: A, B, C or D.',
      from: 1,
      to: 8,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      passage:
          'THE LIBRARY THAT NEVER CLOSES\n\n'
          'In a quiet street in Reykjavík there is a library that (1) ___ its '
          'doors at any hour of the night. It began as an experiment, and few '
          'people (2) ___ it would last. Ten years on, it is busier than ever.\n\n'
          'The idea (3) ___ to the founder during a winter when she was '
          'working nights and had nowhere to read. She (4) ___ up the project '
          'with almost no money, relying on donated books and volunteers who '
          '(5) ___ turns staffing the desk.\n\n'
          'What surprises visitors is how little the place resembles a '
          'traditional library. There is no silence rule, and staff actively '
          '(6) ___ conversation between strangers. Critics argued that this '
          'would (7) ___ serious readers away. In (8) ___, membership has '
          'trebled.',
      items: [
        ExamItem(
          number: 1,
          stem: '1',
          options: ['keeps', 'holds', 'stays', 'maintains'],
        ),
        ExamItem(
          number: 2,
          stem: '2',
          options: ['expected', 'waited', 'hoped', 'awaited'],
        ),
        ExamItem(
          number: 3,
          stem: '3',
          options: ['arrived', 'came', 'reached', 'appeared'],
        ),
        ExamItem(number: 4, stem: '4', options: ['set', 'made', 'put', 'took']),
        ExamItem(number: 5, stem: '5', options: ['did', 'made', 'took', 'had']),
        ExamItem(
          number: 6,
          stem: '6',
          options: ['encourage', 'persuade', 'insist', 'convince'],
        ),
        ExamItem(
          number: 7,
          stem: '7',
          options: ['drive', 'push', 'send', 'throw'],
        ),
        ExamItem(
          number: 8,
          stem: '8',
          options: ['fact', 'truth', 'reality', 'practice'],
        ),
      ],
      answers: {1: 'A', 2: 'A', 3: 'B', 4: 'A', 5: 'C', 6: 'A', 7: 'A', 8: 'A'},
    ),
    ExamPart(
      number: 2,
      name: 'Open cloze',
      blurb: 'Grammar: one word per gap, and it is usually a small one.',
      howToAnswer: 'Exactly one word. No contractions count as one word here.',
      from: 9,
      to: 16,
      type: AnswerType.word,
      marksPerQuestion: 1,
      passage:
          'LEARNING AN INSTRUMENT LATE\n\n'
          'It is often said that adults cannot learn an instrument as well '
          '(9) ___ children do. Recent studies suggest this is not quite '
          'true. Adults progress more slowly at first, but they make '
          '(10) ___ for it with patience and with a clearer sense of what '
          'they are aiming (11) ___.\n\n'
          'What does change is the reason for practising. A child practises '
          '(12) ___ someone tells them to; an adult practises despite having '
          'a hundred other things to do. That difference matters more '
          '(13) ___ any difference in the brain.\n\n'
          'Teachers who work with older beginners say the main obstacle is '
          'embarrassment. Many students give (14) ___ within a month, not '
          'because they cannot play but because they cannot bear to sound '
          'bad. (15) ___ you accept that stage, progress follows. As '
          '(16) ___ as anything, learning late is a lesson in tolerating '
          'being a beginner.',
      items: [
        ExamItem(number: 9, stem: '9'),
        ExamItem(number: 10, stem: '10'),
        ExamItem(number: 11, stem: '11'),
        ExamItem(number: 12, stem: '12'),
        ExamItem(number: 13, stem: '13'),
        ExamItem(number: 14, stem: '14'),
        ExamItem(number: 15, stem: '15'),
        ExamItem(number: 16, stem: '16'),
      ],
      answers: {
        9: 'as',
        10: 'up',
        11: 'at/for',
        12: 'because',
        13: 'than',
        14: 'up',
        15: 'once/if/when',
        16: 'much',
      },
    ),
    ExamPart(
      number: 3,
      name: 'Word formation',
      blurb: 'Change the word in CAPITALS so it fits the gap.',
      howToAnswer:
          'One word. Watch for gaps that need a negative prefix as '
          'well as a suffix.',
      from: 17,
      to: 24,
      type: AnswerType.word,
      marksPerQuestion: 1,
      passage:
          'THE RETURN OF THE NIGHT TRAIN\n\n'
          'For two decades the night train seemed to be in terminal '
          '(17) ___ (DECLINE). Airlines were cheaper and faster, and the '
          '(18) ___ (COMFORT) of old carriages did nothing to help.\n\n'
          'Then came a shift in attitudes. (19) ___ (INCREASE), travellers '
          'began to weigh the environmental cost of flying, and sleeper '
          'services found themselves (20) ___ (EXPECT) fashionable again.\n\n'
          'The (21) ___ (ATTRACT) is obvious once you try it: you lie down in '
          'one city and wake up in another, having lost no working day. '
          'Operators have responded with genuine (22) ___ (IMPROVE) rather '
          'than cosmetic ones, and the (23) ___ (AVAILABLE) of private cabins '
          'has widened the market. Whether the revival lasts will depend on '
          '(24) ___ (PRICE) as much as on goodwill.',
      items: [
        ExamItem(number: 17, stem: '17  DECLINE'),
        ExamItem(number: 18, stem: '18  COMFORT'),
        ExamItem(number: 19, stem: '19  INCREASE'),
        ExamItem(number: 20, stem: '20  EXPECT'),
        ExamItem(number: 21, stem: '21  ATTRACT'),
        ExamItem(number: 22, stem: '22  IMPROVE'),
        ExamItem(number: 23, stem: '23  AVAILABLE'),
        ExamItem(number: 24, stem: '24  PRICE'),
      ],
      answers: {
        17: 'decline',
        18: 'discomfort',
        19: 'increasingly',
        20: 'unexpectedly',
        21: 'attraction',
        22: 'improvements',
        23: 'availability',
        24: 'pricing',
      },
    ),
    ExamPart(
      number: 4,
      name: 'Key word transformation',
      blurb: 'Rewrite the second sentence so it means the same as the first.',
      howToAnswer:
          'Two to five words, including the word given, which cannot '
          'change. Each half scores a mark on its own.',
      from: 25,
      to: 30,
      type: AnswerType.transformation,
      marksPerQuestion: 2,
      items: [
        ExamItem(
          number: 25,
          stem:
              'I have not been to the theatre for two years.\n'
              'LAST\n'
              'It ___ went to the theatre.',
        ),
        ExamItem(
          number: 26,
          stem:
              'Somebody is repairing the roof at the moment.\n'
              'BEING\n'
              'The roof ___ at the moment.',
        ),
        ExamItem(
          number: 27,
          stem:
              '“Why don’t you take the train?” she said to me.\n'
              'SUGGESTED\n'
              'She ___ the train.',
        ),
        ExamItem(
          number: 28,
          stem:
              'It was a mistake to lend him the money.\n'
              'SHOULD\n'
              'I ___ him the money.',
        ),
        ExamItem(
          number: 29,
          stem:
              'The film was so long that we left before the end.\n'
              'SUCH\n'
              'It ___ that we left before the end.',
        ),
        ExamItem(
          number: 30,
          stem:
              'I am sure she did not know about the meeting.\n'
              'CANNOT\n'
              'She ___ about the meeting.',
        ),
      ],
      answers: {
        25: 'is two years | since I last',
        26: 'is being | repaired',
        27: 'suggested | (that) I (should) take OR suggested | taking',
        28: 'should not have | lent',
        29: 'was such a long | film',
        30: 'cannot have | known',
      },
    ),
  ],
);
