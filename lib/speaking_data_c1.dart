/// The four parts of the C1 Advanced Speaking test.
///
/// The shape is close to B2's, and the difference is in what counts as an
/// answer. Part 1 expects a reflection rather than a fact. Part 2 gives three
/// pictures instead of two — you choose two — and two questions instead of
/// one, and nobody wants a description. Part 3's prompts are abstract, and
/// Part 4 runs for five minutes on questions with no right side to take.
///
/// Each Part 2 set is one of B2's pairs with a third picture on the same
/// theme, so the photographs are shared; the questions are not.
library;

import 'speaking_data.dart';
import 'speaking_photos.dart';

const List<SpeakingPart> speakingPartsC1 = [
  SpeakingPart(
    number: 1,
    name: 'Interview',
    seconds: 120,
    whatToDo:
        'A short conversation about you: your interests, your work or '
        'studies, your plans. The questions are personal, but at C1 the '
        'answer is expected to go somewhere — a reason, a contrast, a second '
        'thought.',
    openers: [
      'I suppose what strikes me most is…',
      'To be honest, I have never really thought about it, but…',
      'It rather depends on…',
      'Looking back, I would say…',
    ],
    tip:
        'Extend without being asked: give a reason, then something that '
        'qualifies it — “although…”, “having said that…”. A short accurate '
        'answer is a B2 answer; C1 is in the second sentence.',
  ),
  SpeakingPart(
    number: 2,
    name: 'Long turn',
    seconds: 60,
    whatToDo:
        'One minute on your own. You are given three pictures: choose two, '
        'compare them, and answer the two questions printed above them. '
        'Nobody interrupts you.',
    openers: [
      'I would like to talk about the first and the third pictures…',
      'Whereas the person in this picture…, the people in the other one…',
      'What the two situations have in common is…',
      'I would imagine that… / It is quite likely that…',
      'It could well be that…, although it is hard to tell.',
    ],
    tip:
        'Choose your two pictures in the first five seconds and say which '
        'they are. Then compare, speculate, and answer both questions — most '
        'candidates answer the first and run out of time before the second. '
        'Nobody is asking you to describe what you can see.',
  ),
  SpeakingPart(
    number: 3,
    name: 'Collaborative task',
    seconds: 240,
    whatToDo:
        'You and your partner discuss a question with five written prompts for '
        'about two minutes, then have a minute to reach a decision. The ideas '
        'are abstract, and the marks are for how you build on what your '
        'partner says.',
    openers: [
      'Shall we begin with…?',
      'That ties in with what you were saying about…',
      'I take your point, though I wonder whether…',
      'Would you go along with the idea that…?',
      'So, on balance, are we saying that…?',
    ],
    tip:
        'Do not rush to the decision. The first two minutes are for exploring '
        'the prompts, and agreeing too early leaves you with nothing to say. '
        'Pick up your partner’s own words — “when you said status…” — because '
        'listening is what is being marked.',
  ),
  SpeakingPart(
    number: 4,
    name: 'Discussion',
    seconds: 300,
    whatToDo:
        'About five minutes of broader questions growing out of Part 3. This '
        'is where C1 is decided: developing an argument, weighing the other '
        'side, and holding the floor without a script.',
    openers: [
      'I would argue that…, at least to some extent.',
      'There is a case for saying that…, but…',
      'That is certainly true of…, though I am not sure it applies to…',
      'Coming back to what you said earlier…',
    ],
    tip:
        'Give a view, support it, then concede something — “that said…”, '
        '“admittedly…”. Conceding a point does not weaken an answer at C1; it '
        'is what a developed argument sounds like.',
  ),
];

/// Six C1 tests. Each Part 2 set is the B2 pair of the same test with its
/// third picture.
const List<SpeakingTest> speakingTestsC1 = [
  SpeakingTest(
    interview: [
      'What do you think is the most significant change in your home town in '
          'recent years?',
      'How important is it for you to have a routine?',
      'What kind of work would you find it hardest to do, and why?',
      'Do you prefer to work on your own or as part of a team?',
    ],
    photos: PhotoTask(
      'Why might the people have chosen to study in these places, and how '
      'easy might it be for them to concentrate?',
      [Fotos.studyLibrary, Fotos.studyCafe, Fotos.studyPark],
    ),
    diagram: DiagramTask(
      'How might these things influence a person’s choice of career?',
      [
        'Salary',
        'Job security',
        'The chance to travel',
        'Status',
        'Work–life balance',
      ],
      'Which has the greatest effect on job satisfaction in the long term?',
    ),
    discussion: [
      'Some people say that we judge success too much by income. To what '
          'extent do you agree?',
      'Is it ever too late to change direction in life?',
      'Should young people follow their passion rather than look for a '
          'secure career?',
      'How might the idea of a job for life change in the coming decades?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Is there a skill you wish you had learned when you were younger?',
      'How do you think your free time will change in the next few years?',
      'Which of your achievements has given you the most satisfaction?',
      'What do you think people of your age worry about most?',
    ],
    photos: PhotoTask(
      'What might the people find satisfying about these jobs, and what '
      'might be the hardest part of each?',
      [Fotos.jobGarden, Fotos.jobConstruction, Fotos.jobFishing],
    ),
    diagram: DiagramTask(
      'How can these things help people to feel part of a community?',
      [
        'Local festivals',
        'Shared green spaces',
        'Volunteering',
        'Local shops',
        'Sports clubs',
      ],
      'Which does the most to bring people together?',
    ),
    discussion: [
      'Do you think people today have a weaker sense of community than '
          'previous generations did?',
      'Whose responsibility is it to make newcomers feel welcome in a '
          'neighbourhood?',
      'Can online communities ever replace the ones people meet face to '
          'face?',
      'Are big cities lonelier places to live than small towns?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Do you tend to plan things carefully or act on impulse? What makes you '
          'say that?',
      'What do you find is the best way to stay close to people who live far '
          'away?',
      'What would you miss most if you moved abroad?',
      'How do you usually react when plans change at the last minute?',
    ],
    photos: PhotoTask(
      'Why might these moments be important to the people, and how long '
      'might they remember them?',
      [
        Fotos.celebrateBirthday,
        Fotos.celebrateGraduation,
        Fotos.celebrateTrophy,
      ],
    ),
    diagram: DiagramTask(
      'What are the advantages of learning these things as an adult?',
      [
        'A language',
        'A musical instrument',
        'A practical skill',
        'A sport',
        'Public speaking',
      ],
      'Which would be the hardest to learn later in life?',
    ),
    discussion: [
      'Should schools prepare young people for work, or for life more '
          'broadly?',
      'Is formal education overvalued compared with experience?',
      'Why do so many adults give up on things they set out to learn?',
      'How far should governments pay for adults to retrain?',
    ],
  ),
  SpeakingTest(
    interview: [
      'How has the way you spend your free time changed since you were a '
          'child?',
      'Who do you turn to for advice, and why them?',
      'Is there a place you go to when you need to think?',
      'What kind of news do you tend to follow, and why?',
    ],
    photos: PhotoTask(
      'What are the advantages of travelling to work in these ways, and how '
      'might the people be feeling?',
      [Fotos.commuteBike, Fotos.commuteMetro, Fotos.commuteCar],
    ),
    diagram: DiagramTask(
      'How far do these things affect how well people concentrate?',
      ['Noise', 'Technology', 'Sleep', 'Deadlines', 'The people around you'],
      'Which is the most difficult to control?',
    ),
    discussion: [
      'Has technology made it harder or easier to concentrate on one thing?',
      'Are people expected to be available for too much of the day?',
      'Is the ability to do several things at once a skill or a myth?',
      'Should there be limits on how much work people can be sent after '
          'hours?',
    ],
  ),
  SpeakingTest(
    interview: [
      'What do you value most in a friendship?',
      'Is there a tradition in your family that you would like to keep?',
      'How do you usually decide what to read or watch next?',
      'How much attention do you pay to what other people think of you?',
    ],
    photos: PhotoTask(
      'Why might the people have decided to learn these things, and how '
      'difficult might they be finding it?',
      [Fotos.learnPottery, Fotos.learnGuitar, Fotos.learnCooking],
    ),
    diagram: DiagramTask(
      'How might these things affect people’s health in the long term?',
      [
        'Diet',
        'Exercise',
        'Stress at work',
        'Friendships',
        'Where people live',
      ],
      'Which should governments pay most attention to?',
    ),
    discussion: [
      'How far should employers be responsible for the well-being of their '
          'staff?',
      'Should unhealthy food be taxed more heavily?',
      'Is staying healthy the responsibility of the individual or of '
          'society?',
      'Why do people find it so hard to change their habits, even when they '
          'know they should?',
    ],
  ),
  SpeakingTest(
    interview: [
      'What is the most useful thing you have learned outside a classroom?',
      'Do you think you are more like your parents than you used to be?',
      'If you had a year off, how would you spend it?',
      'Which period of your life so far would you most like to live again?',
    ],
    photos: PhotoTask(
      'Why might the people have chosen to eat in these places, and how '
      'might the atmosphere affect their meal?',
      [Fotos.mealPicnic, Fotos.mealRestaurant, Fotos.mealStreet],
    ),
    diagram: DiagramTask(
      'How might these things change the way we live in the next twenty '
          'years?',
      [
        'Artificial intelligence',
        'Climate change',
        'Working from home',
        'Longer lives',
        'Online shopping',
      ],
      'Which will have the greatest effect on ordinary people?',
    ),
    discussion: [
      'Are people generally too optimistic or too pessimistic about the '
          'future?',
      'What can older generations learn from younger ones?',
      'Should we be worried about how many decisions are left to machines?',
      'Is it possible to prepare young people for jobs that do not exist '
          'yet?',
    ],
  ),
];
