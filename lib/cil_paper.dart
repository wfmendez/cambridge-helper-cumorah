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
          'doors open at any hour of the night. It began as an experiment, and few '
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
          explanation: "“Keep something open” means to make sure it stays open. Here the library keeps its doors open throughout the night.",
          stem: '1',
          options: ['keeps', 'lasts', 'stays', 'maintains'],
        ),
        ExamItem(
          number: 2,
          explanation: "“Expected it would last” describes a prediction about the future. “Wait” and “await” describe waiting, not a belief about what will happen.",
          stem: '2',
          options: ['expected', 'waited', 'wondered', 'awaited'],
        ),
        ExamItem(
          number: 3,
          explanation: "An idea “comes to” someone when they think of it. The past tense is “came”, followed here by “to the founder”.",
          stem: '3',
          options: ['arrived', 'came', 'reached', 'appeared'],
        ),
        ExamItem(
          number: 4,
          explanation: "“Set up” means to establish or start a project, business or organisation. The founder started the library with donated books and volunteers.",
          stem: '4',
          options: ['set', 'made', 'put', 'took'],
        ),
        ExamItem(
          number: 5,
          explanation: "“Take turns” means to do something one after another. The past tense is “took turns”: the volunteers shared the work at the desk.",
          stem: '5',
          options: ['did', 'made', 'took', 'had'],
        ),
        ExamItem(
          number: 6,
          explanation: "You can “encourage conversation”. “Persuade” and “convince” normally need a person as their object, while “insist” would need a different structure.",
          stem: '6',
          options: ['encourage', 'persuade', 'insist', 'convince'],
        ),
        ExamItem(
          number: 7,
          explanation: "“Drive readers away” means to make them stop coming. The critics predicted that conversation would discourage serious readers from visiting.",
          stem: '7',
          options: ['drive', 'push', 'send', 'throw'],
        ),
        ExamItem(
          number: 8,
          explanation: "“In fact” introduces the real result, which contradicts the prediction: membership trebled instead of readers leaving.",
          stem: '8',
          options: ['fact', 'event', 'detail', 'case'],
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
        ExamItem(
          number: 9,
          explanation: "The comparison is “as well as”: adults can learn an instrument as well as children do. The second “as” completes the pattern.",
          stem: '9',
        ),
        ExamItem(
          number: 10,
          explanation: "“Make up for” means to compensate for something. Patience compensates for the adults’ slower progress at the beginning.",
          stem: '10',
        ),
        ExamItem(
          number: 11,
          explanation: "You can “aim at” or “aim for” a goal. Both prepositions fit this reference to what the learners want to achieve.",
          stem: '11',
        ),
        ExamItem(
          number: 12,
          explanation: "“Because” introduces the reason the child practises: someone tells them to. The next clause contrasts this with an adult’s motivation.",
          stem: '12',
        ),
        ExamItem(
          number: 13,
          explanation: "“More than” is the comparative structure. The text compares the importance of motivation with differences in the brain.",
          stem: '13',
        ),
        ExamItem(
          number: 14,
          explanation: "“Give up” means to stop trying. The next words explain why some beginners stop: they feel embarrassed about sounding bad.",
          stem: '14',
        ),
        ExamItem(
          number: 15,
          explanation: "“Once”, “if” and “when” all connect accepting the beginner stage with making progress. They frame it as a time or a condition.",
          stem: '15',
        ),
        ExamItem(
          number: 16,
          explanation: "“As much as anything” means that this aspect is at least as important as the others. Learning to tolerate being a beginner matters too.",
          stem: '16',
        ),
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
        ExamItem(
          number: 17,
          explanation: "After “in terminal” we need a noun. “Decline” is already a noun as well as a verb, so it stays unchanged in this practice question.",
          stem: '17  DECLINE',
        ),
        ExamItem(
          number: 18,
          explanation: "The context is negative: the old carriages did nothing to help. Add “dis-” to form the noun “discomfort”, meaning a lack of comfort.",
          stem: '18  COMFORT',
        ),
        ExamItem(
          number: 19,
          explanation: "“Increasingly” is an adverb meaning more and more. It describes the growing tendency for travellers to consider the environmental cost.",
          stem: '19  INCREASE',
        ),
        ExamItem(
          number: 20,
          explanation: "“Unexpectedly” is the adverb that modifies “fashionable”. The negative prefix shows that the renewed popularity came as a surprise.",
          stem: '20  EXPECT',
        ),
        ExamItem(
          number: 21,
          explanation: "The article “the” and the verb “is” require a singular noun here. “Attraction” names what makes night trains appealing.",
          stem: '21  ATTRACT',
        ),
        ExamItem(
          number: 22,
          explanation: "Use the plural noun “improvements”. The later phrase “cosmetic ones” points back to several improvements, so the plural ending matters.",
          stem: '22  IMPROVE',
        ),
        ExamItem(
          number: 23,
          explanation: "“The availability of” needs a noun. Change the adjective “available” to “availability” to describe whether private cabins can be obtained.",
          stem: '23  AVAILABLE',
        ),
        ExamItem(
          number: 24,
          explanation: "A noun is needed after “depend on”. “Pricing” refers to how fares are set; “price” and “prices” also fit the meaning of this sentence.",
          stem: '24  PRICE',
        ),
      ],
      answers: {
        17: 'decline',
        18: 'discomfort',
        19: 'increasingly',
        20: 'unexpectedly',
        21: 'attraction',
        22: 'improvements',
        23: 'availability',
        24: 'pricing/price/prices',
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
          explanation: "“It is two years since I last went” expresses the same period without a visit. The gap is “since I last”: three words, including LAST.",
          stem:
              'I have not been to the theatre for two years.\n'
              'LAST\n'
              'It is two years ___ went to the theatre.',
        ),
        ExamItem(
          number: 26,
          explanation: "The action is happening now, so use the present continuous passive: “is being repaired”. BEING stays unchanged and “repaired” is the past participle.",
          stem:
              'Somebody is repairing the roof at the moment.\n'
              'BEING\n'
              'The roof ___ at the moment.',
        ),
        ExamItem(
          number: 27,
          explanation: "After “suggested”, use a clause such as “I take” or “that I take”, or an -ing form: “suggested taking”. Do not use “suggested me to take”.",
          stem:
              '“Why don’t you take the train?” she said to me.\n'
              'SUGGESTED\n'
              'She ___ the train.',
        ),
        ExamItem(
          number: 28,
          explanation: "“Should not have” plus a past participle expresses regret about a past action. “Lent” is the past participle of “lend”.",
          stem:
              'It was a mistake to lend him the money.\n'
              'SHOULD\n'
              'I ___ him the money.',
        ),
        ExamItem(
          number: 29,
          explanation: "“So long” becomes “such a long film”: such + a + adjective + singular noun. “It was” is already provided, so write only “such a long film”.",
          stem:
              'The film was so long that we left before the end.\n'
              'SUCH\n'
              'It was ___ that we left before the end.',
        ),
        ExamItem(
          number: 30,
          explanation: "“Cannot have” plus a past participle expresses certainty that something did not happen. Use “known”, the past participle of “know”.",
          stem:
              'I am sure she did not know about the meeting.\n'
              'CANNOT\n'
              'She ___ about the meeting.',
        ),
      ],
      answers: {
        25: 'since | I last',
        26: 'is being | repaired',
        27: 'suggested | (that) I take OR suggested | I should take OR suggested | taking',
        28: 'should not have | lent',
        29: 'such a long | film',
        30: 'cannot have | known',
      },
    ),
  ],
);
