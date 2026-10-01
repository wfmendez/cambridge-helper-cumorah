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
    prompts: [
      'Where do you live, and who do you live with?',
      'What do you usually do at the weekend?',
      'Tell us about your favourite food.',
      'How do you get to school or work every day?',
      'What do you like doing with your friends?',
      'What is your favourite subject, or the best part of your job? Why?',
      'What did you do last weekend?',
      'What are you going to do this evening?',
    ],
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
    photoTasks: [
      PhotoTask(
        'Your photograph shows people cooking at home. Tell us what you can '
        'see in the photograph.',
        [Fotos.cooking],
      ),
      PhotoTask(
        'Your photograph shows people playing a sport outdoors. Tell us what '
        'you can see in the photograph.',
        [Fotos.football],
      ),
      PhotoTask(
        'Your photograph shows people at a market. Tell us what you can see '
        'in the photograph.',
        [Fotos.market],
      ),
      PhotoTask(
        'Your photograph shows a family by the sea. Tell us what you can see '
        'in the photograph.',
        [Fotos.beach],
      ),
      PhotoTask(
        'Your photograph shows people waiting for a train. Tell us what you '
        'can see in the photograph.',
        [Fotos.station],
      ),
      PhotoTask(
        'Your photograph shows people on a camping trip. Tell us what you can '
        'see in the photograph.',
        [Fotos.camping],
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
    prompts: [
      'A friend is visiting your town for one day. Talk about the things you '
          'could do together — a museum, a picnic, shopping, a boat trip, the '
          'cinema — and decide which would be best.',
      'Your class wants to buy a present for a teacher who is leaving. Talk '
          'about the ideas — flowers, a book, a photo of the class, '
          'chocolates, a plant — and decide which is the best present.',
      'A boy wants to get fitter. Talk about the activities he could try — '
          'running, swimming, football, cycling, dancing — and decide which '
          'would be best for him.',
      'Some students are planning an end-of-term party. Talk about the places '
          'they could have it — a park, a classroom, a café, the beach, '
          'someone’s home — and decide which is best.',
      'A family is choosing a pet. Talk about the animals — a dog, a cat, a '
          'fish, a rabbit, a bird — and decide which would be best for them.',
    ],
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
    prompts: [
      'Do you like visiting new places? Why, or why not?',
      'Do you prefer giving presents or receiving them? Why?',
      'Which sports are popular in your country? Do you like them?',
      'Do you prefer parties at home or in other places? Why?',
      'Is it better to spend your free time with friends or with family?',
      'Would you like to have a pet? Which one, and why?',
    ],
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
