/// Prompts for the Speaking practice, and the language to answer them with.
///
/// Speaking is the one paper you cannot mark yourself, so the app does the
/// two things it usefully can: it keeps the clock honest, and it hands you the
/// phrases that examiners are listening for. The questions are written here,
/// not copied from a paper.
library;

class SpeakingPart {
  const SpeakingPart({
    required this.number,
    required this.name,
    required this.seconds,
    required this.whatToDo,
    required this.prompts,
    required this.openers,
    this.tip,
  });

  final int number;
  final String name;

  /// How long you get, in seconds.
  final int seconds;

  final String whatToDo;

  /// Things to talk about. Shuffled, so you rarely get the same one twice.
  final List<String> prompts;

  /// Ways to start. The hardest second of the test is the first one.
  final List<String> openers;

  final String? tip;
}

const List<SpeakingPart> speakingParts = [
  SpeakingPart(
    number: 1,
    name: 'Interview',
    seconds: 120,
    whatToDo:
        'The examiner asks you and your partner simple questions about '
        'yourselves. Answer in two or three sentences — one word is too '
        'little, a speech is too much.',
    prompts: [
      'Where are you from, and what is it like to live there?',
      'What do you enjoy doing in your free time?',
      'Do you prefer studying in the morning or in the evening? Why?',
      'Tell me about someone who has influenced you.',
      'What kind of music do you listen to, and has that changed?',
      'How do you usually keep in touch with your family?',
      'What is something you would like to learn to do?',
      'Do you prefer travelling alone or with other people? Why?',
    ],
    openers: [
      'Well, I suppose the main thing is…',
      'That is an interesting question. For me…',
      'I would say that…',
      'Actually, it depends on…',
    ],
    tip:
        'Add a reason to every answer, even when nobody asks for one. '
        '“Yes, I do” scores nothing; “Yes, I do, mainly because…” is an '
        'answer.',
  ),
  SpeakingPart(
    number: 2,
    name: 'Long turn',
    seconds: 60,
    whatToDo:
        'One full minute on your own, comparing two photographs and '
        'answering the question printed above them. Nobody interrupts you.',
    prompts: [
      'Two people studying in different places. Why might they have chosen '
          'to study there?',
      'Two people doing different jobs outdoors. What might be difficult '
          'about each job?',
      'Two groups of people celebrating. How might the people be feeling?',
      'Two ways of travelling to work. Why might people prefer each one?',
      'Two people learning something new. What might they find rewarding?',
      'Two meals in very different settings. Why might the people have '
          'chosen to eat there?',
    ],
    openers: [
      'The first picture shows… whereas in the second one…',
      'Both photographs show…, but the main difference is…',
      'In the picture at the top, it looks as though…',
      'These two images have something in common: …',
    ],
    tip:
        'Four moves, in order: say which photo, compare them, speculate '
        '(“they look as though…”, “he might be…”), then answer the printed '
        'question. Describing is not comparing, and only comparing scores.',
  ),
  SpeakingPart(
    number: 3,
    name: 'Collaborative task',
    seconds: 240,
    whatToDo:
        'You and your partner discuss several options together and then try '
        'to reach a decision. The marks are in the interaction, not in being '
        'right.',
    prompts: [
      'A school has money to improve one thing. Discuss: library, sports '
          'facilities, technology, canteen, outdoor space. Then decide which '
          'two matter most.',
      'A town wants more people to cycle. Discuss: bike lanes, cheaper '
          'bikes, safety classes, fewer cars in the centre. Then decide which '
          'would work best.',
      'A group of students is organising an event. Discuss: budget, venue, '
          'publicity, food, timing. Then decide what to settle first.',
      'A company wants staff to be healthier. Discuss: gym membership, '
          'better canteen food, walking meetings, shorter hours. Then decide '
          'which two to try.',
    ],
    openers: [
      'Shall we start with…?',
      'What do you think about…?',
      'That is a good point, although I would add that…',
      'I see what you mean, but on the other hand…',
      'So, are we agreed that…?',
    ],
    tip:
        'Bring your partner in. Asking “what do you think?” and reacting to '
        'the answer is literally one of the four things being marked. A '
        'monologue here loses marks however good the English is.',
  ),
  SpeakingPart(
    number: 4,
    name: 'Discussion',
    seconds: 240,
    whatToDo:
        'Broader questions on the same theme as Part 3. This is where you '
        'show you can handle abstract ideas, not just personal ones.',
    prompts: [
      'Do you think people rely too much on technology to learn?',
      'Should public money pay for sport, or for the arts?',
      'Is it better to be good at many things or excellent at one?',
      'Do you think cities will become better or worse places to live?',
      'How much should schools be responsible for teaching health habits?',
      'Is working from home better for people or for companies?',
    ],
    openers: [
      'On the whole, I would argue that…',
      'It is difficult to generalise, but…',
      'There are two sides to this. On one hand…',
      'I had not thought about it that way, but…',
    ],
    tip:
        'You are allowed to change your mind mid-answer — doing it out loud '
        '(“although, thinking about it…”) sounds fluent, not indecisive.',
  ),
];
