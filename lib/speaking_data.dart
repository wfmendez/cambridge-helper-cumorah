/// Speaking tests, and the language to answer them with.
///
/// Speaking is the one paper you cannot mark yourself, so the app does the
/// two things it usefully can: it keeps the clock honest, and it hands you the
/// phrases that examiners are listening for. The questions are written here,
/// not copied from a paper.
///
/// The material comes as whole tests, not loose questions, because that is how
/// the exam comes: Part 4 grows out of the topic of Part 3, and practising them
/// apart loses the one thing that makes Part 4 easier — you have just spent
/// three minutes talking about it.
///
/// Part 2 is the part that cannot be practised from text alone: it is about a
/// photograph. The photographs are not Cambridge's. They are free ones from
/// Unsplash, chosen to be like the exam's — everyday scenes with people doing
/// something — and each keeps the name of who took it.
library;

import 'cambridge.dart';
import 'speaking_data_b1.dart';
import 'speaking_data_c1.dart';
import 'speaking_photos.dart';

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
/// it is about. One photograph at B1, to describe; two at B2, to compare;
/// three at C1, of which the candidate chooses two.
class PhotoTask {
  const PhotoTask(this.question, this.photos);
  final String question;
  final List<SpeakingPhoto> photos;
}

/// One Part 3 task, printed the way the exam prints it: a question in the
/// middle of the sheet and the ideas around it, each joined to it by a line.
class DiagramTask {
  const DiagramTask(
    this.question,
    this.options,
    this.decision, {
    this.situation,
  });

  /// What sits in the middle of the diagram.
  final String question;

  /// The ideas around it. Five, as in the exam.
  final List<String> options;

  /// What the examiner asks once you have talked about the ideas: the
  /// minute in which the two of you have to choose.
  final String decision;

  /// At B1 the examiner first describes a situation — a friend is visiting, a
  /// class needs a present — and the question is about it.
  final String? situation;
}

/// A whole Speaking test: what the examiner asks in each of the four parts.
class SpeakingTest {
  const SpeakingTest({
    required this.interview,
    required this.photos,
    required this.diagram,
    required this.discussion,
  });

  /// Part 1: the questions about you.
  final List<String> interview;

  /// Part 2.
  final PhotoTask photos;

  /// Part 3.
  final DiagramTask diagram;

  /// Part 4: broader questions on the topic of Part 3.
  final List<String> discussion;
}

/// How a part works: its name, its clock and the language to do it with. The
/// questions themselves are in [SpeakingTest].
class SpeakingPart {
  const SpeakingPart({
    required this.number,
    required this.name,
    required this.seconds,
    required this.whatToDo,
    required this.openers,
    this.tip,
  });

  final int number;
  final String name;

  /// How long you get, in seconds.
  final int seconds;

  final String whatToDo;

  /// Ways to start. The hardest second of the test is the first one.
  final List<String> openers;

  final String? tip;
}

/// The parts for a level.
///
/// All four differ, not only the photographs: B1 talks about your own life
/// and a concrete situation, C1 about abstract questions with no right side,
/// and the timings are the ones each exam really gives.
List<SpeakingPart> speakingPartsFor(ExamLevel level) => switch (level) {
  ExamLevel.b1 => speakingPartsB1,
  ExamLevel.b2 => speakingParts,
  ExamLevel.c1 => speakingPartsC1,
};

/// The tests for a level.
List<SpeakingTest> speakingTestsFor(ExamLevel level) => switch (level) {
  ExamLevel.b1 => speakingTestsB1,
  ExamLevel.b2 => speakingTests,
  ExamLevel.c1 => speakingTestsC1,
};

/// B2 First. The other two levels are in speaking_data_b1.dart and
/// speaking_data_c1.dart.
const List<SpeakingPart> speakingParts = [
  SpeakingPart(
    number: 1,
    name: 'Interview',
    seconds: 120,
    whatToDo:
        'The examiner asks you and your partner simple questions about '
        'yourselves. Answer in two or three sentences — one word is too '
        'little, a speech is too much.',
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
        'You and your partner talk about the question in the middle and the '
        'five ideas around it for two minutes, then have a minute to reach a '
        'decision. The marks are in the interaction, not in being right.',
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

/// Twelve B2 tests. The first six have the photographs B2 had from the start,
/// and C1 builds its sets on those same pairs; the other six pair the same
/// twelve pictures differently, around a new question.
const List<SpeakingTest> speakingTests = [
  SpeakingTest(
    interview: [
      'Where are you from, and what is it like to live there?',
      'What do you enjoy doing in your free time?',
      'Do you prefer studying in the morning or in the evening? Why?',
      'What is something you would like to learn to do?',
    ],
    photos: PhotoTask(
      'Two people studying in different places. Why might they have chosen '
      'to study there?',
      [Fotos.studyLibrary, Fotos.studyCafe],
    ),
    diagram: DiagramTask(
      'How could these things persuade more people to cycle in a town?',
      [
        'Bike lanes',
        'Cheaper bikes',
        'Safety classes',
        'Fewer cars in the centre',
        'Safe places to leave bikes',
      ],
      'Which of these would work best?',
    ),
    discussion: [
      'Is it better to live somewhere you do not need a car? Why?',
      'Should public transport be free for everyone?',
      'How has the way people get around changed since your parents were '
          'young?',
      'Do you think people will travel less in the future?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Tell me about someone who has influenced you.',
      'What kind of music do you listen to, and has that changed?',
      'How do you usually keep in touch with your family?',
      'What is the best piece of advice anyone has given you?',
    ],
    photos: PhotoTask(
      'Two people doing different jobs outdoors. What might be difficult '
      'about each job?',
      [Fotos.jobGarden, Fotos.jobConstruction],
    ),
    diagram: DiagramTask(
      'How could a school spend money to make students’ lives better?',
      [
        'A new library',
        'Sports facilities',
        'Laptops and tablets',
        'A better canteen',
        'A garden to relax in',
      ],
      'Which two would students appreciate most?',
    ),
    discussion: [
      'Do you think schools today teach the right things?',
      'Should students have a say in how their school spends its money?',
      'Is it more important to be good at sport or at academic subjects?',
      'How might schools be different in twenty years?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Do you prefer travelling alone or with other people? Why?',
      'What is your favourite time of year, and why?',
      'Tell us about a film or series you have enjoyed recently.',
      'How often do you go out with friends, and where do you go?',
    ],
    photos: PhotoTask(
      'Two groups of people celebrating. How might the people be feeling?',
      [Fotos.celebrateBirthday, Fotos.celebrateGraduation],
    ),
    diagram: DiagramTask(
      'What do students need to think about when they organise an event?',
      ['The budget', 'The venue', 'Publicity', 'Food and drink', 'The date'],
      'Which should they decide first?',
    ),
    discussion: [
      'Do you prefer big events or small gatherings with a few friends?',
      'Is it a good idea for young people to organise events themselves?',
      'Why do some events become popular while others do not?',
      'Has social media changed the way people find out about events?',
    ],
  ),
  SpeakingTest(
    interview: [
      'What do you do to relax after a busy day?',
      'Do you like cooking? What do you usually make?',
      'What job would you like to do in the future?',
      'How important is sport in your life?',
    ],
    photos: PhotoTask(
      'Two ways of travelling to work. Why might people prefer each one?',
      [Fotos.commuteBike, Fotos.commuteMetro],
    ),
    diagram: DiagramTask(
      'How might a company help its staff to be healthier?',
      [
        'Gym membership',
        'Healthier canteen food',
        'Walking meetings',
        'Shorter working hours',
        'Working from home',
      ],
      'Which two should the company try first?',
    ),
    discussion: [
      'Is working from home better for people or for companies?',
      'How much should schools be responsible for teaching health habits?',
      'Do people work too hard nowadays?',
      'What makes a job a good one, apart from the money?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Tell us about the area where you live. Has it changed much?',
      'What is the best present you have ever received?',
      'Do you prefer reading books or watching films? Why?',
      'Where would you like to go on your next holiday?',
    ],
    photos: PhotoTask(
      'Two people learning something new. What might they find rewarding?',
      [Fotos.learnPottery, Fotos.learnGuitar],
    ),
    diagram: DiagramTask('What might make a town attractive to tourists?', [
      'Historic buildings',
      'Local food',
      'Beaches or countryside',
      'Festivals',
      'Cheap places to stay',
    ], 'Which is the most important for tourists?'),
    discussion: [
      'Does tourism do more good than harm to a place?',
      'Do you prefer holidays where you relax or where you see a lot?',
      'Should famous places limit the number of visitors?',
      'Is it better to travel in your own country or abroad?',
    ],
  ),
  SpeakingTest(
    interview: [
      'How much time do you spend online each day?',
      'What did you enjoy most about your first school?',
      'Do you prefer the city or the countryside? Why?',
      'What would your perfect weekend be like?',
    ],
    photos: PhotoTask(
      'Two meals in very different settings. Why might the people have '
      'chosen to eat there?',
      [Fotos.mealPicnic, Fotos.mealRestaurant],
    ),
    diagram: DiagramTask(
      'How might these things help people spend less time on their phones?',
      [
        'Turning off notifications',
        'Joining a club',
        'Reading paper books',
        'Phone-free meals',
        'Apps that limit screen time',
      ],
      'Which would be the most effective?',
    ),
    discussion: [
      'Do you think people rely too much on technology to learn?',
      'At what age should children have their own smartphone?',
      'Has technology made people more or less sociable?',
      'Will people use their phones less in the future, or more?',
    ],
  ),
  SpeakingTest(
    interview: [
      'What is your favourite place in your town, and why?',
      'Do you prefer spending time indoors or outdoors?',
      'How do you usually spend your evenings?',
      'What is the last thing you bought that you were really pleased with?',
    ],
    photos: PhotoTask(
      'People in a quiet place and in a crowded one. How might they be '
      'feeling?',
      [Fotos.studyLibrary, Fotos.commuteMetro],
    ),
    diagram: DiagramTask(
      'How might these things help students feel less stressed before an '
          'exam?',
      [
        'Making a study plan',
        'Sleeping well',
        'Studying with friends',
        'Doing exercise',
        'Taking short breaks',
      ],
      'Which would help the most?',
    ),
    discussion: [
      'Are exams a fair way to find out what students know?',
      'Is it possible to study too much?',
      'Should students be given less homework?',
      'Do young people today feel more pressure than their parents did?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Tell us about a teacher you remember well.',
      'Do you like trying new food? Why, or why not?',
      'What do you usually do on public holidays?',
      'Is there a country you would love to live in for a year?',
    ],
    photos: PhotoTask(
      'Two people spending time on their own. Why might they have chosen to '
      'be alone?',
      [Fotos.mealPicnic, Fotos.studyCafe],
    ),
    diagram: DiagramTask(
      'How could these things make a neighbourhood a better place to live?',
      [
        'More trees and parks',
        'A weekly market',
        'Better street lighting',
        'A community centre',
        'Less traffic',
      ],
      'Which two would make the biggest difference?',
    ),
    discussion: [
      'Do you know your neighbours well? Does it matter?',
      'What makes a city a good place for young people?',
      'Should cars be banned from city centres?',
      'Do you think cities will become better or worse places to live?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Do you prefer getting up early or staying up late?',
      'What kind of books or websites do you read for fun?',
      'How do you get ready for an important day?',
      'What is a skill you are proud of?',
    ],
    photos: PhotoTask(
      'Two people working with their hands. What might they enjoy about '
      'it?',
      [Fotos.jobGarden, Fotos.learnPottery],
    ),
    diagram: DiagramTask(
      'What might people think about when they choose a job?',
      [
        'The salary',
        'The people they work with',
        'How far it is from home',
        'The chance to learn',
        'The working hours',
      ],
      'Which is the most important?',
    ),
    discussion: [
      'Is it better to have a job you love or a job that pays well?',
      'Should young people work while they are still studying?',
      'Will machines do many of today’s jobs in the future?',
      'What can people learn from a part-time job?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Do you enjoy shopping? Why, or why not?',
      'Who do you spend most of your free time with?',
      'What was the last concert or show you went to?',
      'How do you think you will spend next summer?',
    ],
    photos: PhotoTask(
      'Two groups of friends spending time together. What might they be '
      'enjoying?',
      [Fotos.celebrateBirthday, Fotos.mealRestaurant],
    ),
    diagram: DiagramTask(
      'How could these things help someone learn a new language?',
      [
        'Watching films',
        'Travelling abroad',
        'Using an app',
        'Taking classes',
        'Chatting with people online',
      ],
      'Which would be the most effective?',
    ),
    discussion: [
      'Is it better to be good at many things or excellent at one?',
      'Why do some people find languages easier to learn than others?',
      'Should everyone learn a second language at school?',
      'Will people still need to learn languages when translation apps are '
          'so good?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Do you play any sports or games?',
      'What is the most interesting place you have visited?',
      'How often do you use public transport?',
      'What would you change about your daily routine if you could?',
    ],
    photos: PhotoTask(
      'People at different stages of learning. How might they be feeling?',
      [Fotos.learnGuitar, Fotos.celebrateGraduation],
    ),
    diagram: DiagramTask(
      'How might these things help to protect the environment?',
      [
        'Recycling more',
        'Using public transport',
        'Buying fewer clothes',
        'Eating less meat',
        'Saving energy at home',
      ],
      'Which would be the easiest for most people to do?',
    ),
    discussion: [
      'Who should do more for the environment: governments or ordinary '
          'people?',
      'Do young people care more about the environment than older people?',
      'Should plastic bags and bottles be banned?',
      'Is it possible to travel a lot and still be kind to the planet?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Tell us about your family.',
      'What was your favourite subject at school, and why?',
      'Do you prefer watching sport or taking part?',
      'What are you looking forward to this year?',
    ],
    photos: PhotoTask(
      'Two people outdoors in a city. What might be difficult about their '
      'day?',
      [Fotos.commuteBike, Fotos.jobConstruction],
    ),
    diagram: DiagramTask(
      'How could these things get young people interested in culture?',
      [
        'Free museum tickets',
        'Concerts in parks',
        'Art classes at school',
        'Theatre trips',
        'Online exhibitions',
      ],
      'Which would be the most popular?',
    ),
    discussion: [
      'Should public money pay for sport, or for the arts?',
      'Are museums boring for young people? Why, or why not?',
      'How important is it to know about your country’s history?',
      'Has the internet made it easier to enjoy art and music?',
    ],
  ),
];
