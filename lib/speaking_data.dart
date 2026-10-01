/// Prompts for the Speaking practice, and the language to answer them with.
///
/// Speaking is the one paper you cannot mark yourself, so the app does the
/// two things it usefully can: it keeps the clock honest, and it hands you the
/// phrases that examiners are listening for. The questions are written here,
/// not copied from a paper.
///
/// Part 2 is the part that cannot be practised from text alone: it is about a
/// photograph. The photographs are not Cambridge's. They are free ones from
/// Unsplash, chosen to be like the exam's — everyday scenes with people doing
/// something — and each keeps the name of who took it.
library;

import 'cambridge.dart';

/// A photograph for Part 2, and who took it.
class SpeakingPhoto {
  const SpeakingPhoto(this.file, this.by, this.id);

  /// File name in assets/speaking, without the extension.
  final String file;

  /// The photographer. The Unsplash licence does not require the credit; it is
  /// here because someone made the picture.
  final String by;

  /// The photo's id on Unsplash, so the original can be found again.
  final String id;

  String get asset => 'assets/speaking/$file.webp';
  String get page => 'https://unsplash.com/photos/$id';
}

/// One Part 2 task: what the examiner says, and the photograph or photographs
/// it is about. One photograph at B1, to describe; two at B2, to compare.
class PhotoTask {
  const PhotoTask(this.question, this.photos);
  final String question;
  final List<SpeakingPhoto> photos;
}

class SpeakingPart {
  const SpeakingPart({
    required this.number,
    required this.name,
    required this.seconds,
    required this.whatToDo,
    this.prompts = const [],
    this.photoTasks = const [],
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

  /// The same, for a part that works from photographs. When this is not
  /// empty it is used instead of [prompts].
  final List<PhotoTask> photoTasks;

  /// Ways to start. The hardest second of the test is the first one.
  final List<String> openers;

  final String? tip;

  /// How many different things this part can ask.
  int get variants =>
      photoTasks.isNotEmpty ? photoTasks.length : prompts.length;

  String promptAt(int i) =>
      photoTasks.isNotEmpty ? photoTasks[i].question : prompts[i];

  List<SpeakingPhoto> photosAt(int i) =>
      photoTasks.isNotEmpty ? photoTasks[i].photos : const [];
}

/// The parts for a level. Only Part 2 changes: B1 describes one photograph,
/// B2 and above compare two. The other three parts ask the same kind of thing
/// at every level.
List<SpeakingPart> speakingPartsFor(ExamLevel level) => [
  for (final p in speakingParts)
    if (p.number == 2 && level == ExamLevel.b1) _b1PhotoPart else p,
];

const _b1PhotoPart = SpeakingPart(
  number: 2,
  name: 'Describe a photograph',
  seconds: 60,
  whatToDo:
      'About one minute on your own, describing a photograph. The examiner '
      'tells you what it shows; you say what you can see. Nobody interrupts '
      'you.',
  photoTasks: [
    PhotoTask(
      'Your photograph shows people cooking at home. Tell us what you can '
      'see in the photograph.',
      [SpeakingPhoto('b1-cooking', 'Annie Spratt', 'UyEmagArOLY')],
    ),
    PhotoTask(
      'Your photograph shows people playing a sport outdoors. Tell us what '
      'you can see in the photograph.',
      [SpeakingPhoto('b1-football', 'Simone Franchina', 'y_sf8j3K2ZY')],
    ),
    PhotoTask(
      'Your photograph shows people at a market. Tell us what you can see '
      'in the photograph.',
      [SpeakingPhoto('b1-market', 'Stephan HK', 'R-xqhYU4ZKs')],
    ),
    PhotoTask(
      'Your photograph shows a family by the sea. Tell us what you can see '
      'in the photograph.',
      [SpeakingPhoto('b1-beach', 'Natalya Zaritskaya', 'SIOdjcYotms')],
    ),
    PhotoTask(
      'Your photograph shows people waiting for a train. Tell us what you '
      'can see in the photograph.',
      [
        SpeakingPhoto(
          'b1-station',
          'Dominic Kurniawan Suryaputra',
          'mTiPBTvoqVQ',
        ),
      ],
    ),
    PhotoTask(
      'Your photograph shows people on a camping trip. Tell us what you can '
      'see in the photograph.',
      [SpeakingPhoto('b1-camping', 'Colin + Meg', 'XDt4MuJ58LI')],
    ),
  ],
  openers: [
    'In this photograph I can see…',
    'In the background there is… / there are…',
    'On the left… / In the middle… / On the right…',
    'She looks… / They seem to be…',
    'I think it is… because…',
  ],
  tip:
      'Start with the whole scene, then the details: who is there, where they '
      'are, what they are doing, what they are wearing, what the weather is '
      'like. If you do not know a word, describe the thing — “it is something '
      'you use to…” — and keep talking. Silence is the only wrong answer.',
);

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
    photoTasks: [
      PhotoTask(
        'Two people studying in different places. Why might they have chosen '
        'to study there?',
        [
          SpeakingPhoto('b2-study-library', 'Praveen Gupta', 'YhfxJpa_Ch0'),
          SpeakingPhoto('b2-study-cafe', 'Ninthgrid', '0YBdk_6mSvY'),
        ],
      ),
      PhotoTask(
        'Two people doing different jobs outdoors. What might be difficult '
        'about each job?',
        [
          SpeakingPhoto('b2-job-garden', 'Jed Owen', '1JgUGDdcWnM'),
          SpeakingPhoto('b2-job-construction', 'Valerie V', 'PDjpA1yeonw'),
        ],
      ),
      PhotoTask(
        'Two groups of people celebrating. How might the people be feeling?',
        [
          SpeakingPhoto(
            'b2-celebrate-birthday',
            'Vitaly Gariev',
            'E1qHLWspl-k',
          ),
          SpeakingPhoto('b2-celebrate-graduation', 'RUT MIIT', 'hpRGrfOIybc'),
        ],
      ),
      PhotoTask(
        'Two ways of travelling to work. Why might people prefer each one?',
        [
          SpeakingPhoto('b2-commute-bike', 'Vitaly Gariev', 'wYwm3Z0HvXg'),
          SpeakingPhoto('b2-commute-metro', 'Zoshua Colah', 'X-nIOMKmGZY'),
        ],
      ),
      PhotoTask(
        'Two people learning something new. What might they find rewarding?',
        [
          SpeakingPhoto('b2-learn-pottery', 'Maggie Markel', 'oRbtEWw_l04'),
          SpeakingPhoto('b2-learn-guitar', 'Vitaly Gariev', 'S-vWVfbGr28'),
        ],
      ),
      PhotoTask(
        'Two meals in very different settings. Why might the people have '
        'chosen to eat there?',
        [
          SpeakingPhoto('b2-meal-picnic', 'Toa Heftiba', 'q1QDZtYP2ow'),
          SpeakingPhoto('b2-meal-restaurant', 'tommao wang', 'MAFMkfevd7w'),
        ],
      ),
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
