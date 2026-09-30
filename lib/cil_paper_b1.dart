/// Original B1 Preliminary Reading practice written for Cíl.
///
/// B1 is not "easier B2", and this paper follows B1's own shape rather than a
/// shortened B2 one: six parts, 32 questions, one mark each, and no separate
/// Use of English — the grammar lives in Parts 5 and 6. The texts are everyday
/// ones, notices, a text message, a club list, a teenager's story, because
/// that is what the real paper reads.
///
/// Every answer carries a comment for after marking. The distractors are
/// built on the traps B1 actually sets: a word that appears in the text with
/// the wrong meaning, a person who matches two requirements out of three.
library;

import 'cambridge.dart';

const ExamPaper cilPaperB1 = ExamPaper(
  id: 'cil-b1-1-reading',
  name: 'Cíl B1 Paper 1 · Reading',
  source: PaperSource.cil,
  level: ExamLevel.b1,
  minutes: 45,
  note:
      "A swimming pool, a new language next door and a summer at the zoo. "
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
              "1  Notice at the swimming pool\n“The pool will close at 6 pm "
              "on Friday for cleaning. Friday’s evening swimming lessons will "
              "take place on Saturday morning instead.”",
          options: [
            "Some lessons are moving to a different day.",
            "The pool will be closed all day on Friday.",
            "Swimmers must help to clean the pool on Saturday.",
          ],
          explanation:
              "“Instead” moves Friday evening’s lessons to Saturday morning. "
              "The pool only closes at 6 pm, not for the whole day.",
        ),
        ExamItem(
          number: 2,
          stem:
              "2  Text message\n“Hi Tom, the film starts at 8, not 7.30 like "
              "I said. Let’s meet at the café opposite the cinema at 7.15 and "
              "have something to eat first. — Maya”",
          options: [
            "Maya is cancelling their plan to see the film.",
            "Maya is correcting information she gave Tom earlier.",
            "Maya wants to eat something after the film.",
          ],
          explanation:
              "“Not 7.30 like I said” shows Maya is correcting what she told "
              "Tom before. They still see the film, and they eat first.",
        ),
        ExamItem(
          number: 3,
          stem:
              "3  Note in a shared kitchen\n“Please wash your plates and cups "
              "straight after you use them. The dishwasher is only for pans "
              "and large dishes.”",
          options: [
            "Nobody is allowed to use the dishwasher.",
            "Pans must be washed as soon as they are used.",
            "Plates should not go in the dishwasher.",
          ],
          explanation:
              "The dishwasher is only for pans and large dishes, so plates "
              "and cups are washed by hand. Nothing says when pans are washed.",
        ),
        ExamItem(
          number: 4,
          stem:
              "4  Advertisement\n“Bike for sale. Only used for one summer. The "
              "price includes lights and a lock. The buyer must collect it "
              "from my house. Call Jakub after 5 pm.”",
          options: [
            "Jakub will take the bike to the buyer’s home.",
            "The buyer will get more than just the bike.",
            "The bike has been used for several years.",
          ],
          explanation:
              "The price includes lights and a lock, so the buyer gets more "
              "than the bike. The buyer collects it: Jakub does not deliver.",
        ),
        ExamItem(
          number: 5,
          stem:
              "5  Sign at the city museum\n“Students with a student card get "
              "in free on Wednesdays. On all other days they pay half price.”",
          options: [
            "Students can only visit the museum on Wednesdays.",
            "Students need their card only on Wednesdays.",
            "Students always pay less than the full price.",
          ],
          explanation:
              "Free on Wednesdays, half price on the other days: either way "
              "students pay less than the full price, and on any day.",
        ),
      ],
      answers: {1: "A", 2: "B", 3: "C", 4: "B", 5: "C"},
    ),
    ExamPart(
      number: 2,
      name: "Matching",
      blurb: "Five people looking for a club, eight clubs to choose from.",
      from: 6,
      to: 10,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      howToAnswer:
          "One letter, A to H. Three clubs are never used. Check every "
          "requirement, not just the first one you see.",
      passage:
          "CLUBS IN TOWN\n\n"
          "A  Green Hands\nVolunteers meet every Saturday to plant trees and "
          "clean up the river banks. We work in teams of four or five, and all "
          "the equipment is provided. Everyone is welcome, whatever their age."
          "\n\n"
          "B  Sunrise Runners\nA friendly running group for 16- to "
          "20-year-olds. We meet in the park at 9 am every Sunday for a 5 km "
          "run, then have breakfast together.\n\n"
          "C  World Kitchen\nOnce a month, one member cooks a dish from their "
          "home country and teaches the others how to make it. We share the "
          "cost of the ingredients, and membership is free.\n\n"
          "D  The Open Stage\nEvery Thursday evening, musicians of any level "
          "can play one song on our stage at the Blue Café. No rehearsals — "
          "just turn up and play!\n\n"
          "E  Talk & Paint\nAn art club for learners of English. We meet on "
          "Tuesday and Thursday evenings to paint and draw, and all our "
          "conversation is in English.\n\n"
          "F  Street Sounds\nA band for young musicians that rehearses every "
          "Wednesday. At the end of each term we give a concert in the town "
          "square.\n\n"
          "G  Chef’s Table\nLearn to cook like a professional on this "
          "ten-week course with a well-known local chef. The course fee "
          "includes all ingredients.\n\n"
          "H  Mountain Walkers\nLong walks in the hills every Saturday for "
          "adults over 25. Bring your own lunch and good boots.",
      items: [
        ExamItem(
          number: 6,
          stem:
              "6  Lena is 17 and wants to do something active outdoors with "
              "people her own age. She is only free on Sunday mornings.",
          explanation:
              "Sunrise Runners is for 16- to 20-year-olds, runs outdoors and "
              "meets on Sunday mornings. Mountain Walkers is on Saturdays and "
              "for over-25s.",
        ),
        ExamItem(
          number: 7,
          stem:
              "7  Omar loves cooking and wants to learn to make food from "
              "other countries. He does not want to pay to join a club.",
          explanation:
              "World Kitchen teaches dishes from members’ home countries and "
              "membership is free. Chef’s Table is cooking, but it has a fee.",
        ),
        ExamItem(
          number: 8,
          stem:
              "8  Sofia wants to practise speaking English while doing "
              "something creative. She can only go out on weekday evenings.",
          explanation:
              "Talk & Paint combines drawing and painting with conversation "
              "in English, on Tuesday and Thursday evenings.",
        ),
        ExamItem(
          number: 9,
          stem:
              "9  Daniel is interested in nature and would like to do "
              "something useful for the environment. He prefers working in a "
              "small group.",
          explanation:
              "Green Hands plants trees and cleans the river in teams of four "
              "or five. Mountain Walkers is in nature but does not help it.",
        ),
        ExamItem(
          number: 10,
          stem:
              "10  Mia plays the guitar. She wants to practise with other "
              "musicians every week and to perform in front of an audience.",
          explanation:
              "Street Sounds rehearses weekly and gives concerts. The Open "
              "Stage has an audience, but there are no rehearsals together.",
        ),
      ],
      answers: {6: "B", 7: "C", 8: "E", 9: "A", 10: "F"},
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
          "A NEW LANGUAGE NEXT DOOR\n\n"
          "When Noor was fourteen, a new family moved into the flat next to "
          "hers. Their daughter, Eva, was the same age, and the two girls "
          "often saw each other on the stairs. But they never spoke. Eva was "
          "deaf, and Noor didn’t know how to start a conversation. “I smiled "
          "every time,” Noor says, “and then I felt stupid for not doing "
          "more.”\n\n"
          "One day Noor found a free online course in sign language. She only "
          "planned to learn how to say hello, but she enjoyed it so much that "
          "she practised every evening for three months. The next time she "
          "met Eva on the stairs, she signed: “Hi, I’m Noor. I’m learning.” "
          "Eva laughed — not unkindly — and corrected one of her signs.\n\n"
          "After that, the girls met twice a week. Eva taught Noor the signs "
          "that young people actually use, which were often different from "
          "the ones in the course. “The course taught me to sign like a "
          "teacher,” Noor explains. “Eva taught me to sign like a "
          "teenager.”\n\n"
          "Learning wasn’t always easy. Noor’s hands got tired, and sometimes "
          "she forgot whole sentences. What helped most, she says, was not "
          "being afraid of making mistakes. Eva never minded when Noor got "
          "something wrong, as long as she kept trying.\n\n"
          "Two years later, Noor and Eva run a small sign-language club at "
          "their school. About fifteen students come every Friday. “Some of "
          "them just want to learn a few words,” Noor says. “That’s fine. A "
          "few words were how I started too.”",
      items: [
        ExamItem(
          number: 11,
          stem: "11  Why did Noor feel bad before she learned sign language?",
          options: [
            "Eva never smiled back at her on the stairs.",
            "She wanted to do more than just smile at Eva.",
            "Her family did not want her to talk to the neighbours.",
            "She thought Eva was unfriendly.",
          ],
          explanation:
              "Noor smiled but “felt stupid for not doing more”: she wanted "
              "to communicate. Nothing in the text says Eva was unfriendly.",
        ),
        ExamItem(
          number: 12,
          stem: "12  What was Noor’s plan when she started the course?",
          options: [
            "To learn enough to have long conversations.",
            "To become a sign-language teacher.",
            "To learn only a basic greeting.",
            "To finish the course in three months.",
          ],
          explanation:
              "She “only planned to learn how to say hello”. The three months "
              "of practice happened because she enjoyed it, not as a plan.",
        ),
        ExamItem(
          number: 13,
          stem: "13  How did Eva react when Noor first signed to her?",
          options: [
            "She was upset that Noor had made a mistake.",
            "She did not understand what Noor was saying.",
            "She pretended not to notice.",
            "She found it funny but was friendly.",
          ],
          explanation:
              "Eva “laughed — not unkindly — and corrected one of her signs”: "
              "she was amused, and she helped.",
        ),
        ExamItem(
          number: 14,
          stem:
              "14  What was different about what Eva taught compared with the "
              "course?",
          options: [
            "Eva taught the signs people of her age really use.",
            "Eva’s lessons were more difficult than the course.",
            "Eva only taught grammar.",
            "The course had been written for teachers.",
          ],
          explanation:
              "Eva taught “the signs that young people actually use”. “Sign "
              "like a teacher” describes the course’s style, not its readers.",
        ),
        ExamItem(
          number: 15,
          stem: "15  What does Noor say helped her most?",
          options: [
            "Practising until her hands got tired.",
            "Joining a club at her school.",
            "Not being afraid of getting things wrong.",
            "Learning whole sentences by heart.",
          ],
          explanation:
              "“What helped most … was not being afraid of making mistakes.” "
              "Tired hands and forgotten sentences were the difficulties.",
        ),
      ],
      answers: {11: "B", 12: "C", 13: "D", 14: "A", 15: "C"},
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
          "MY SUMMER AT THE ZOO\n\n"
          "Last summer I got a job helping the keepers at our local zoo. I "
          "had always loved animals, so I thought it would be easy. (16) ___ "
          "By eight o’clock I had already cleaned two enclosures and carried "
          "heavy bags of food across the park.\n\n"
          "My main job was with the penguins. Every morning I prepared their "
          "fish and checked that each bird was eating properly. (17) ___ The "
          "keepers could tell them apart immediately, but it took me three "
          "weeks to learn all their names.\n\n"
          "The part I enjoyed most was talking to visitors. Children always "
          "asked the same questions: do penguins get cold, and can they fly? "
          "(18) ___ By the end of the summer I could answer them without "
          "thinking.\n\n"
          "Not every day was fun. In July there was a heatwave, and we had to "
          "keep the animals cool. (19) ___ It was hard work, but none of the "
          "animals got ill.\n\n"
          "On my last day, the keepers gave me a photo of the penguin I liked "
          "best. (20) ___ I am now planning to study biology, and I hope to "
          "work with animals again one day.\n\n"
          "THE MISSING SENTENCES\n\n"
          "A  At first I was nervous because I didn’t know the answers.\n"
          "B  I was wrong — the day started at six in the morning.\n"
          "C  This was harder than it sounds, because they all look almost "
          "the same.\n"
          "D  We filled their pools with ice and sprayed the elephants with "
          "water several times a day.\n"
          "E  It is now on the wall above my desk.\n"
          "F  Feeding them was the only part of the job I didn’t like.\n"
          "G  Luckily, the zoo was closed on the hottest days.\n"
          "H  Some visitors complained that the animals were always asleep.",
      items: [
        ExamItem(
          number: 16,
          stem: "16",
          explanation:
              "“I thought it would be easy” needs a contrast: “I was wrong”. "
              "The early start explains how she had done so much by eight.",
        ),
        ExamItem(
          number: 17,
          stem: "17",
          explanation:
              "“They all look almost the same” explains the next sentence: "
              "the keepers could tell them apart, but it took her weeks.",
        ),
        ExamItem(
          number: 18,
          stem: "18",
          explanation:
              "The children’s questions come first. “At first I didn’t know "
              "the answers” contrasts with answering them easily later.",
        ),
        ExamItem(
          number: 19,
          stem: "19",
          explanation:
              "Ice and water are how they kept the animals cool in the "
              "heatwave, and that is why it was hard work. G contradicts it.",
        ),
        ExamItem(
          number: 20,
          stem: "20",
          explanation:
              "“It” refers to the photo of the penguin. The unused sentences "
              "either contradict the text or have nothing to refer back to.",
        ),
      ],
      answers: {16: "B", 17: "C", 18: "A", 19: "D", 20: "E"},
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
          "THE FIRST SANDWICH\n\n"
          "Many people believe that the sandwich got its name from John "
          "Montagu, the Earl of Sandwich, who lived in England in the 18th "
          "century. The story (21) ___ that he loved playing cards so much "
          "that he did not want to stop for dinner. Instead, he asked his "
          "servant to bring him some meat (22) ___ two pieces of bread. That "
          "way, he could eat with one hand and hold his cards with the "
          "(23) ___.\n\n"
          "Other people soon started to ask for “the same as Sandwich”, and "
          "the name became popular. (24) ___, people had been eating bread "
          "with other food for thousands of years before this. What the Earl "
          "did was give the idea a name that was easy to (25) ___.\n\n"
          "Today, the sandwich is one of the most popular meals in the world, "
          "and it is (26) ___ to imagine a school lunchbox without one.",
      items: [
        ExamItem(
          number: 21,
          stem: "21",
          options: ["tells", "talks", "says", "speaks"],
          explanation:
              "“The story says that…” is how English reports what a story "
              "tells us. Tells needs a person after it: it tells us that.",
        ),
        ExamItem(
          number: 22,
          stem: "22",
          options: ["between", "among", "through", "across"],
          explanation:
              "Between is for two things — two pieces of bread. Among is for "
              "three or more.",
        ),
        ExamItem(
          number: 23,
          stem: "23",
          options: ["another", "second", "others", "other"],
          explanation:
              "“With one hand … with the other”: the other means the second "
              "of two. Another means one more of many.",
        ),
        ExamItem(
          number: 24,
          stem: "24",
          options: ["Although", "However", "Despite", "Because"],
          explanation:
              "However starts a new sentence with a contrast. Although and "
              "despite must join two ideas inside the same sentence.",
        ),
        ExamItem(
          number: 25,
          stem: "25",
          options: ["remember", "remind", "memory", "reminder"],
          explanation:
              "Remember means keep something in your mind. Remind needs a "
              "person — it reminds me of — and memory is a noun.",
        ),
        ExamItem(
          number: 26,
          stem: "26",
          options: ["heavy", "strong", "hard", "serious"],
          explanation:
              "“It is hard to imagine” means it is difficult. Heavy, strong "
              "and serious are not used with imagine like this.",
        ),
      ],
      answers: {21: "C", 22: "A", 23: "D", 24: "B", 25: "A", 26: "C"},
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
          "AN EMAIL FROM ANA\n\n"
          "Hi Carla,\n\n"
          "Thanks (27) ___ your message! I’m really happy you’re coming to "
          "stay with us next month, and my parents are looking forward to "
          "meeting you too.\n\n"
          "You asked what to bring. The weather here is usually warm in May, "
          "but it can rain, (28) ___ bring a jacket just in case. We’ll "
          "probably go to the beach at the weekend, so don’t forget your "
          "swimsuit.\n\n"
          "My brother has offered to pick you (29) ___ from the airport, "
          "(30) ___ that means you won’t need to take a taxi. Can you send me "
          "your flight number? If you don’t (31) ___ it yet, just tell me what "
          "time you arrive.\n\n"
          "I can’t wait to show you around. There’s so much (32) ___ do "
          "here!\n\n"
          "Love,\nAna",
      items: [
        ExamItem(
          number: 27,
          stem: "27",
          explanation:
              "“Thanks for” + a noun or -ing is fixed: thanks for your "
              "message, thanks for coming.",
        ),
        ExamItem(
          number: 28,
          stem: "28",
          explanation:
              "So introduces a result: it can rain, so bring a jacket. The "
              "comma before the gap is a clue that a linker is missing.",
        ),
        ExamItem(
          number: 29,
          stem: "29",
          explanation:
              "Pick someone up means collect them, usually by car. With a "
              "pronoun the object goes in the middle: pick you up.",
        ),
        ExamItem(
          number: 30,
          stem: "30",
          explanation:
              "The second part adds a result: her brother collects her, and "
              "that means no taxi. So works here too.",
        ),
        ExamItem(
          number: 31,
          stem: "31",
          explanation:
              "“Don’t have it yet” or “don’t know it yet”: a flight number is "
              "something you have or know. Yet goes with negatives.",
        ),
        ExamItem(
          number: 32,
          stem: "32",
          explanation:
              "After much, a lot or nothing, English uses to + infinitive for "
              "what can be done: so much to do, nothing to eat.",
        ),
      ],
      answers: {
        27: "for",
        28: "so",
        29: "up",
        30: "and/so",
        31: "have/know",
        32: "to",
      },
    ),
  ],
);
