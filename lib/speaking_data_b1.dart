/// The four parts of the B1 Preliminary Speaking test.
///
/// B1 is not B2 with easier words, and the Speaking test shows it. Part 1 is
/// about your own life and checks that you can move between now, the past and
/// the future. Part 2 is one photograph to describe, not two to compare. Part
/// 3 starts from a situation — a friend is visiting, a class needs a present —
/// rather than from an abstract question. Part 4 asks what you like and do,
/// not what society should.
///
/// In the real test the ideas in Part 3 are drawings. Here they are written,
/// which practises the same conversation.
library;

import 'speaking_data.dart';
import 'speaking_photos.dart';

const List<SpeakingPart> speakingPartsB1 = [
  SpeakingPart(
    number: 1,
    name: 'Interview',
    seconds: 120,
    whatToDo:
        'The examiner asks each of you a few simple questions about yourself: '
        'where you live, what you do, what you like. Answer in a sentence or '
        'two, and add one detail.',
    openers: [
      'I live in… with…',
      'I usually…, because…',
      'My favourite… is…, because…',
      'Last weekend I…',
      'This evening I am going to…',
    ],
    tip:
        'These questions check that you can talk about now, the past and the '
        'future. Listen for the tense in the question and answer in the same '
        'one: “What did you do…?” wants “I went…”, not “I go…”.',
  ),
  SpeakingPart(
    number: 2,
    name: 'Describe a photograph',
    seconds: 60,
    whatToDo:
        'About one minute on your own, describing a photograph. The examiner '
        'tells you what it shows; you say what you can see. Nobody interrupts '
        'you.',
    openers: [
      'In this photograph I can see…',
      'In the background there is… / there are…',
      'On the left… / In the middle… / On the right…',
      'She looks… / They seem to be…',
      'I think it is… because…',
    ],
    tip:
        'Start with the whole scene, then the details: who is there, where '
        'they are, what they are doing, what they are wearing, what the '
        'weather is like. If you do not know a word, describe the thing — “it '
        'is something you use to…” — and keep talking. Silence is the only '
        'wrong answer.',
  ),
  SpeakingPart(
    number: 3,
    name: 'Collaborative task',
    seconds: 180,
    whatToDo:
        'The examiner describes a situation and gives you some ideas. You and '
        'your partner talk about them for two or three minutes and try to '
        'choose one. In the test the ideas are drawings; here they are '
        'written.',
    openers: [
      'What do you think about…?',
      'I think… is a good idea, because…',
      'Yes, but it might be too expensive / too far / boring.',
      'What about…?',
      'So, shall we choose…?',
    ],
    tip:
        'Talk about all the ideas before you choose, and ask your partner '
        'what they think. You do not have to agree — but you do have to '
        'answer what they said, not just say your own idea next.',
  ),
  SpeakingPart(
    number: 4,
    name: 'Discussion',
    seconds: 180,
    whatToDo:
        'The examiner asks you both questions on the topic of Part 3: what you '
        'like, what you usually do, what you think. Give your opinion and say '
        'why.',
    openers: [
      'I really like…, because…',
      'I prefer… to…, because…',
      'In my opinion…',
      'It depends. Sometimes…, but…',
    ],
    tip:
        'Never stop at “yes” or “no”. An opinion, a reason and an example make '
        'a complete B1 answer: “I prefer the beach, because I love swimming — '
        'last summer I went every day.”',
  ),
];

/// Six B1 tests, one for each photograph.
const List<SpeakingTest> speakingTestsB1 = [
  SpeakingTest(
    interview: [
      'Where do you live, and who do you live with?',
      'What do you usually do at the weekend?',
      'Tell us about your favourite food.',
      'What did you do last weekend?',
    ],
    photos: PhotoTask(
      'Your photograph shows people cooking at home. Tell us what you can '
      'see in the photograph.',
      [Fotos.cooking],
    ),
    diagram: DiagramTask(
      'What could you do together?',
      [
        'Visit a museum',
        'Have a picnic',
        'Go shopping',
        'Take a boat trip',
        'Go to the cinema',
      ],
      'Which would be the best?',
      situation:
          'A friend from another country is visiting your town for one day.',
    ),
    discussion: [
      'Do you like visiting new places? Why, or why not?',
      'What do visitors like to see in your town?',
      'Do you prefer holidays in summer or in winter?',
      'Would you like to live in another country one day?',
    ],
  ),
  SpeakingTest(
    interview: [
      'How do you get to school or work every day?',
      'What do you like doing with your friends?',
      'What is your favourite subject, or the best part of your job? Why?',
      'What are you going to do this evening?',
    ],
    photos: PhotoTask(
      'Your photograph shows people playing a sport outdoors. Tell us what '
      'you can see in the photograph.',
      [Fotos.football],
    ),
    diagram: DiagramTask(
      'Which present could you buy?',
      ['Flowers', 'A book', 'A photo of the class', 'Chocolates', 'A plant'],
      'Which is the best present?',
      situation:
          'Your class wants to buy a present for a teacher who is leaving.',
    ),
    discussion: [
      'Do you prefer giving presents or receiving them? Why?',
      'What is the best present you have ever had?',
      'Do you like making presents yourself?',
      'How do people in your country celebrate birthdays?',
    ],
  ),
  SpeakingTest(
    interview: [
      'What time do you usually get up?',
      'What kind of music do you like?',
      'Where did you go on your last holiday?',
      'What are you going to do next summer?',
    ],
    photos: PhotoTask(
      'Your photograph shows people at a market. Tell us what you can see '
      'in the photograph.',
      [Fotos.market],
    ),
    diagram: DiagramTask(
      'What activities could he try?',
      ['Running', 'Swimming', 'Football', 'Cycling', 'Dancing'],
      'Which would be best for him?',
      situation: 'A boy wants to get fitter.',
    ),
    discussion: [
      'Which sports are popular in your country? Do you like them?',
      'Do you prefer doing sport or watching it?',
      'Is it better to do sport alone or in a team?',
      'What did you do in sports lessons at school?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Tell us about your home.',
      'What do you usually have for breakfast?',
      'What did you do on your last birthday?',
      'What are you going to do next weekend?',
    ],
    photos: PhotoTask(
      'Your photograph shows a family by the sea. Tell us what you can see '
      'in the photograph.',
      [Fotos.beach],
    ),
    diagram: DiagramTask(
      'Where could they have it?',
      ['A park', 'A classroom', 'A café', 'The beach', 'Someone’s home'],
      'Which place is the best?',
      situation: 'Some students are planning an end-of-term party.',
    ),
    discussion: [
      'Do you prefer parties at home or in other places? Why?',
      'What do you like to eat at parties?',
      'Do you like dancing? Why, or why not?',
      'Tell us about the last party you went to.',
    ],
  ),
  SpeakingTest(
    interview: [
      'Do you have any brothers or sisters? Tell us about them.',
      'What do you like watching on TV?',
      'What was your favourite toy when you were a child?',
      'Where would you like to go next year?',
    ],
    photos: PhotoTask(
      'Your photograph shows people waiting for a train. Tell us what you '
      'can see in the photograph.',
      [Fotos.station],
    ),
    diagram: DiagramTask(
      'Which animal could they get?',
      ['A dog', 'A cat', 'A fish', 'A rabbit', 'A bird'],
      'Which would be best for them?',
      situation: 'A family is choosing a pet.',
    ),
    discussion: [
      'Would you like to have a pet? Which one, and why?',
      'Is it a good idea for children to have pets?',
      'Is it easier to have a pet in a city or in the countryside?',
      'Have you ever been to a zoo? Did you like it?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Tell us about your best friend.',
      'What do you do in the evenings?',
      'What did you like studying at school?',
      'What are you going to do after this test?',
    ],
    photos: PhotoTask(
      'Your photograph shows people on a camping trip. Tell us what you can '
      'see in the photograph.',
      [Fotos.camping],
    ),
    diagram: DiagramTask(
      'What could she do?',
      [
        'Join a sports club',
        'Take a cooking class',
        'Help at an animal shelter',
        'Join a music group',
        'Go to a language café',
      ],
      'Which would be the best way to make friends?',
      situation: 'A girl has moved to a new town and wants to make friends.',
    ),
    discussion: [
      'Is it better to spend your free time with friends or with family?',
      'How did you meet your best friend?',
      'Is it easy to make friends online?',
      'What makes someone a good friend?',
    ],
  ),
];
