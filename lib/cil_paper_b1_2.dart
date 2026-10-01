/// Cíl B1 Paper 2 · Reading — original B1 Preliminary practice.
///
/// Same shape as the real paper and as Paper 1: six parts, 32 questions, one
/// mark each. See cil_paper_b1.dart for why B1 gets papers of its own rather
/// than shortened B2 ones.
library;

import 'cambridge.dart';

const ExamPaper cilB1Paper2 = ExamPaper(
  id: 'cil-b1-2-reading',
  name: 'Cíl B1 Paper 2 · Reading',
  source: PaperSource.cil,
  level: ExamLevel.b1,
  minutes: 45,
  note:
      "A week without a phone, a school radio station and a city on two "
      "wheels. Original B1 Preliminary practice with a comment for every "
      "answer.",
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
              "1  Sign in a library\n“Quiet study area. Please switch off "
              "your phone or put it on silent. Group work is welcome in Room 2 "
              "on the first floor.”",
          options: [
            "Students must go to Room 2 to use their phones.",
            "People who want to work together should use another room.",
            "Phones are not allowed anywhere in the library.",
          ],
          explanation:
              "Group work is welcome in Room 2, so people working together go "
              "there. Phones are allowed here if they are silent.",
        ),
        ExamItem(
          number: 2,
          stem:
              "2  Email from a teacher\n“Friday’s trip to the science museum "
              "now leaves at 8.15, not 8.45. Bring a packed lunch — the museum "
              "café is closed for repairs. Mr Novak”",
          options: [
            "Students can buy their lunch at the museum.",
            "The trip has been moved to a different day.",
            "Students need to arrive earlier than planned.",
          ],
          explanation:
              "8.15 instead of 8.45 is half an hour earlier. The day has not "
              "changed, and the café is closed, so lunch comes from home.",
        ),
        ExamItem(
          number: 3,
          stem:
              "3  Note on the kitchen table\n“Leo — your football boots are "
              "still wet, so I’ve left them by the heater. Don’t forget them "
              "tomorrow: you’ve got training at 4. Mum”",
          options: [
            "Leo’s mum is reminding him to take his boots.",
            "Leo’s mum wants him to dry his boots.",
            "Leo’s mum is telling him that training is cancelled.",
          ],
          explanation:
              "“Don’t forget them tomorrow” is a reminder. She has already "
              "put the boots by the heater herself, and training is on.",
        ),
        ExamItem(
          number: 4,
          stem:
              "4  Notice at a gym\n“Lockers are emptied every night. Anything "
              "left inside is kept at reception for one week.”",
          options: [
            "Members can leave their things in a locker for a week.",
            "Things left overnight can be collected from reception.",
            "Reception will look after members’ bags during the day.",
          ],
          explanation:
              "Lockers are emptied each night and the things go to reception, "
              "where they wait a week. The week is at reception, not in the "
              "locker.",
        ),
        ExamItem(
          number: 5,
          stem:
              "5  Text message\n“Hi Sam, I can’t lend you my bike on Saturday "
              "after all — my cousin needs it. You could ask Petra: hers is "
              "the same size. Dan”",
          options: [
            "Dan is suggesting another person who might help.",
            "Dan wants Sam to return his bike on Saturday.",
            "Dan’s cousin has borrowed Petra’s bike.",
          ],
          explanation:
              "“You could ask Petra” offers Sam another solution. Sam never "
              "had the bike, and the cousin needs Dan’s, not Petra’s.",
        ),
      ],
      answers: {1: "B", 2: "C", 3: "A", 4: "B", 5: "A"},
    ),
    ExamPart(
      number: 2,
      name: "Matching",
      blurb: "Five people looking for somewhere to eat, eight places.",
      from: 6,
      to: 10,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      howToAnswer:
          "One letter, A to H. Three places are never used. Check every "
          "requirement, not just the first one you see.",
      passage:
          "PLACES TO EAT\n\n"
          "A  The Green Bowl\nFresh salads, soups and vegetable dishes, ready "
          "in minutes. Most meals cost less than a sandwich elsewhere. Two "
          "minutes from the business district; open on weekdays from 11 to "
          "3.\n\n"
          "B  Garden House\nA family restaurant with a large terrace and a "
          "play area with swings. Open for lunch at weekends only.\n\n"
          "C  Night Market Kitchen\nDishes from Laos and Cambodia that you "
          "will not find anywhere else in the city. The kitchen stays open "
          "until midnight.\n\n"
          "D  Page & Bean\nA calm café inside a bookshop, with home-made "
          "cakes, free wifi and a plug at every table. Stay as long as you "
          "like.\n\n"
          "E  Long Table\nOur private room upstairs seats up to twenty guests "
          "at a single table. There is a lift, and the doors are wide. "
          "Please book at least a week ahead.\n\n"
          "F  Burger Stop\nBig burgers and fries, served fast, at low prices. "
          "Next to the central station.\n\n"
          "G  The Old Cellar\nTraditional local dishes in a beautiful room "
          "under the street. Groups are welcome. Sorry: there are stairs "
          "only.\n\n"
          "H  Sunny Corner Café\nA popular café with loud music and a busy "
          "terrace. Great coffee and cakes; at busy times, tables are limited "
          "to one hour.",
      items: [
        ExamItem(
          number: 6,
          stem:
              "6  Hana wants a quick, cheap lunch near her office. She does "
              "not eat meat.",
          explanation:
              "The Green Bowl is fast, cheap, near the business district and "
              "serves vegetable dishes. Burger Stop is fast and cheap, but it "
              "is all burgers.",
        ),
        ExamItem(
          number: 7,
          stem:
              "7  Tomas is planning a birthday dinner for twelve people who "
              "want to sit together. One of them uses a wheelchair.",
          explanation:
              "Long Table seats twenty at one table and has a lift. The Old "
              "Cellar takes groups but can only be reached by stairs.",
        ),
        ExamItem(
          number: 8,
          stem:
              "8  Rosa wants to have lunch outside with her children on "
              "Sunday. The children get bored easily.",
          explanation:
              "Garden House has a terrace, a play area and opens at weekends. "
              "Sunny Corner has a terrace but nothing for children to do.",
        ),
        ExamItem(
          number: 9,
          stem:
              "9  Karl wants to try food from a country whose cooking he has "
              "never tasted. He likes eating late in the evening.",
          explanation:
              "Night Market Kitchen serves food found nowhere else in the "
              "city and cooks until midnight. The Old Cellar is local food.",
        ),
        ExamItem(
          number: 10,
          stem:
              "10  Mei wants a quiet place to have coffee and cake while she "
              "works on her laptop for a few hours.",
          explanation:
              "Page & Bean is calm, has wifi and plugs, and lets you stay. "
              "Sunny Corner has cake too, but it is loud and limits tables.",
        ),
      ],
      answers: {6: "A", 7: "E", 8: "B", 9: "C", 10: "D"},
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
          "A WEEK WITHOUT MY PHONE\nby Lucie, 16\n\n"
          "Last month our teacher gave the class a challenge: live without "
          "our phones for seven days. Most of my friends refused immediately. "
          "I agreed, but only because I was sure it would be easy. I was "
          "wrong about that.\n\n"
          "The first two days were the hardest. I kept putting my hand in my "
          "pocket to check messages that were not there. On the bus to "
          "school I had nothing to look at, so I started watching the other "
          "passengers instead. Almost all of them were looking at their "
          "screens. I had never noticed that before.\n\n"
          "By the middle of the week, something had changed. I was sleeping "
          "better, because I was not reading messages at midnight. I also "
          "finished my homework much faster. The problem was my friends. "
          "They made plans in our group chat, and twice nobody remembered to "
          "tell me. I missed a trip to the cinema, and I felt quite left "
          "out.\n\n"
          "On Friday I solved this in an old-fashioned way: I went to my "
          "friend Dana’s house and knocked on the door. Her mother was so "
          "surprised that she invited me to stay for dinner. Dana and I "
          "talked for three hours, which we never do when we are texting.\n\n"
          "When the week ended, I turned my phone on and found 412 messages "
          "waiting. I read about twenty of them. The rest, I realised, were "
          "not important at all.\n\n"
          "I have not given up my phone — I could not organise my life "
          "without it. But I now leave it in the kitchen at night, and I "
          "visit my friends more often than I message them.",
      items: [
        ExamItem(
          number: 11,
          stem: "11  Why did Lucie agree to the challenge?",
          options: [
            "Her friends were doing it too.",
            "She expected it to be simple.",
            "Her teacher said she had to.",
            "She wanted to sleep better.",
          ],
          explanation:
              "She agreed “only because I was sure it would be easy”. Most of "
              "her friends refused, and better sleep came as a surprise.",
        ),
        ExamItem(
          number: 12,
          stem: "12  What did Lucie notice on the bus?",
          options: [
            "The other passengers were watching her.",
            "The journey seemed shorter than usual.",
            "Nearly everyone was using a phone.",
            "People were talking to each other more.",
          ],
          explanation:
              "“Almost all of them were looking at their screens.” She was "
              "the one watching them, not the other way round.",
        ),
        ExamItem(
          number: 13,
          stem: "13  What was the main difficulty in the middle of the week?",
          options: [
            "She could not finish her homework.",
            "She was not sleeping well.",
            "Her friends were angry with her.",
            "She did not hear about her friends’ plans.",
          ],
          explanation:
              "Plans were made in the group chat and nobody told her. Sleep "
              "and homework had actually got better that week.",
        ),
        ExamItem(
          number: 14,
          stem: "14  What happened when Lucie went to Dana’s house?",
          options: [
            "They had a much longer conversation than usual.",
            "Dana’s mother was annoyed that she had not phoned.",
            "Dana was not at home.",
            "They went to the cinema together.",
          ],
          explanation:
              "They “talked for three hours, which we never do when we are "
              "texting”. Dana’s mother was surprised, not annoyed.",
        ),
        ExamItem(
          number: 15,
          stem: "15  What does Lucie do differently now?",
          options: [
            "She no longer has a phone.",
            "She reads all her messages every evening.",
            "She keeps her phone out of her bedroom at night.",
            "She only uses her phone for school work.",
          ],
          explanation:
              "“I now leave it in the kitchen at night.” She has not given "
              "the phone up — she says she could not manage without it.",
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
          "OUR SCHOOL RADIO\n\n"
          "Two years ago, our school had an empty room full of old "
          "computers. Then a new music teacher, Mr Okafor, asked the head "
          "teacher if he could use it. (16) ___ Three months later, we were "
          "on the air for the first time.\n\n"
          "At the beginning, we only played music during the lunch break. "
          "Nobody really listened. (17) ___ Suddenly students were stopping "
          "us in the corridor to ask about the next programme.\n\n"
          "Running a radio station is harder than it sounds. Every show has "
          "to be planned, and somebody has to check the equipment before we "
          "start. (18) ___ We all laughed about it later, but at the time it "
          "was terrible.\n\n"
          "I present the Friday show with my friend Bea. I was very shy when "
          "I started. (19) ___ Now I actually look forward to it.\n\n"
          "Next year we want to broadcast online, so that parents can listen "
          "at home. (20) ___ If we manage that, we will be the first school "
          "in the city with its own internet radio.\n\n"
          "THE MISSING SENTENCES\n\n"
          "A  My voice used to shake every time the red light came on.\n"
          "B  The head teacher has never visited the studio.\n"
          "C  To do that, we need to raise money for new equipment.\n"
          "D  He wanted to turn it into a radio studio.\n"
          "E  Most students prefer listening to music on their phones.\n"
          "F  Things changed when we began interviewing teachers about their "
          "lives.\n"
          "G  Once, we forgot, and a whole programme went out with no "
          "sound.\n"
          "H  Bea has been my best friend since primary school.",
      items: [
        ExamItem(
          number: 16,
          stem: "16",
          explanation:
              "“He” is Mr Okafor and “it” is the empty room. A radio studio "
              "is what explains being “on the air” three months later.",
        ),
        ExamItem(
          number: 17,
          stem: "17",
          explanation:
              "“Suddenly” needs a change before it. The interviews are the "
              "change; E explains the problem but not why it ended.",
        ),
        ExamItem(
          number: 18,
          stem: "18",
          explanation:
              "“We forgot” refers to checking the equipment, and a programme "
              "with no sound is the “it” they laughed about later.",
        ),
        ExamItem(
          number: 19,
          stem: "19",
          explanation:
              "A shaking voice shows how shy she was. “Used to” sets up the "
              "contrast with “Now I actually look forward to it.”",
        ),
        ExamItem(
          number: 20,
          stem: "20",
          explanation:
              "“To do that” means broadcasting online, and “if we manage "
              "that” in the next sentence means raising the money.",
        ),
      ],
      answers: {16: "D", 17: "F", 18: "G", 19: "A", 20: "C"},
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
          "A CITY ON TWO WHEELS\n\n"
          "In some cities, the bicycle is the most popular way to get "
          "(21) ___. In Copenhagen, for example, almost half of the people "
          "who work or study there travel by bike every day. The city has "
          "(22) ___ a lot of money on special roads for bikes, so cycling is "
          "both fast and safe.\n\n"
          "Cyclists there do not stop when the weather is bad. (23) ___ the "
          "rain and snow, they simply put on a waterproof jacket and carry "
          "on. Many parents use special bikes with a large box at the front, "
          "which has enough (24) ___ for two children.\n\n"
          "Visitors are often surprised by how quiet the streets are. There "
          "is much (25) ___ traffic noise than in other capitals, and the "
          "air is cleaner too. It is not surprising that other cities are "
          "now trying to (26) ___ the same.",
      items: [
        ExamItem(
          number: 21,
          stem: "21",
          options: ["along", "around", "across", "away"],
          explanation:
              "Get around means travel from place to place. Get along is "
              "about being friendly, and get away means escape.",
        ),
        ExamItem(
          number: 22,
          stem: "22",
          options: ["paid", "cost", "spent", "bought"],
          explanation:
              "You spend money on something. Pay takes for — pay for the "
              "roads — and cost needs the thing as its subject.",
        ),
        ExamItem(
          number: 23,
          stem: "23",
          options: ["Despite", "Although", "However", "Even"],
          explanation:
              "Despite is followed by a noun: despite the rain. Although "
              "needs a subject and a verb: although it rains.",
        ),
        ExamItem(
          number: 24,
          stem: "24",
          options: ["place", "area", "size", "room"],
          explanation:
              "Enough room means enough space, and room is uncountable here. "
              "“Enough place” is a common mistake: place is one position.",
        ),
        ExamItem(
          number: 25,
          stem: "25",
          options: ["fewer", "less", "little", "few"],
          explanation:
              "Noise is uncountable, so less; fewer is for things you can "
              "count — fewer cars. “Than” needs the comparative form.",
        ),
        ExamItem(
          number: 26,
          stem: "26",
          options: ["make", "have", "do", "take"],
          explanation:
              "Do the same is fixed: do is the verb that stands for another "
              "action. You never make the same.",
        ),
      ],
      answers: {21: "B", 22: "C", 23: "A", 24: "D", 25: "B", 26: "C"},
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
          "MY NEW HOBBY\n\n"
          "Six months ago I started climbing (27) ___ a sports centre near "
          "my home. I had never tried it before, so I was a little nervous "
          "on the first day. The teacher showed us (28) ___ to use the ropes "
          "safely, and then we began on the easiest wall.\n\n"
          "At first my arms were (29) ___ tired that I could only climb for "
          "ten minutes. Now I go twice (30) ___ week, and I can stay on the "
          "wall for an hour. I have also made some good friends there. One "
          "(31) ___ them, Jonas, has been climbing for years and gives me "
          "lots of advice.\n\n"
          "Next summer we are planning to climb outdoors for the first time. "
          "I am really looking forward (32) ___ it!",
      items: [
        ExamItem(
          number: 27,
          stem: "27",
          explanation:
              "At a sports centre, at a swimming pool: at for the place where "
              "an activity happens. In is also possible for the building.",
        ),
        ExamItem(
          number: 28,
          stem: "28",
          explanation:
              "Show someone how to do something. After how, what or where, "
              "English uses to + infinitive.",
        ),
        ExamItem(
          number: 29,
          stem: "29",
          explanation:
              "So + adjective + that gives a result: so tired that I could "
              "only climb for ten minutes.",
        ),
        ExamItem(
          number: 30,
          stem: "30",
          explanation:
              "Twice a week, three times a year: a means “in each”. Per, "
              "each and every are possible too.",
        ),
        ExamItem(
          number: 31,
          stem: "31",
          explanation:
              "One of them, some of us, most of my friends: of joins a "
              "number or quantity to the group it comes from.",
        ),
        ExamItem(
          number: 32,
          stem: "32",
          explanation:
              "Look forward to is followed by a noun or -ing: looking "
              "forward to it, looking forward to climbing.",
        ),
      ],
      answers: {
        27: "at/in",
        28: "how",
        29: "so",
        30: "a/per/each/every",
        31: "of",
        32: "to",
      },
    ),
  ],
);
