/// Cíl B1 Paper 3 · Reading — original B1 Preliminary practice.
///
/// Same shape as the real paper and as Papers 1 and 2: six parts, 32
/// questions, one mark each. See cil_paper_b1.dart for why B1 gets papers of
/// its own rather than shortened B2 ones.
library;

import 'cambridge.dart';

const ExamPaper cilB1Paper3 = ExamPaper(
  id: 'cil-b1-3-reading',
  name: 'Cíl B1 Paper 3 · Reading',
  source: PaperSource.cil,
  level: ExamLevel.b1,
  minutes: 45,
  note:
      "Counting birds, a week of cooking dinner and the story of tea. "
      "Original B1 Preliminary practice with a comment for every answer.",
  parts: [
    ExamPart(
      number: 1,
      name: "Signs and short messages",
      blurb: "Five very short texts, each with one question.",
      from: 1,
      to: 5,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      howToAnswer:
          "One letter: A, B or C. Ask yourself who wrote the text and who it "
          "is for.",
      items: [
        ExamItem(
          number: 1,
          stem:
              "1  Sign in a shop window\n“Sale ends Saturday! All winter "
              "coats half price. Shoes and bags are not included.”",
          options: [
            "Everything in the shop is cheaper until Saturday.",
            "Only some things are reduced in the sale.",
            "Coats will be half price from Saturday.",
          ],
          explanation:
              "Coats are half price, but shoes and bags are not included, so "
              "only some things are cheaper. The sale ends on Saturday.",
        ),
        ExamItem(
          number: 2,
          stem:
              "2  Note from a parent\n“Anna, the dentist rang. Your "
              "appointment on Tuesday has been cancelled because she is ill. "
              "Phone them to choose a new time. Dad”",
          options: [
            "Anna should arrange another appointment.",
            "Anna’s dad has booked a new time for her.",
            "Anna needs to go to the dentist on Tuesday.",
          ],
          explanation:
              "“Phone them to choose a new time” is for Anna to do. Tuesday "
              "is cancelled, and her dad has not booked anything.",
        ),
        ExamItem(
          number: 3,
          stem:
              "3  Sign in a park\n“Dogs are welcome in this park, but they "
              "must be kept on a lead near the children’s playground.”",
          options: [
            "Dogs are not allowed in the park.",
            "Dogs must stay away from the playground.",
            "In one part of the park, dogs cannot run free.",
          ],
          explanation:
              "Dogs are welcome everywhere, and near the playground they "
              "need a lead. They may be there — they just cannot run free.",
        ),
        ExamItem(
          number: 4,
          stem:
              "4  Email from a teacher\n“Your history projects are due on "
              "Monday. If you send them by email, please use PDF only — I "
              "cannot open other files on the school computer.”",
          options: [
            "Projects must be handed in on paper.",
            "Emailed projects need to be in a particular format.",
            "The teacher will mark the projects on Monday.",
          ],
          explanation:
              "“PDF only” is a particular format. Email is allowed, and "
              "Monday is when the projects are due, not when they are marked.",
        ),
        ExamItem(
          number: 5,
          stem:
              "5  Note on a café door\n“Back in 10 minutes — gone to the "
              "bank. If you are in a hurry, the bakery next door also sells "
              "coffee.”",
          options: [
            "Customers can get a drink somewhere nearby.",
            "The café is closed for the rest of the day.",
            "The bakery is closed for ten minutes.",
          ],
          explanation:
              "The bakery next door sells coffee too. It is the café that is "
              "closed, and only for ten minutes.",
        ),
      ],
      answers: {1: "B", 2: "A", 3: "C", 4: "B", 5: "A"},
    ),
    ExamPart(
      number: 2,
      name: "Matching",
      blurb: "Five people planning a short holiday, eight trips.",
      from: 6,
      to: 10,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      howToAnswer:
          "One letter, A to H. Three trips are never used. Check every "
          "requirement, not just the first one you see.",
      passage:
          "SHORT BREAKS\n\n"
          "A  Castle Country by Coach\nVisit five castles in three days with "
          "an expert guide. The coach stops at the entrance to each one, so "
          "there is very little walking.\n\n"
          "B  Surf School Week\nDaily surfing lessons for beginners, with all "
          "the equipment provided. You stay in a small hotel two minutes "
          "from the beach.\n\n"
          "C  Hillside Cabins\nSimple wooden cabins in the hills, each with "
          "its own kitchen. At these prices, a week here costs less than a "
          "weekend in a hotel.\n\n"
          "D  The Lake Path\nA five-day walk around the lake, 15 to 20 "
          "kilometres a day. Your bags are carried ahead to a new guesthouse "
          "every evening.\n\n"
          "E  Blue Bay Resort\nDo as much or as little as you like. Three "
          "restaurants, a spa and a quiet pool — and you never have to open "
          "your wallet, because everything is in the price.\n\n"
          "F  City Museums Pass\nSee six museums at your own speed with one "
          "ticket. There is no guide: an app tells you where to go. Expect a "
          "lot of walking between them.\n\n"
          "G  Mountain Sports Camp\nClimbing, kayaking and mountain biking "
          "with instructors, high in the mountains. Shared rooms, with meals "
          "included.\n\n"
          "H  Farm Stay Deluxe\nA luxury hotel in an old farmhouse in the "
          "countryside, with a famous restaurant. Breakfast and dinner are "
          "included.",
      items: [
        ExamItem(
          number: 6,
          stem:
              "6  Ivan wants to learn a new sport on his holiday, and he "
              "would like to stay near the sea.",
          explanation:
              "Surf School Week teaches beginners and the hotel is by the "
              "beach. The Mountain Sports Camp teaches sports, but far from "
              "the sea.",
        ),
        ExamItem(
          number: 7,
          stem:
              "7  Petra loves history and wants a guide to explain what she "
              "is seeing. She cannot walk long distances.",
          explanation:
              "Castle Country has an expert guide and very little walking. "
              "The Museums Pass has no guide and a lot of walking.",
        ),
        ExamItem(
          number: 8,
          stem:
              "8  Sam and Jo want a cheap holiday in the countryside where "
              "they can cook their own meals.",
          explanation:
              "Hillside Cabins are cheap, in the hills, and each has a "
              "kitchen. Farm Stay Deluxe is in the countryside but is a "
              "luxury hotel.",
        ),
        ExamItem(
          number: 9,
          stem:
              "9  Lucia wants to relax completely: nothing organised, good "
              "food, and no extra costs once she is there.",
          explanation:
              "At Blue Bay everything is in the price and nothing is "
              "organised for you. Farm Stay only includes two meals.",
        ),
        ExamItem(
          number: 10,
          stem:
              "10  Ben enjoys walking for several hours a day and wants to "
              "sleep in a different place each night.",
          explanation:
              "The Lake Path is a long walk each day with a new guesthouse "
              "every evening. The cabins are in the hills, but you stay put.",
        ),
      ],
      answers: {6: "B", 7: "A", 8: "C", 9: "E", 10: "D"},
    ),
    ExamPart(
      number: 3,
      name: "Multiple choice",
      blurb: "One longer text with five questions on detail and opinion.",
      from: 11,
      to: 15,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      howToAnswer:
          "One letter: A, B, C or D. The questions follow the order of the "
          "text.",
      passage:
          "COUNTING BIRDS\n\n"
          "Ela was twelve when her grandfather gave her his old binoculars. "
          "He did not expect her to use them much. In fact, she spent the "
          "whole of that summer in the garden, writing down every bird she "
          "saw in a notebook.\n\n"
          "At first, Ela could only recognise the common ones. Her "
          "grandfather taught her to listen as well as look, because many "
          "birds are easier to hear than to see. “He never told me the "
          "answer,” Ela says. “He just asked, ‘What do you notice?’ That was "
          "annoying, but it worked.”\n\n"
          "Last spring, Ela joined a national bird count. Thousands of "
          "volunteers across the country watch one small area for an hour "
          "and report what they see. Scientists use the results to find out "
          "which birds are disappearing. Ela chose the park near her school "
          "and went there every Saturday at six in the morning.\n\n"
          "One morning she saw a bird she did not know. She took a "
          "photograph and sent it to the organisers. They wrote back the "
          "same day: it was a species that had not been seen in the region "
          "for over twenty years. A week later, three experts came to the "
          "park, and Ela showed them exactly where to stand.\n\n"
          "Ela’s friends used to think her hobby was strange. Since the "
          "story appeared in the local newspaper, several of them have asked "
          "to come with her. She always says yes — on one condition. “You "
          "have to be quiet,” she says. “The birds don’t care that you were "
          "in the newspaper.”",
      items: [
        ExamItem(
          number: 11,
          stem:
              "11  What did Ela’s grandfather think when he gave her the "
              "binoculars?",
          options: [
            "She would become an expert quickly.",
            "She would probably not be very interested.",
            "She would lose them in the garden.",
            "She would prefer to have a notebook.",
          ],
          explanation:
              "“He did not expect her to use them much.” “In fact” then "
              "introduces what really happened, the opposite of what he "
              "thought.",
        ),
        ExamItem(
          number: 12,
          stem: "12  How did Ela’s grandfather help her to learn?",
          options: [
            "He told her the name of every bird.",
            "He gave her a book about birds.",
            "He made her work things out for herself.",
            "He took her to the park every Saturday.",
          ],
          explanation:
              "He “never told me the answer” and asked what she noticed "
              "instead. Going to the park on Saturdays came later, alone.",
        ),
        ExamItem(
          number: 13,
          stem: "13  What is the national bird count for?",
          options: [
            "To discover which birds are becoming rarer.",
            "To teach young people about nature.",
            "To find new places for birds to live.",
            "To choose the best volunteers.",
          ],
          explanation:
              "Scientists use the results “to find out which birds are "
              "disappearing” — that is, which are becoming rarer.",
        ),
        ExamItem(
          number: 14,
          stem: "14  What happened after Ela sent the photograph?",
          options: [
            "The organisers asked her for more information.",
            "She had to wait a week for a reply.",
            "The newspaper refused to believe her.",
            "She learned that the bird was unusual for the area.",
          ],
          explanation:
              "The reply came the same day: the species had not been seen "
              "there for over twenty years. The week was until the experts "
              "came.",
        ),
        ExamItem(
          number: 15,
          stem: "15  What does Ela tell friends who want to come with her?",
          options: [
            "They should bring their own binoculars.",
            "There are too many of them to come.",
            "They must behave in the right way.",
            "They have to read the newspaper story first.",
          ],
          explanation:
              "She says yes “on one condition”: they have to be quiet. That "
              "is a rule about how to behave, not a refusal.",
        ),
      ],
      answers: {11: "B", 12: "C", 13: "A", 14: "D", 15: "C"},
    ),
    ExamPart(
      number: 4,
      name: "Gapped text",
      blurb: "Five sentences removed from a text, eight to choose from.",
      from: 16,
      to: 20,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      howToAnswer:
          "One letter, A to H. Three sentences are never used. Read what "
          "comes after the gap as well as before it.",
      passage:
          "THE WEEK I COOKED DINNER\n\n"
          "When my mother broke her arm last winter, somebody had to cook "
          "for our family. My father works late, so I offered to do it. "
          "(16) ___ I could make toast and boil an egg, and that was all.\n\n"
          "On Monday I tried to make soup. I followed the recipe carefully, "
          "but I added the salt twice by mistake. (17) ___ We ordered pizza "
          "instead.\n\n"
          "On Tuesday my mother sat in the kitchen and told me what to do, "
          "step by step. (18) ___ By the end of the evening I had made a "
          "simple pasta dish, and everybody had a second plate.\n\n"
          "The rest of the week went much better. I learned that cooking is "
          "mostly about preparation. (19) ___ After that, the actual cooking "
          "is quite fast.\n\n"
          "My mother’s arm is better now, but I still cook every Sunday. "
          "(20) ___ Last week my little brother asked me to teach him.\n\n"
          "THE MISSING SENTENCES\n\n"
          "A  Nobody could eat it, not even the dog.\n"
          "B  My father usually does the shopping on Saturdays.\n"
          "C  I have even started inventing my own recipes.\n"
          "D  The truth is that I had almost no experience.\n"
          "E  Soup is my favourite food in winter.\n"
          "F  She did not touch anything, so I had to do all of it myself.\n"
          "G  If you cut everything up before you start, nothing burns while "
          "you are looking for a knife.\n"
          "H  The pizza arrived cold, which made things worse.",
      items: [
        ExamItem(
          number: 16,
          stem: "16",
          explanation:
              "Offering to cook is followed by the truth about it. “Toast "
              "and an egg, and that was all” is what almost no experience "
              "means.",
        ),
        ExamItem(
          number: 17,
          stem: "17",
          explanation:
              "“It” is the soup with twice the salt, and “instead” needs a "
              "meal that failed. H comes too early: no pizza has been "
              "ordered yet.",
        ),
        ExamItem(
          number: 18,
          stem: "18",
          explanation:
              "“She” is the mother, telling but not touching. That is why "
              "the next sentence can say “I had made” the pasta.",
        ),
        ExamItem(
          number: 19,
          stem: "19",
          explanation:
              "Cutting everything up first is the preparation, and “after "
              "that” in the next sentence points back to it.",
        ),
        ExamItem(
          number: 20,
          stem: "20",
          explanation:
              "“Even” adds to still cooking every Sunday. Inventing recipes "
              "is the step before teaching a little brother.",
        ),
      ],
      answers: {16: "D", 17: "A", 18: "F", 19: "G", 20: "C"},
    ),
    ExamPart(
      number: 5,
      name: "Multiple-choice cloze",
      blurb: "Vocabulary: six gaps with four options each.",
      from: 21,
      to: 26,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      howToAnswer:
          "One letter: A, B, C or D. Read the whole sentence: the word after "
          "the gap often decides.",
      passage:
          "A CUP OF TEA\n\n"
          "Tea is the second most popular drink in the world, after water. "
          "It was first (21) ___ in China thousands of years ago. According "
          "to an old story, some leaves fell into an emperor’s cup of hot "
          "water by (22) ___, and he liked the taste.\n\n"
          "For a long time, tea was very expensive in Europe, and only rich "
          "families could (23) ___ to buy it. People kept it in locked "
          "boxes. Today it is cheap, and it is drunk in almost every "
          "country, (24) ___ in very different ways. In Britain, people "
          "usually add milk. In Morocco, tea is served with fresh mint and a "
          "lot of sugar.\n\n"
          "Many people say that a cup of tea helps them to (25) ___ after a "
          "busy day. Scientists are still not sure (26) ___ this is true, "
          "but millions of tea drinkers believe it.",
      items: [
        ExamItem(
          number: 21,
          stem: "21",
          options: ["raised", "grown", "risen", "increased"],
          explanation:
              "Plants are grown; children and animals are raised. Rise has "
              "no object — prices rise — so it cannot be passive here.",
        ),
        ExamItem(
          number: 22,
          stem: "22",
          options: ["fault", "wrong", "error", "accident"],
          explanation:
              "By accident means without intending it. English says in "
              "error, not by error, and fault is about who is to blame.",
        ),
        ExamItem(
          number: 23,
          stem: "23",
          options: ["afford", "pay", "spend", "cost"],
          explanation:
              "Afford to do something means have enough money for it. Pay "
              "and spend are not followed by to + infinitive like this.",
        ),
        ExamItem(
          number: 24,
          stem: "24",
          options: ["because", "unless", "although", "since"],
          explanation:
              "Although adds a contrast: drunk everywhere, but differently. "
              "Because and since would give a reason, which this is not.",
        ),
        ExamItem(
          number: 25,
          stem: "25",
          options: ["spare", "relax", "stay", "remain"],
          explanation:
              "Relax means become calm after work or stress. Stay and remain "
              "need something after them: stay calm, remain quiet.",
        ),
        ExamItem(
          number: 26,
          stem: "26",
          options: ["unless", "while", "what", "whether"],
          explanation:
              "Not sure whether means not sure if. It introduces a yes-or-no "
              "question inside a sentence: is this true or not?",
        ),
      ],
      answers: {21: "B", 22: "D", 23: "A", 24: "C", 25: "B", 26: "D"},
    ),
    ExamPart(
      number: 6,
      name: "Open cloze",
      blurb:
          "Grammar: six gaps, one word each. This is the closest B1 gets to a "
          "Use of English paper.",
      from: 27,
      to: 32,
      type: AnswerType.word,
      marksPerQuestion: 1,
      howToAnswer: "Exactly one word in each gap.",
      passage:
          "A LETTER TO A NEW STUDENT\n\n"
          "Dear Marco,\n\n"
          "Welcome to our school! My name is Elif, and I will (27) ___ your "
          "guide on your first day. I know that starting at a new school can "
          "be difficult, but there is nothing to worry (28) ___.\n\n"
          "Lessons start at half past eight, so please try to arrive (29) ___ "
          "few minutes early. I will wait for you at the main entrance. You "
          "do not need to bring any books, (30) ___ the teachers will give "
          "you everything on the first morning.\n\n"
          "At lunchtime I will introduce you (31) ___ my friends. We usually "
          "eat outside (32) ___ the weather is good.\n\n"
          "See you on Monday!\nElif",
      items: [
        ExamItem(
          number: 27,
          stem: "27",
          explanation:
              "After will comes the base form of the verb, and the verb "
              "missing here is be: I will be your guide.",
        ),
        ExamItem(
          number: 28,
          stem: "28",
          explanation:
              "Worry about something. The preposition stays even when its "
              "noun has moved away: nothing to worry about.",
        ),
        ExamItem(
          number: 29,
          stem: "29",
          explanation:
              "A few means a small number and goes with countable plurals: a "
              "few minutes, a few friends.",
        ),
        ExamItem(
          number: 30,
          stem: "30",
          explanation:
              "The second half gives the reason for the first, so it needs "
              "because. As and since mean the same and are accepted.",
        ),
        ExamItem(
          number: 31,
          stem: "31",
          explanation:
              "Introduce someone to someone else. Without to, the sentence "
              "would mean the friends are the ones being presented.",
        ),
        ExamItem(
          number: 32,
          stem: "32",
          explanation:
              "If, when or whenever all work: each says the condition under "
              "which they eat outside.",
        ),
      ],
      answers: {
        27: "be",
        28: "about",
        29: "a",
        30: "because/as/since",
        31: "to",
        32: "if/when/whenever",
      },
    ),
  ],
);
