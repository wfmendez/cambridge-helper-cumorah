/// Speaking tests for B1 Preliminary for Schools and B2 First for Schools.
///
/// The for Schools exams have the same four parts, the same timings and the
/// same marking as the general ones, so [speakingPartsFor] serves both. What
/// changes is what the examiner asks about: school, friends, sport, hobbies,
/// family and holidays, and never jobs, offices or running a home.
///
/// Written for Cíl, not copied from a Cambridge paper. The photographs are
/// the same Unsplash ones the general tests use, paired differently and
/// asked about from a teenager's side.
library;

import 'speaking_data.dart';
import 'speaking_photos.dart';

/// Six B1 Preliminary for Schools tests, one for each B1 photograph.
///
/// En la Parte 2 la consigna es la misma que en el examen general: el
/// examinador solo dice qué muestra la foto. Lo adaptado está en lo demás.
const List<SpeakingTest> speakingTestsB1Schools = [
  SpeakingTest(
    interview: [
      'Which school do you go to, and how do you get there?',
      'What do you like doing after school?',
      'Who do you usually have lunch with at school?',
      'What did you do in your last school holidays?',
    ],
    photos: PhotoTask(
      'Your photograph shows people cooking at home. Tell us what you can '
      'see in the photograph.',
      [Fotos.cooking],
    ),
    diagram: DiagramTask(
      'What could the class sell at the cake sale?',
      ['Cupcakes', 'Fruit salad', 'Cookies', 'Lemonade', 'Pizza slices'],
      'Which would sell best?',
      situation:
          'Your class is having a cake sale to raise money for the school '
          'library.',
    ),
    discussion: [
      'Do you ever cook at home? What do you make?',
      'Do you prefer eating at school or at home? Why?',
      'Would you like to have cooking lessons at school?',
      'What food do you and your friends like to share?',
    ],
  ),
  SpeakingTest(
    interview: [
      'How many people are there in your family?',
      'What sports do you do at school?',
      'What is your favourite day of the week, and why?',
      'What are you going to do this weekend?',
    ],
    photos: PhotoTask(
      'Your photograph shows people playing a sport outdoors. Tell us what '
      'you can see in the photograph.',
      [Fotos.football],
    ),
    diagram: DiagramTask(
      'Which sport could the new club offer?',
      ['Basketball', 'Climbing', 'Table tennis', 'Volleyball', 'Skateboarding'],
      'Which sport would most students enjoy?',
      situation:
          'A new sports club is starting at your school, and the students '
          'can choose the sport.',
    ),
    discussion: [
      'Do you prefer playing sport at school or outside school?',
      'Which sport would you like to try one day?',
      'Do you and your friends watch sport together? Where?',
      'Should students do sport every day at school?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Tell us about your bedroom.',
      'What do you usually buy with your pocket money?',
      'Who is your favourite teacher, and why?',
      'What did you do yesterday evening?',
    ],
    photos: PhotoTask(
      'Your photograph shows people at a market. Tell us what you can see '
      'in the photograph.',
      [Fotos.market],
    ),
    diagram: DiagramTask(
      'What present could you give your friend?',
      [
        'A T-shirt',
        'Concert tickets',
        'A video game',
        'A phone case',
        'A board game',
      ],
      'Which present would your friend like most?',
      situation:
          'It is your friend’s fifteenth birthday next week, and you want to '
          'buy a present together.',
    ),
    discussion: [
      'Do you like going shopping with your friends? Why, or why not?',
      'Do you prefer shopping in markets, in shops or online?',
      'How do you and your friends celebrate birthdays?',
      'Do you think teenagers should save their money or spend it?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Where do you usually go on holiday with your family?',
      'What do you like doing in the summer?',
      'Tell us about your best friend at school.',
      'What are you going to do after school today?',
    ],
    photos: PhotoTask(
      'Your photograph shows a family by the sea. Tell us what you can see '
      'in the photograph.',
      [Fotos.beach],
    ),
    diagram: DiagramTask(
      'Where could the class go on the trip?',
      [
        'The beach',
        'A theme park',
        'A science museum',
        'A farm',
        'A national park',
      ],
      'Which place would be the most fun?',
      situation:
          'Your class is going on a one-day school trip at the end of the '
          'year.',
    ),
    discussion: [
      'Do you prefer holidays with your family or with your friends?',
      'What is the best school trip you have ever been on?',
      'Do you like swimming in the sea or in a pool?',
      'Is it better to stay at home or go away in the holidays?',
    ],
  ),
  SpeakingTest(
    interview: [
      'How long have you lived in your town?',
      'What do you do in your break time at school?',
      'What kind of games do you like playing?',
      'What did you do last Saturday?',
    ],
    photos: PhotoTask(
      'Your photograph shows people waiting for a train. Tell us what you '
      'can see in the photograph.',
      [Fotos.station],
    ),
    diagram: DiagramTask(
      'How could the students travel to the city?',
      ['By train', 'By bus', 'By bike', 'In a parent’s car', 'By boat'],
      'Which is the best way to travel?',
      situation:
          'A group of students wants to visit a city near their town on '
          'Saturday.',
    ),
    discussion: [
      'How do you usually travel when you go out with friends?',
      'Do you like travelling by train? Why, or why not?',
      'Would you like to go on a long journey one day? Where to?',
      'Is it easy for young people to get around your town?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Do you have a pet? Tell us about it.',
      'What do you like doing with your family at the weekend?',
      'Which school subject do you find easiest? Why?',
      'What are you going to do in the next holidays?',
    ],
    photos: PhotoTask(
      'Your photograph shows people on a camping trip. Tell us what you can '
      'see in the photograph.',
      [Fotos.camping],
    ),
    diagram: DiagramTask(
      'What should the students take with them?',
      ['A torch', 'A warm jacket', 'A board game', 'A camera', 'A map'],
      'Which two things are the most important?',
      situation:
          'Some students are going camping with their school for a weekend.',
    ),
    discussion: [
      'Have you ever been camping? Did you enjoy it?',
      'Do you prefer spending time in the countryside or in a city?',
      'What games do you like playing outdoors?',
      'Should schools take students on more trips outside the classroom?',
    ],
  ),
];

/// Six B2 First for Schools tests.
///
/// Las doce fotos de B2 en seis parejas nuevas: ninguna coincide con una
/// pareja de los tests generales, y cada foto sale una sola vez.
const List<SpeakingTest> speakingTestsB2Schools = [
  SpeakingTest(
    interview: [
      'What do you enjoy most about your school?',
      'How do you usually prepare for an important exam?',
      'What would you like to study when you leave school?',
      'Who do you ask for help with your homework?',
    ],
    photos: PhotoTask(
      'Two moments in a student’s life. How might the people be feeling?',
      [Fotos.studyLibrary, Fotos.celebrateGraduation],
    ),
    diagram: DiagramTask(
      'What could help students feel less stressed before exams?',
      [
        'Study groups',
        'More sleep',
        'Sport and exercise',
        'Talking to a teacher',
        'A revision timetable',
      ],
      'Which two would help most?',
    ),
    discussion: [
      'Do you think students today have too many exams?',
      'Is it better to revise alone or with friends?',
      'Should parents help their children with homework?',
      'How important are exam results for a young person’s future?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Which hobby would you like to take up, and why?',
      'Do you play a musical instrument, or would you like to?',
      'What kind of music do you and your friends listen to?',
      'What do you like doing online with your friends?',
    ],
    photos: PhotoTask(
      'Two people learning in their free time. Why might they have chosen to '
      'spend their time like this?',
      [Fotos.studyCafe, Fotos.learnGuitar],
    ),
    diagram: DiagramTask('What after-school clubs could a school start?', [
      'A band',
      'A film club',
      'A coding club',
      'A drama group',
      'A photography club',
    ], 'Which two clubs would be the most popular?'),
    discussion: [
      'Should schools teach more creative subjects like music and art?',
      'Is it better to learn a hobby from a teacher or from online videos?',
      'Do young people today have enough free time?',
      'Why do some people give up a hobby after a few months?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Where do you and your friends like to meet at the weekend?',
      'Tell us about a friend you have known for a long time.',
      'Do you prefer going out or staying at home on Friday evenings?',
      'What is your favourite thing to eat when you go out?',
    ],
    photos: PhotoTask(
      'Friends getting together in different places. Why might they have '
      'chosen to meet there?',
      [Fotos.celebrateBirthday, Fotos.mealPicnic],
    ),
    diagram: DiagramTask(
      'How could a class celebrate the end of the school year?',
      [
        'A picnic in the park',
        'A party in the school hall',
        'A day at the beach',
        'A film night',
        'A sports day',
      ],
      'Which would the whole class enjoy most?',
    ),
    discussion: [
      'Is it important to stay in touch with friends from primary school?',
      'Are friendships online as strong as friendships at school?',
      'Should schools organise more social events for students?',
      'How do teenagers today decide where to meet their friends?',
    ],
  ),
  SpeakingTest(
    interview: [
      'How do you get to school, and how long does it take?',
      'Where do you like spending time outdoors near your home?',
      'What is the best thing about where you live for young people?',
      'Have you ever helped to look after a garden or a park?',
    ],
    photos: PhotoTask(
      'People busy outdoors. What might they enjoy about being outside?',
      [Fotos.jobGarden, Fotos.commuteBike],
    ),
    diagram: DiagramTask(
      'How could a school make students more interested in the environment?',
      [
        'A school garden',
        'Cycling to school',
        'Recycling bins in every classroom',
        'Trips to a nature park',
        'A day without plastic',
      ],
      'Which idea would make the biggest difference?',
    ),
    discussion: [
      'Do teenagers care more about the planet than their parents do?',
      'Should students help to look after their school, for example by '
          'gardening?',
      'Is it safe for teenagers to cycle in your town?',
      'What could you change in your daily life to help the planet?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Are you good at making or fixing things?',
      'Which school subject do you enjoy most, and why?',
      'What job would you like to have one day?',
      'Have you ever earned money by helping someone?',
    ],
    photos: PhotoTask(
      'Two people making something with their hands. What might be difficult '
      'about what they are doing?',
      [Fotos.jobConstruction, Fotos.learnPottery],
    ),
    diagram: DiagramTask(
      'What could students learn in a week of practical lessons at school?',
      [
        'Cooking',
        'First aid',
        'Repairing a bike',
        'Building a website',
        'Managing money',
      ],
      'Which two would be the most useful?',
    ),
    discussion: [
      'Should schools teach more practical skills and fewer academic '
          'subjects?',
      'Is it a good idea for teenagers to have a part-time job?',
      'What skills do young people learn from their parents?',
      'Why do some people prefer making things to buying them?',
    ],
  ),
  SpeakingTest(
    interview: [
      'Do you live in a city, a town or a village?',
      'What do you like doing when you go into town?',
      'Tell us about a family meal you enjoyed.',
      'What are you looking forward to at school this year?',
    ],
    photos: PhotoTask(
      'People in busy places in a city. What might they like and dislike '
      'about being there?',
      [Fotos.commuteMetro, Fotos.mealRestaurant],
    ),
    diagram: DiagramTask(
      'What could a town do to give teenagers more things to do?',
      [
        'A youth centre',
        'A skate park',
        'Free concerts',
        'Cheaper buses',
        'A climbing wall',
      ],
      'Which would young people use most?',
    ),
    discussion: [
      'Is it better for teenagers to grow up in a city or in the countryside?',
      'At what age should young people be allowed to go into town alone?',
      'Do families spend enough time together these days?',
      'What will your town be like when you are older?',
    ],
  ),
];
