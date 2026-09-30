/// Original B2 practice written for Cíl, with explanations after marking.
library;

import 'cambridge.dart';

const extraCilPapers = <ExamPaper>[
  ExamPaper(
    id: 'cil-3-use-of-english',
    name: 'Cíl Paper 3 · Use of English',
    source: PaperSource.cil,
    level: ExamLevel.b2,
    minutes: 40,
    note: "Repair cafés, learning outdoors and shared workspaces. Original B2 practice with a comment for every answer.",
    parts: [
      ExamPart(
        number: 1,
        name: "Multiple-choice cloze",
        from: 1,
        to: 8,
        type: AnswerType.choice,
        marksPerQuestion: 1,
        howToAnswer: "One letter. Choose the option that best fits the text.",
        passage:
            "A SECOND LIFE FOR SMALL THINGS\n\nWhen the toaster in her student flat stopped working, "
            "Marta was on the (1) ___ of throwing it away. Instead, she took it to a repair café. The"
            " volunteers could not (2) ___ that they would fix it, but they promised to try. Within "
            "twenty minutes it was heating bread again.\n\nThe experience (3) ___ her to organise a "
            "similar event in her neighbourhood. She placed an advertisement asking people to (4) ___"
            " their skills, and a retired electrician was the first to reply. Since then, the group "
            "has (5) ___ a reputation for tackling everything from lamps to torn coats. Visitors are "
            "expected to stay and help rather than simply leave an object behind.\n\nNot every repair "
            "is successful, but the meetings (6) ___ people a chance to understand how familiar "
            "objects work. Marta says the biggest surprise has been the friendships. People who once "
            "ignored each other now stop to (7) ___ up on neighbourhood news. The café has brought "
            "them (8) ___, one broken kettle at a time.",
        items: [
          ExamItem(
            number: 1,
            stem: "1",
            options: ["point", "edge", "limit", "moment"],
            explanation:
                "“On the point of” means just about to do something. The following -ing form completes "
                "the expression.",
          ),
          ExamItem(
            number: 2,
            stem: "2",
            options: ["insist", "guarantee", "convince", "assure"],
            explanation:
                "“Guarantee that” means promise that a result is certain. The volunteers can promise to "
                "try without promising success.",
          ),
          ExamItem(
            number: 3,
            stem: "3",
            options: ["impressed", "interested", "appealed", "inspired"],
            explanation: "“Inspire someone to do something” means give them the idea or motivation to act.",
          ),
          ExamItem(
            number: 4,
            stem: "4",
            options: ["separate", "split", "share", "divide"],
            explanation: "People “share their skills” when they make their knowledge available to others.",
          ),
          ExamItem(
            number: 5,
            stem: "5",
            options: ["earned", "owed", "spent", "paid"],
            explanation:
                "The fixed combination is “earn a reputation”: become known for a particular quality "
                "through your actions.",
          ),
          ExamItem(
            number: 6,
            stem: "6",
            options: ["do", "give", "take", "make"],
            explanation:
                "“Give someone a chance” means provide an opportunity. The indirect object “people” comes"
                " before “a chance”.",
          ),
          ExamItem(
            number: 7,
            stem: "7",
            options: ["catch", "take", "bring", "make"],
            explanation: "“Catch up on news” means learn what has happened since you last spoke.",
          ),
          ExamItem(
            number: 8,
            stem: "8",
            options: ["jointly", "combined", "together", "alongside"],
            explanation: "“Bring people together” means unite them or help them form relationships.",
          ),
        ],
        answers: {
          1: "A",
          2: "B",
          3: "D",
          4: "C",
          5: "A",
          6: "B",
          7: "A",
          8: "C",
        },
      ),
      ExamPart(
        number: 2,
        name: "Open cloze",
        from: 9,
        to: 16,
        type: AnswerType.word,
        marksPerQuestion: 1,
        howToAnswer: "Exactly one word in each gap.",
        passage:
            "A CLASSROOM WITHOUT WALLS\n\nOur geography teacher wanted us to pay more attention (9) ___"
            " the neighbourhood around the school. Rather (10) ___ asking us to read another chapter,"
            " she sent us outside in pairs. Each pair had to choose a street and find out how it had "
            "changed.\n\nAt first I had no idea (11) ___ to begin. Then an elderly shopkeeper offered "
            "to show us some photographs. His shop had been a bakery long before it became a "
            "bookshop. We were surprised (12) ___ how different the street looked.\n\nThe project was "
            "not only about old buildings (13) ___ also about the people who used them. We learnt "
            "that a bus route had disappeared because too few people had been using (14) ___. Our "
            "teacher encouraged us to check every story against another source. By the end, I felt "
            "that I knew my own town better (15) ___ ever. Best of (16) ___, I had stopped thinking "
            "that interesting places were always somewhere else.",
        items: [
          ExamItem(
            number: 9,
            stem: "9",
            explanation: "“Pay attention to” is the complete expression; “to” introduces what you notice.",
          ),
          ExamItem(
            number: 10,
            stem: "10",
            explanation:
                "“Rather than” introduces an alternative: going outside instead of reading another "
                "chapter.",
          ),
          ExamItem(
            number: 11,
            stem: "11",
            explanation:
                "“Where to begin” and “how to begin” both fit: the speaker did not know the starting "
                "point or approach.",
          ),
          ExamItem(
            number: 12,
            stem: "12",
            explanation: "Both “surprised by” and “surprised at” can introduce the thing causing surprise.",
          ),
          ExamItem(
            number: 13,
            stem: "13",
            explanation: "The paired structure is “not only ... but also ...”. Both buildings and people mattered.",
          ),
          ExamItem(
            number: 14,
            stem: "14",
            explanation:
                "The singular pronoun “it” refers back to the bus route.",
          ),
          ExamItem(
            number: 15,
            stem: "15",
            explanation: "The comparison is “better than ever”, meaning better than at any previous time.",
          ),
          ExamItem(
            number: 16,
            stem: "16",
            explanation: "“Best of all” introduces the most positive result in a series.",
          ),
        ],
        answers: {
          9: "to",
          10: "than",
          11: "where/how",
          12: "by/at",
          13: "but",
          14: "it",
          15: "than",
          16: "all",
        },
      ),
      ExamPart(
        number: 3,
        name: "Word formation",
        from: 17,
        to: 24,
        type: AnswerType.word,
        marksPerQuestion: 1,
        howToAnswer: "Exactly one word in each gap.",
        passage:
            "WORKING NEAR HOME\n\nThe old post office in our village has become a shared workspace. Its"
            " (17) ___ (TRANSFORM) took six months, but the result is worth the wait. Large windows "
            "provide plenty of (18) ___ (NATURE) light, and a quiet room offers complete (19) ___ "
            "(PRIVATE) for phone calls.\n\nThe organisers wanted the building to be (20) ___ (ACCESS) "
            "to everyone, so they installed a ramp at the entrance. They also invited local people to"
            " suggest (21) ___ (IMPROVE) before the furniture was ordered. Not all the suggestions "
            "were practical, but several were adopted.\n\nMembership is deliberately (22) ___ "
            "(EXPENSE): a day costs less than a return train ticket to the city. Members say that the"
            " main benefit is not financial, however. Working alongside other people reduces the (23)"
            " ___ (LONELY) they sometimes felt at home. The project has been so (24) ___ (SUCCESS) "
            "that a neighbouring village is planning its own version.",
        items: [
          ExamItem(
            number: 17,
            stem: "17",
            explanation:
                "The possessive “its” needs a noun here. “Transformation” is the process of changing the "
                "building.",
          ),
          ExamItem(
            number: 18,
            stem: "18",
            explanation: "An adjective is needed before “light”. The adjective from “nature” is “natural”.",
          ),
          ExamItem(
            number: 19,
            stem: "19",
            explanation:
                "“Complete” describes a noun: “privacy”, the state of being away from other people’s "
                "attention.",
          ),
          ExamItem(
            number: 20,
            stem: "20",
            explanation: "After “be”, use the adjective “accessible”, followed by “to everyone”.",
          ),
          ExamItem(
            number: 21,
            stem: "21",
            explanation:
                "Several changes were suggested, and “suggestions” in the next sentence confirms the "
                "plural noun “improvements”.",
          ),
          ExamItem(
            number: 22,
            stem: "22",
            explanation: "The low price supplies the negative meaning: “inexpensive”, not expensive.",
          ),
          ExamItem(
            number: 23,
            stem: "23",
            explanation: "The article “the” introduces the noun “loneliness”, the feeling of being alone.",
          ),
          ExamItem(
            number: 24,
            stem: "24",
            explanation: "After “so” and before “that”, an adjective describes the project: “successful”.",
          ),
        ],
        answers: {
          17: "transformation",
          18: "natural",
          19: "privacy",
          20: "accessible",
          21: "improvements",
          22: "inexpensive",
          23: "loneliness",
          24: "successful",
        },
      ),
      ExamPart(
        number: 4,
        name: "Key word transformation",
        from: 25,
        to: 30,
        type: AnswerType.transformation,
        marksPerQuestion: 2,
        howToAnswer: "Two to five words, including the given word unchanged. Each half earns one mark.",
        items: [
          ExamItem(
            number: 25,
            stem: "I regret not learning to swim when I was younger.\nWISH\nI ___ to swim when I was younger.",
            explanation:
                "“Wish” with the past perfect expresses regret about the past. “Had learnt” and “had "
                "learned” are both accepted.",
          ),
          ExamItem(
            number: 26,
            stem: "They postponed the match because of the rain.\nOFF\nThey ___ the match because of the rain.",
            explanation:
                "“Put off” means postpone. The past form is also “put”.",
          ),
          ExamItem(
            number: 27,
            stem: "The last time I saw her was three months ago.\nFOR\nI ___ three months.",
            explanation: "Use the present perfect with “for” to describe the period since the last meeting.",
          ),
          ExamItem(
            number: 28,
            stem: "Solving the puzzle was easy.\nDIFFICULT\nThe puzzle ___ to solve at all.",
            explanation: "“Not difficult” preserves the meaning of “easy”. “At all” is already outside the gap.",
          ),
          ExamItem(
            number: 29,
            stem: "People say that the bridge is unsafe.\nSAID\nThe bridge ___ unsafe.",
            explanation: "The reporting passive “is said to be” reports what people say about the bridge.",
          ),
          ExamItem(
            number: 30,
            stem: "I would prefer to stay at home rather than go out.\nRATHER\nI ___ at home than go out.",
            explanation: "“Would rather” is followed by a bare infinitive. Here “stay” contrasts with “go out”.",
          ),
        ],
        answers: {
          25: "wish I | had learnt/learned",
          26: "put | off",
          27: "have not seen | her for",
          28: "was not | difficult",
          29: "is said | to be",
          30: "would rather | stay",
        },
      ),
    ],
  ),
  ExamPaper(
    id: 'cil-4-reading',
    name: 'Cíl Paper 4 · Reading',
    source: PaperSource.cil,
    level: ExamLevel.b2,
    minutes: 35,
    note: "A sound archivist, a tool library and learning new skills. Original B2 practice with a comment for every answer.",
    parts: [
      ExamPart(
        number: 5,
        name: "Multiple choice",
        from: 31,
        to: 36,
        type: AnswerType.choice,
        marksPerQuestion: 2,
        howToAnswer: "One letter. Choose the option that best fits the text.",
        passage:
            "THE WOMAN WHO COLLECTS ORDINARY SOUNDS\n\nWhen Elena Ruiz first recorded the market "
            "outside her flat, she was not trying to preserve history. She was testing a microphone "
            "borrowed from a colleague and needed a noisy place. Listening back that evening, she "
            "recognised the fish seller’s call but noticed something she had never consciously heard:"
            " between customers, he tapped a little rhythm on the wooden counter. A familiar place "
            "had become unfamiliar enough to deserve her attention.\n\nElena had been editing "
            "advertisements for a radio station. She enjoyed the technical work but disliked removing"
            " every hesitation from the voices she recorded. “People rarely sound as smooth as an "
            "advertisement,” she says. Her growing collection of street recordings offered the "
            "opposite experience. A conversation interrupted by a bus could be more interesting than "
            "one recorded in silence, because the interruption located the speakers in a real place."
            "\n\nFive years later, Elena runs a small sound archive with recordings from across the "
            "city. The files include bus journeys, workshops and school playgrounds, all recorded "
            "with the necessary permission. She receives frequent requests to record famous "
            "buildings, but she is more interested in places whose importance has not yet been "
            "recognised. An ordinary shoe repair shop, she argues, can reveal more about everyday "
            "life than an empty concert hall.\n\nHer approach creates an awkward problem: she cannot "
            "know which sounds will matter to future listeners. When a local newspaper asked her to "
            "name the most valuable recording, she chose the background noise of a café that had "
            "recently closed. The journalist was disappointed; he had expected something dramatic. "
            "Elena’s explanation was that dramatic events usually attract plenty of microphones "
            "already. A place where nothing remarkable happened may vanish without leaving any record"
            " at all.\n\nThe archive is available online, but she has resisted adding music to make the"
            " recordings more attractive. Nor does she reduce them to a few exciting seconds. A long "
            "pause can seem pointless until another sound changes its meaning. She does provide notes"
            " explaining where and when each recording was made. Without that information, she says, "
            "listeners may enjoy a sound while misunderstanding what they are hearing.\n\nElena now "
            "gives workshops in which participants spend ten minutes listening before they touch any "
            "equipment. Many find this surprisingly uncomfortable. They arrive expecting to learn "
            "which microphone to buy and instead discover how quickly their attention wanders. "
            "Technical skill matters, she tells them, but purchasing a better device will not teach "
            "them to notice a quiet rhythm beneath the noise of a market.",
        items: [
          ExamItem(
            number: 31,
            stem: "31  What interested Elena when she listened to her first market recording?",
            options: [
              "It proved that her colleague’s microphone was unsuitable.",
              "It persuaded a fish seller to support her project.",
              "It revealed something she had overlooked in a familiar place.",
              "It reminded her of a market she had known as a child.",
            ],
            explanation:
                "The counter rhythm was new to Elena even though the market was familiar. Her surprise "
                "concerns attention, not the quality of the microphone.",
          ),
          ExamItem(
            number: 32,
            stem: "32  Why does Elena value interruptions in a recording?",
            options: [
              "They allow her to avoid asking people for permission.",
              "They make the words easier for listeners to understand.",
              "They show the circumstances in which speech happens.",
              "They reduce the amount of equipment she needs.",
            ],
            explanation:
                "The bus interruption places speakers in a real setting. Elena contrasts this with "
                "artificially smooth advertising voices.",
          ),
          ExamItem(
            number: 33,
            stem: "33  Which places does Elena particularly want to record?",
            options: [
              "Places whose everyday importance may be overlooked.",
              "Places that are too quiet to attract other visitors.",
              "Businesses that can help pay for the archive.",
              "Buildings already famous for their excellent acoustics.",
            ],
            explanation:
                "She favours the ordinary repair shop over famous buildings because it records daily life"
                " that has not yet been recognised as important.",
          ),
          ExamItem(
            number: 34,
            stem: "34  Why did Elena choose the café recording as especially valuable?",
            options: [
              "It included a dramatic event missed by journalists.",
              "It captured a conversation with a famous customer.",
              "It preserved a place that might otherwise leave no trace.",
              "It was technically better than her other recordings.",
            ],
            explanation:
                "Dramatic events already attract recordings. The closed café might disappear without a "
                "record, making its ordinary background noise valuable.",
          ),
          ExamItem(
            number: 35,
            stem: "35  What is the purpose of the notes accompanying the recordings?",
            options: [
              "They help listeners interpret the sounds accurately.",
              "They encourage people to donate music to the archive.",
              "They identify which pauses listeners should skip.",
              "They compensate for the poor quality of the recordings.",
            ],
            explanation:
                "The notes explain place and time. Elena warns that enjoyment without context can lead to"
                " misunderstanding.",
          ),
          ExamItem(
            number: 36,
            stem: "36  What point does the final paragraph make?",
            options: [
              "Good recording begins with careful attention.",
              "Street recordings are easier to make than advertisements.",
              "Expensive equipment is unsuitable for beginners.",
              "Listening skills develop automatically through practice.",
            ],
            explanation:
                "The workshop delays the use of equipment to teach listening. A better microphone cannot "
                "replace noticing the sound in the first place.",
          ),
        ],
        answers: {31: "C", 32: "C", 33: "A", 34: "C", 35: "A", 36: "A"},
      ),
      ExamPart(
        number: 6,
        name: "Gapped text",
        from: 37,
        to: 42,
        type: AnswerType.choice,
        marksPerQuestion: 2,
        howToAnswer: "One letter, A to G. Six gaps, seven sentences: one sentence is not used.",
        passage:
            "BORROWING A DRILL\n\nAfter buying a drill to put up two shelves, Imran realised he might "
            "not use it again for years. A neighbour had bought exactly the same model the previous "
            "week. (37) ___ Their conversation became the beginning of a neighbourhood tool library."
            "\n\nThe first collection fitted into a cupboard in a community centre. People donated "
            "equipment, and volunteers wrote each loan in a notebook. (38) ___ A simple online "
            "booking system was introduced before the cupboard grew into a room.\n\nOwning a tool and "
            "knowing how to use it are different things. One borrower returned a sewing machine "
            "because she could not even thread it. (39) ___ These short sessions soon became as "
            "popular as the loans themselves.\n\nThe organisers had expected most arguments to concern "
            "broken equipment. In fact, tools usually came back in good condition. (40) ___ A drill "
            "arriving a day late could prevent the next borrower from completing a weekend project.\n\n"
            "To solve that problem, the library began sending reminders before loans were due. It "
            "also asked people to report delays immediately instead of hoping nobody would notice. "
            "(41) ___ Members started treating the booking calendar as a shared promise, rather than "
            "a rough suggestion.\n\nThe library now has more than two hundred items, but Imran is "
            "cautious about accepting every donation. Equipment that nobody borrows still needs to be"
            " stored and checked. (42) ___ The project succeeds, he says, by making useful things "
            "available, not by owning the largest possible collection.\n\nTHE MISSING SENTENCES\n\nA  "
            "What caused trouble was equipment being returned after the agreed time.\nB  That small "
            "change made the whole system more dependable.\nC  They wondered why every household "
            "needed to own something used so rarely.\nD  Volunteers therefore began offering lessons "
            "alongside the equipment.\nE  The solution was to charge more for the most popular "
            "machines.\nF  Before long, however, two people were turning up for the same item.\nG  For "
            "that reason, the organisers now ask whether an item fills a real gap.",
        items: [
          ExamItem(
            number: 37,
            stem: "37",
            explanation:
                "“They” refers to Imran and his neighbour. Their question about rarely used possessions "
                "leads directly to the tool library.",
          ),
          ExamItem(
            number: 38,
            stem: "38",
            explanation: "The double bookings explain why the notebook was replaced by an online booking system.",
          ),
          ExamItem(
            number: 39,
            stem: "39",
            explanation:
                "The borrower’s difficulty using the machine prompts lessons. “These short sessions” in "
                "the next sentence refers to those lessons.",
          ),
          ExamItem(
            number: 40,
            stem: "40",
            explanation:
                "“In fact” rejects the expected problem of breakages. A introduces the real problem, "
                "illustrated by the late drill.",
          ),
          ExamItem(
            number: 41,
            stem: "41",
            explanation:
                "“That small change” points back to reminders and reporting delays. The next sentence "
                "explains the resulting reliability.",
          ),
          ExamItem(
            number: 42,
            stem: "42",
            explanation:
                "“For that reason” links storage and checking costs to selective acceptance. The final "
                "sentence reinforces usefulness over size.",
          ),
        ],
        answers: {37: "C", 38: "F", 39: "D", 40: "A", 41: "B", 42: "G"},
      ),
      ExamPart(
        number: 7,
        name: "Multiple matching",
        from: 43,
        to: 52,
        type: AnswerType.choice,
        marksPerQuestion: 1,
        howToAnswer:
            "One letter, A to D. You may use each section more than once.",
        passage:
            "FOUR ADULTS LEARNING SOMETHING NEW\n\nA — NORA, pottery\nI joined because a friend did not "
            "want to go alone. She stopped after two weeks, but I am still there a year later. I "
            "expected to make useful bowls straight away; instead, my first pieces were too thick and"
            " uneven to hold anything properly. The teacher made us keep them. Looking at mine now is"
            " a much better reminder of progress than any certificate. I work with computers all day,"
            " so I especially like having a result I can actually touch. I do not want to turn this "
            "into a business. The moment customers started placing orders, I suspect the pleasure "
            "would disappear.\n\nB — JAMAL, swimming\nI was tired of making excuses whenever friends "
            "suggested a beach trip. The first lesson was embarrassing, partly because the other "
            "learners were much younger. Our instructor never treated that as important, which "
            "helped. My work shifts change every week, so a regular evening class would have been "
            "impossible. Fortunately, the pool lets me book individual sessions. Progress has been "
            "slow, and I still dislike deep water, but last month I swam an entire length without "
            "stopping. I had thought I needed to become fearless. Now I realise I can be nervous and "
            "still do something difficult.\n\nC — INES, photography\nI assumed a better camera would "
            "solve my problems. After spending most of my savings, I discovered that my photographs "
            "were still dull. A local walking group changed that. We visit the same streets at "
            "different times and discuss why one image works better than another. The most useful "
            "advice came from a member who uses an old phone. She taught me to look at the edges of a"
            " picture before pressing the button. I now carry less equipment, and I rarely buy "
            "anything new. I have also become much more patient when light or weather refuses to "
            "cooperate.\n\nD — ROB, cooking\nWhen my daughter left home, she pointed out that I could "
            "not expect her to prepare meals whenever she visited. Fair enough. I enrolled in a "
            "course and immediately regretted it: everyone seemed faster and more confident. Then one"
            " evening our teacher burnt the onions while explaining a technique. Watching her calmly "
            "start again was more useful than a perfect demonstration. I now invite neighbours to eat"
            " what I make. Their reactions tell me more than my own judgement, although I ask them to"
            " be specific. “Lovely” is encouraging, but “a little less salt” helps with the next "
            "attempt.",
        items: [
          ExamItem(
            number: 43,
            stem: "43  Who started mainly to accompany someone else?",
            explanation: "Nora initially went because her friend did not want to attend alone.",
          ),
          ExamItem(
            number: 44,
            stem: "44  Who discovered that expensive equipment did not solve the problem?",
            explanation: "Ines spent most of her savings on a camera, then found her pictures were still dull.",
          ),
          ExamItem(
            number: 45,
            stem: "45  Who needs lessons that fit an unpredictable work timetable?",
            explanation:
                "Jamal’s changing shifts make a fixed weekly class impossible, so he books individual "
                "sessions.",
          ),
          ExamItem(
            number: 46,
            stem: "46  Who learnt something valuable from an instructor’s mistake?",
            explanation:
                "Rob found the teacher’s burnt onions and calm restart more useful than a flawless "
                "demonstration.",
          ),
          ExamItem(
            number: 47,
            stem: "47  Who keeps early attempts as evidence of improvement?",
            explanation: "Nora keeps her first uneven pieces because they make later progress visible.",
          ),
          ExamItem(
            number: 48,
            stem: "48  Who received helpful advice from someone using basic equipment?",
            explanation:
                "The useful advice came from a group member using an old phone, not from the expensive "
                "camera.",
          ),
          ExamItem(
            number: 49,
            stem: "49  Who changed their view about needing to feel completely confident?",
            explanation: "Jamal now understands that nervousness does not prevent him from swimming successfully.",
          ),
          ExamItem(
            number: 50,
            stem: "50  Who prefers detailed criticism to a simple compliment?",
            explanation:
                "Rob asks neighbours for specific reactions, such as using less salt, instead of general "
                "praise.",
          ),
          ExamItem(
            number: 51,
            stem: "51  Who wants to avoid making money from the new skill?",
            explanation:
                "Nora believes customer orders could remove the pleasure, so she does not want a pottery "
                "business.",
          ),
          ExamItem(
            number: 52,
            stem: "52  Who began after a family member questioned their dependence on others?",
            explanation: "Rob enrolled after his daughter challenged his reliance on her cooking.",
          ),
        ],
        answers: {
          43: "A",
          44: "C",
          45: "B",
          46: "D",
          47: "A",
          48: "C",
          49: "B",
          50: "D",
          51: "A",
          52: "D",
        },
      ),
    ],
  ),
  ExamPaper(
    id: 'cil-5-use-of-english',
    name: 'Cíl Paper 5 · Use of English',
    source: PaperSource.cil,
    level: ExamLevel.b2,
    minutes: 40,
    note: "Community science, local travel and a film club. Original B2 practice with a comment for every answer.",
    parts: [
      ExamPart(
        number: 1,
        name: "Multiple-choice cloze",
        from: 1,
        to: 8,
        type: AnswerType.choice,
        marksPerQuestion: 1,
        howToAnswer: "One letter. Choose the option that best fits the text.",
        passage:
            "THE WEATHER ON YOUR STREET\n\nEvery morning before breakfast, Leo writes down the "
            "temperature outside his kitchen window. He is one of several hundred volunteers who (1) "
            "___ part in a local weather project. The readings help scientists (2) ___ track of small"
            " differences between city neighbourhoods.\n\nLeo was initially (3) ___ to join because he "
            "had no scientific training. A short workshop soon changed his mind. The equipment was "
            "easy to use, and the organisers (4) ___ him with clear instructions. What mattered most "
            "was taking the reading at the same time each day, even when the weather seemed ordinary."
            "\n\nAfter a year, Leo began to (5) ___ patterns in the figures. His street stayed warmer "
            "after sunset than a nearby park. That observation (6) ___ his interest in the effect of "
            "buildings on temperature. He now reads reports that he would once have ignored. The "
            "project has also given him a (7) ___ of belonging to something larger. He says he no "
            "longer takes the weather for (8) ___. Even a dull morning can contain a small discovery.",
        items: [
          ExamItem(
            number: 1,
            stem: "1",
            options: ["take", "make", "play", "do"],
            explanation: "“Take part in” means participate in an activity.",
          ),
          ExamItem(
            number: 2,
            stem: "2",
            options: ["maintain", "hold", "keep", "stay"],
            explanation:
                "“Keep track of” means follow or record changes over time.",
          ),
          ExamItem(
            number: 3,
            stem: "3",
            options: ["eager", "delighted", "reluctant", "relieved"],
            explanation:
                "“Reluctant to join” means unwilling or hesitant. His lack of training explains the "
                "hesitation.",
          ),
          ExamItem(
            number: 4,
            stem: "4",
            options: ["provided", "explained", "told", "informed"],
            explanation: "“Provide someone with instructions” means give them information explaining what to do.",
          ),
          ExamItem(
            number: 5,
            stem: "5",
            options: ["notice", "remind", "remark", "notify"],
            explanation: "“Notice patterns” means become aware of repeated relationships in the figures.",
          ),
          ExamItem(
            number: 6,
            stem: "6",
            options: ["aroused", "afforded", "announced", "awarded"],
            explanation: "“Arouse someone’s interest” means make them become interested in something.",
          ),
          ExamItem(
            number: 7,
            stem: "7",
            options: ["sensation", "sense", "opinion", "view"],
            explanation: "“A sense of belonging” describes feeling part of a group or activity.",
          ),
          ExamItem(
            number: 8,
            stem: "8",
            options: ["allowed", "granted", "given", "permitted"],
            explanation:
                "“Take something for granted” means fail to appreciate it or assume it will always be "
                "there.",
          ),
        ],
        answers: {
          1: "A",
          2: "C",
          3: "C",
          4: "A",
          5: "A",
          6: "A",
          7: "B",
          8: "B",
        },
      ),
      ExamPart(
        number: 2,
        name: "Open cloze",
        from: 9,
        to: 16,
        type: AnswerType.word,
        marksPerQuestion: 1,
        howToAnswer: "Exactly one word in each gap.",
        passage:
            "TRAVELLING WITHOUT A PLAN\n\nOn holiday I used to organise every hour of the day. I was "
            "afraid (9) ___ missing something important, so I followed detailed lists of places to "
            "visit. The problem was that I spent more time looking at my phone (10) ___ looking "
            "around me.\n\nLast summer I decided to try a different approach. I booked a room but did "
            "(11) ___ make any other arrangements. On the first morning, I asked the owner what she "
            "would do if she (12) ___ a free afternoon. She recommended a walk along the river, where"
            " there was hardly (13) ___ traffic.\n\nI set out without knowing exactly how long the walk"
            " would take. At one point I stopped at a café whose owner had lived there (14) ___ "
            "childhood. We talked for an hour. I would never have found the place (15) ___ I had "
            "followed my usual schedule. Since then, I have made a point (16) ___ leaving some empty "
            "space in every trip.",
        items: [
          ExamItem(
            number: 9,
            stem: "9",
            explanation:
                "The phrase is “afraid of” followed by a noun or -ing form.",
          ),
          ExamItem(
            number: 10,
            stem: "10",
            explanation:
                "“More time ... than ...” compares two activities: checking the phone and noticing the "
                "surroundings.",
          ),
          ExamItem(
            number: 11,
            stem: "11",
            explanation:
                "“Did not make any other arrangements” is negative past simple. The room was the only "
                "thing organised in advance.",
          ),
          ExamItem(
            number: 12,
            stem: "12",
            explanation: "In this hypothetical question, “if she had” pairs with “would do”.",
          ),
          ExamItem(
            number: 13,
            stem: "13",
            explanation: "“Hardly any traffic” means almost no traffic. “Traffic” is uncountable.",
          ),
          ExamItem(
            number: 14,
            stem: "14",
            explanation:
                "“Since childhood” gives the starting point of a situation continuing to the time "
                "described.",
          ),
          ExamItem(
            number: 15,
            stem: "15",
            explanation:
                "The third conditional connects an unreal past condition with its imagined result: “if I "
                "had followed ...”.",
          ),
          ExamItem(
            number: 16,
            stem: "16",
            explanation: "“Make a point of doing something” means make a deliberate effort to do it.",
          ),
        ],
        answers: {
          9: "of",
          10: "than",
          11: "not",
          12: "had",
          13: "any",
          14: "since",
          15: "if",
          16: "of",
        },
      ),
      ExamPart(
        number: 3,
        name: "Word formation",
        from: 17,
        to: 24,
        type: AnswerType.word,
        marksPerQuestion: 1,
        howToAnswer: "Exactly one word in each gap.",
        passage:
            "A FILM CLUB FOR EVERYONE\n\nOur town’s new film club began with a simple (17) ___ "
            "(SUGGEST): show films that the commercial cinema rarely chooses. The first screening "
            "attracted an (18) ___ (EXPECT) large audience, and extra chairs had to be found.\n\nThe "
            "organisers have kept membership (19) ___ (AFFORD) by using a school hall instead of a "
            "cinema. Choosing the films is a (20) ___ (COOPERATE) process: members propose titles, "
            "then vote. This sometimes produces lively (21) ___ (AGREE), but nobody expects everyone "
            "to enjoy the same thing.\n\nAfter each screening, there is an informal (22) ___ (DISCUSS)."
            " People are encouraged to explain their reactions rather than simply call a film good or"
            " bad. Several members say these conversations have made them more (23) ___ (ADVENTURE) "
            "in their viewing choices. The club’s growing (24) ___ (POPULAR) suggests that a small "
            "audience for unusual films can become a much bigger one when people have somewhere to "
            "meet.",
        items: [
          ExamItem(
            number: 17,
            stem: "17",
            explanation: "“A simple” needs a singular noun. “Suggestion” is an idea offered for consideration.",
          ),
          ExamItem(
            number: 18,
            stem: "18",
            explanation:
                "The adverb “unexpectedly” modifies “large”. Finding extra chairs supports the idea that "
                "the size was surprising.",
          ),
          ExamItem(
            number: 19,
            stem: "19",
            explanation: "An adjective describes membership costs: “affordable” means reasonably priced.",
          ),
          ExamItem(
            number: 20,
            stem: "20",
            explanation:
                "An adjective is needed before “process”. Members work together, so the process is "
                "“cooperative”.",
          ),
          ExamItem(
            number: 21,
            stem: "21",
            explanation:
                "Different preferences can produce “disagreement” as a general situation or individual "
                "“disagreements”. The negative prefix is necessary.",
          ),
          ExamItem(
            number: 22,
            stem: "22",
            explanation: "After “an informal”, use the noun “discussion”.",
          ),
          ExamItem(
            number: 23,
            stem: "23",
            explanation: "“More adventurous” means more willing to try unfamiliar films. It describes the members.",
          ),
          ExamItem(
            number: 24,
            stem: "24",
            explanation:
                "The club’s “popularity” is the extent to which people like and attend it. A noun is "
                "needed as the subject of “suggests”.",
          ),
        ],
        answers: {
          17: "suggestion",
          18: "unexpectedly",
          19: "affordable",
          20: "cooperative",
          21: "disagreement/disagreements",
          22: "discussion",
          23: "adventurous",
          24: "popularity",
        },
      ),
      ExamPart(
        number: 4,
        name: "Key word transformation",
        from: 25,
        to: 30,
        type: AnswerType.transformation,
        marksPerQuestion: 2,
        howToAnswer: "Two to five words, including the given word unchanged. Each half earns one mark.",
        items: [
          ExamItem(
            number: 25,
            stem: "You can only enter the hall if you have a ticket.\nUNLESS\nYou cannot enter the hall ___ a ticket.",
            explanation: "“Unless” means “if not”: without a ticket, entry is impossible.",
          ),
          ExamItem(
            number: 26,
            stem: "My aunt takes care of our cat when we travel.\nAFTER\nMy aunt ___ our cat when we travel.",
            explanation: "“Look after” means take care of. The singular subject requires “looks”.",
          ),
          ExamItem(
            number: 27,
            stem: "The suitcase was so heavy that I could not lift it.\nTOO\nThe suitcase ___ me to lift.",
            explanation: "“Too heavy for me to lift” explains why lifting it was impossible.",
          ),
          ExamItem(
            number: 28,
            stem: "The train left before we arrived at the station.\nALREADY\nWhen we arrived at the station, the train ___.",
            explanation: "Use the past perfect for the earlier event: the train left before our arrival.",
          ),
          ExamItem(
            number: 29,
            stem: "“You broke my glasses,” she said to me.\nACCUSED\nShe ___ her glasses.",
            explanation:
                "“Accuse someone of” is followed by a noun or an -ing form.",
          ),
          ExamItem(
            number: 30,
            stem: "I spend thirty minutes walking to work.\nTAKES\nIt ___ to walk to work.",
            explanation: "“It takes someone + time + to do something” expresses how long an activity lasts.",
          ),
        ],
        answers: {
          25: "unless | you have",
          26: "looks | after",
          27: "was too | heavy for",
          28: "had already | left",
          29: "accused me | of breaking",
          30: "takes me | half an hour",
        },
      ),
    ],
  ),
  ExamPaper(
    id: 'cil-6-reading',
    name: 'Cíl Paper 6 · Reading',
    source: PaperSource.cil,
    level: ExamLevel.b2,
    minutes: 35,
    note: "A museum without grand objects, a walking bus and volunteer projects. Original B2 practice with a comment for every answer.",
    parts: [
      ExamPart(
        number: 5,
        name: "Multiple choice",
        from: 31,
        to: 36,
        type: AnswerType.choice,
        marksPerQuestion: 2,
        howToAnswer: "One letter. Choose the option that best fits the text.",
        passage:
            "A MUSEUM OF THINGS PEOPLE ALMOST THREW AWAY\n\nThe first object in Daniel Okoro’s museum "
            "was a plastic lunch box. It had belonged to his mother during her thirty years as a "
            "hospital cleaner. When she retired, she was ready to throw it away. Daniel asked to keep"
            " it, less because of the box itself than because of the stories she told while emptying "
            "it. The same small object had travelled on early buses, sat beneath countless staff-room"
            " chairs and survived a change of hospital. None of that was visible in a photograph of a"
            " clean corridor.\n\nDaniel was studying graphic design and originally planned to display "
            "the box as part of a college project. His tutor questioned whether visitors would "
            "understand it without hearing his mother speak. Daniel took the criticism seriously. He "
            "recorded her account and placed headphones beside the object. People who had walked past"
            " the display began stopping for several minutes. He realised that the object could draw "
            "someone’s attention, but the voice gave them a reason to remain.\n\nThe project expanded "
            "into a small museum in a former shop. Its collection includes a worn football, a "
            "delivery driver’s notebook and a kitchen timer. Daniel refuses objects accompanied only "
            "by a price estimate. He is not opposed to valuable things, but market value tells him "
            "little about why something mattered to its owner. He also rejects the idea that every "
            "story must be uplifting. One notebook records the frustration of working unpredictable "
            "hours, not a cheerful tale of determination rewarded.\n\nVisitors sometimes ask why the "
            "labels are so short. Daniel explains that a label which tells people what to feel leaves"
            " little room for their own response. He supplies basic facts and lets the recorded "
            "account complicate them. There are contradictions: two brothers remember the same "
            "football match differently. Rather than decide which one is right, he presents both "
            "memories and explains that they disagree. The museum is about personal experience, "
            "though dates and public events are checked separately.\n\nFunding is a constant "
            "difficulty. A sponsor recently offered enough money to solve the museum’s immediate "
            "problems, provided that its most critical accounts were removed. Daniel declined. It was"
            " a painful decision, and he does not describe it as heroic. Volunteers now open the "
            "museum only three afternoons a week. “Being independent is less impressive when you are "
            "the person cleaning the windows,” he jokes.\n\nHe would like a larger space, but not a "
            "collection that visitors rush through to tick off the highlights. His ideal visitor "
            "spends half an hour with three objects and leaves looking differently at something in "
            "their own kitchen. If the museum changes what people consider worth noticing, he says, "
            "the modest size of the collection will not have prevented it from succeeding.",
        items: [
          ExamItem(
            number: 31,
            stem: "31  What first made the lunch box important to Daniel?",
            options: [
              "Its usefulness for storing his design equipment.",
              "The experiences associated with it.",
              "The unusual material from which it was made.",
              "Its connection with a famous hospital employee.",
            ],
            explanation:
                "Daniel wanted the stories told while the box was emptied. Its interest came from his "
                "mother’s working life, not appearance or value.",
          ),
          ExamItem(
            number: 32,
            stem:
                "32  What did Daniel learn from changing his college display?",
            options: [
              "Visitors preferred listening to learning factual information.",
              "The display needed more objects to attract attention.",
              "Personal testimony helped visitors engage with an ordinary object.",
              "The object became more valuable after it was exhibited.",
            ],
            explanation:
                "Visitors stayed after he added his mother’s recorded voice. The tutor’s concern was how "
                "people would understand the object.",
          ),
          ExamItem(
            number: 33,
            stem:
                "33  What mainly determines whether Daniel accepts an object?",
            options: [
              "Its ability to communicate an optimistic message.",
              "The ease with which it can be restored.",
              "The amount of money it could raise for the museum.",
              "Its importance to the person who used it.",
            ],
            explanation:
                "A price estimate alone is insufficient. Daniel wants to understand an object’s "
                "significance in its owner’s life.",
          ),
          ExamItem(
            number: 34,
            stem: "34  Why does Daniel keep the labels brief?",
            options: [
              "To conceal disagreements between the contributors.",
              "To encourage visitors to buy a detailed guidebook.",
              "To allow visitors to interpret the accounts for themselves.",
              "To avoid admitting that dates are sometimes incorrect.",
            ],
            explanation:
                "He avoids labels that prescribe an emotional response. Recordings add complexity to the "
                "basic facts.",
          ),
          ExamItem(
            number: 35,
            stem: "35  Why did Daniel refuse the sponsorship?",
            options: [
              "It would have limited the range of experiences the museum presented.",
              "It was not enough to cover the cost of a larger building.",
              "It would have required the museum to open every day.",
              "It would have prevented him from employing volunteers.",
            ],
            explanation:
                "The sponsor wanted critical accounts removed. Accepting would have restricted the "
                "museum’s independence and its stories.",
          ),
          ExamItem(
            number: 36,
            stem: "36  How does Daniel mainly judge the museum’s success?",
            options: [
              "By the proportion of visitors who make a donation.",
              "By how quickly it can move into a larger building.",
              "By whether visitors reconsider the significance of everyday possessions.",
              "By the number of objects visitors can identify afterwards.",
            ],
            explanation:
                "His ideal visitor leaves seeing an ordinary kitchen object differently. Collection size "
                "and the number of highlights are secondary.",
          ),
        ],
        answers: {31: "B", 32: "C", 33: "D", 34: "C", 35: "A", 36: "C"},
      ),
      ExamPart(
        number: 6,
        name: "Gapped text",
        from: 37,
        to: 42,
        type: AnswerType.choice,
        marksPerQuestion: 2,
        howToAnswer: "One letter, A to G. Six gaps, seven sentences: one sentence is not used.",
        passage:
            "THE BUS THAT HAS NO ENGINE\n\nEvery school morning, a group of children follows the same "
            "route through our neighbourhood, collecting more passengers at agreed stops. There is no"
            " vehicle: the children walk with adult volunteers. (37) ___ The name makes an ordinary "
            "walk sound like an organised service, which is precisely what it is.\n\nBefore the scheme "
            "began, parents were asked what stopped them walking to school. Distance was less of a "
            "problem than the need to leave for work. (38) ___ Once parents knew someone reliable "
            "would accompany their children, many were willing to try.\n\nThe first route looked "
            "straightforward on a map. On foot, however, the organisers found a narrow pavement "
            "beside a busy junction. (39) ___ Safety mattered more than saving two minutes.\n\nKeeping "
            "the route running required more than an enthusiastic launch. Volunteers became ill, "
            "changed jobs or had appointments. (40) ___ The reserve adults could take over at short "
            "notice, allowing the timetable to remain dependable.\n\nChildren soon began pointing out "
            "seasonal changes in the streets. They noticed a tree losing its leaves and a shop window"
            " being repainted. (41) ___ Teachers reported that some children were also arriving more "
            "ready to talk to one another.\n\nThe organisers are now considering a second route. They "
            "will not advertise it until they have enough volunteers and have walked every section "
            "themselves. (42) ___ A service that starts small and continues is more useful than an "
            "ambitious plan that disappears after a week.\n\nTHE MISSING SENTENCES\n\nA  For the "
            "children, the journey was becoming an experience rather than just a distance to cover.\nB"
            "  The school also had a small car park beside its main entrance.\nC  The "
            "solution was to recruit a small backup team.\nD  The parents simply could not be in two "
            "places at once.\nE  Locally, it is known as the walking bus.\nF  They have learnt that "
            "reliability has to come before expansion.\nG  They changed the route to use a quieter "
            "crossing further along.",
        items: [
          ExamItem(
            number: 37,
            stem: "37",
            explanation:
                "E introduces the name “walking bus”; “The name” in the next sentence needs that "
                "introduction.",
          ),
          ExamItem(
            number: 38,
            stem: "38",
            explanation:
                "Work and the school journey compete for parents’ time. Reliable adult accompaniment "
                "solves that scheduling problem.",
          ),
          ExamItem(
            number: 39,
            stem: "39",
            explanation:
                "The narrow pavement and busy junction explain the safer, slightly longer route. “Saving "
                "two minutes” supports the detour.",
          ),
          ExamItem(
            number: 40,
            stem: "40",
            explanation:
                "A backup team addresses volunteer absences. “The reserve adults” in the following "
                "sentence refers to that team.",
          ),
          ExamItem(
            number: 41,
            stem: "41",
            explanation:
                "Noticing trees and shops shows that the children experience their surroundings during "
                "the journey.",
          ),
          ExamItem(
            number: 42,
            stem: "42",
            explanation:
                "The checks before advertising a second route illustrate prioritising reliability over "
                "rapid growth.",
          ),
        ],
        answers: {37: "E", 38: "D", 39: "G", 40: "C", 41: "A", 42: "F"},
      ),
      ExamPart(
        number: 7,
        name: "Multiple matching",
        from: 43,
        to: 52,
        type: AnswerType.choice,
        marksPerQuestion: 1,
        howToAnswer:
            "One letter, A to D. You may use each section more than once.",
        passage:
            "FOUR SHORT VOLUNTEER PROJECTS\n\nA — LUCY, a coastal clean-up\nI signed up after seeing "
            "photographs of rubbish on a beach I used to visit as a child. I expected a physically "
            "exhausting day and brought heavy gloves. In fact, the hardest work was recording what we"
            " found. We had to count and classify tiny pieces, not just fill bags as quickly as "
            "possible. At first that seemed unnecessary, until the organiser explained how the "
            "figures could identify the main sources of waste. A storm the following week brought "
            "more rubbish in. That was discouraging, but I understood that one clean beach was only "
            "part of the point.\n\nB — MATEO, a community kitchen\nI had recently moved to the area and "
            "wanted to meet people outside my workplace. The kitchen seemed a useful way to do that. "
            "My first job was washing containers, which was not the cooking experience I had "
            "imagined. Later I realised that the whole service depended on tasks nobody photographed."
            " I still mostly wash up, and I no longer mind. The friendships have lasted beyond the "
            "shifts: two volunteers helped me move house last month. I now make a point of welcoming "
            "newcomers, because I remember how difficult it was to walk through the door alone.\n\nC — "
            "SAIRA, repairing a footpath\nThe project took place in hills where I often run. I wanted "
            "to contribute something after years of using the paths. What surprised me was how "
            "carefully the leader explained each decision. Moving a stone a few centimetres could "
            "change where rainwater flowed. I assumed everyone else knew this already, but several "
            "experienced volunteers were learning too. We were told to stop when we were tired, even "
            "if a section remained unfinished. That seemed slow at the time. Now I see that an "
            "exhausted volunteer can create more repair work than they complete.\n\nD — BEN, recording "
            "local memories\nMy grandparents had died before I thought of asking them about their "
            "early lives, so this project felt personal. I interviewed older residents for a local "
            "archive. At first I followed my list of questions too closely and missed interesting "
            "remarks. A supervisor suggested using the list as a safety net, not a script. The "
            "interviews improved immediately. Some residents later asked for parts to be removed, and"
            " we always respected that. I had to accept that recording a story did not make it mine "
            "to use however I wanted.",
        items: [
          ExamItem(
            number: 43,
            stem: "43  Who joined mainly to build a new social circle?",
            explanation: "Mateo had moved to the area and specifically wanted social contact beyond work.",
          ),
          ExamItem(
            number: 44,
            stem: "44  Who came to understand the purpose of collecting detailed figures?",
            explanation:
                "Lucy initially thought detailed classification was unnecessary, then learnt that it "
                "identified sources of waste.",
          ),
          ExamItem(
            number: 45,
            stem: "45  Who had to recognise limits on their right to use what they produced?",
            explanation:
                "Residents could request deletions. Ben learnt that recording a story did not give him "
                "unrestricted control over it.",
          ),
          ExamItem(
            number: 46,
            stem:
                "46  Who wanted to repay a benefit they had enjoyed for years?",
            explanation: "Saira wanted to give something back after regularly using the paths for running.",
          ),
          ExamItem(
            number: 47,
            stem: "47  Who learnt to value necessary work that attracts little attention?",
            explanation:
                "Washing containers was less visible than cooking, but Mateo realised the service "
                "depended on it.",
          ),
          ExamItem(
            number: 48,
            stem: "48  Who was motivated by a missed opportunity in their own family?",
            explanation:
                "Ben had not asked his grandparents about their lives before they died, making the "
                "archive personally important.",
          ),
          ExamItem(
            number: 49,
            stem: "49  Who was taught that stopping work can prevent mistakes?",
            explanation: "The leader stopped tired volunteers because fatigue could create additional repair work.",
          ),
          ExamItem(
            number: 50,
            stem: "50  Who saw some of the visible results undone soon afterwards?",
            explanation: "A later storm brought rubbish back to the beach, which Lucy found discouraging.",
          ),
          ExamItem(
            number: 51,
            stem: "51  Who benefited from following a plan less rigidly?",
            explanation: "Treating questions as a safety net instead of a script improved Ben’s interviews.",
          ),
          ExamItem(
            number: 52,
            stem: "52  Who realised that more experienced participants did not know everything?",
            explanation: "Saira discovered that experienced volunteers were learning alongside her.",
          ),
        ],
        answers: {
          43: "B",
          44: "A",
          45: "D",
          46: "C",
          47: "B",
          48: "D",
          49: "C",
          50: "A",
          51: "D",
          52: "C",
        },
      ),
    ],
  ),
  ExamPaper(
    id: 'cil-7-use-of-english',
    name: 'Cíl Paper 7 · Use of English',
    source: PaperSource.cil,
    level: ExamLevel.b2,
    minutes: 40,
    note: "Food sharing, useful mistakes and urban gardens. Original B2 practice with a comment for every answer.",
    parts: [
      ExamPart(
        number: 1,
        name: "Multiple-choice cloze",
        from: 1,
        to: 8,
        type: AnswerType.choice,
        marksPerQuestion: 1,
        howToAnswer: "One letter. Choose the option that best fits the text.",
        passage:
            "THE FRIDGE AT THE END OF THE STREET\n\nA community fridge may look like an ordinary "
            "kitchen appliance, but it serves an unusual (1) ___. Anyone can leave surplus food "
            "inside, and anyone who needs it can take some home. The aim is to prevent good food from"
            " (2) ___ to waste.\n\nWhen our street introduced one, the organisers (3) ___ up a list of "
            "rules. Food must be labelled, and volunteers check the fridge every day. This careful "
            "organisation plays a (4) ___ role in keeping the project safe. Shops nearby soon began "
            "to contribute items that were still fresh but unlikely to sell before closing.\n\nThe "
            "project does not (5) ___ every problem connected with food waste. However, it has "
            "encouraged residents to think twice before buying more than they need. It has also (6) "
            "___ attention to the amount of perfectly good food that used to be discarded. The "
            "volunteers take it in (7) ___ to clean the fridge, so nobody has to be there every day. "
            "They hope other streets will follow their (8) ___ and start similar schemes.",
        items: [
          ExamItem(
            number: 1,
            stem: "1",
            options: ["intention", "purpose", "reason", "cause"],
            explanation: "“Serve a purpose” means perform a useful function.",
          ),
          ExamItem(
            number: 2,
            stem: "2",
            options: ["making", "doing", "taking", "going"],
            explanation: "The expression is “go to waste”. After “prevent ... from”, the verb takes the -ing form.",
          ),
          ExamItem(
            number: 3,
            stem: "3",
            options: ["brought", "grew", "pulled", "drew"],
            explanation: "“Draw up a list” means prepare it. The past tense of “draw” is “drew”.",
          ),
          ExamItem(
            number: 4,
            stem: "4",
            options: ["vital", "alive", "lively", "living"],
            explanation: "“Play a vital role” means be extremely important to the success of something.",
          ),
          ExamItem(
            number: 5,
            stem: "5",
            options: ["cope", "respond", "solve", "reply"],
            explanation: "We “solve a problem”. The object here is “every problem connected with food waste”.",
          ),
          ExamItem(
            number: 6,
            stem: "6",
            options: ["drawn", "taken", "done", "made"],
            explanation:
                "“Draw attention to” means make people notice something. “Has drawn” is the present "
                "perfect.",
          ),
          ExamItem(
            number: 7,
            stem: "7",
            options: ["steps", "times", "orders", "turns"],
            explanation: "“Take it in turns” means share a task by doing it at different times.",
          ),
          ExamItem(
            number: 8,
            stem: "8",
            options: ["instance", "sample", "case", "example"],
            explanation:
                "“Follow someone’s example” means do what they have done.",
          ),
        ],
        answers: {
          1: "B",
          2: "D",
          3: "D",
          4: "A",
          5: "C",
          6: "A",
          7: "D",
          8: "D",
        },
      ),
      ExamPart(
        number: 2,
        name: "Open cloze",
        from: 9,
        to: 16,
        type: AnswerType.word,
        marksPerQuestion: 1,
        howToAnswer: "Exactly one word in each gap.",
        passage:
            "GETTING IT WRONG FIRST\n\nThe first time I tried to make bread, the result was almost "
            "impossible to eat. I had used far too much flour and had not left the dough long (9) ___"
            " to rise. I was so disappointed (10) ___ I nearly threw the recipe away.\n\nA friend "
            "persuaded me to try again. She pointed (11) ___ that the instructions assumed I already "
            "understood several basic techniques. We watched a demonstration together, and I realised"
            " (12) ___ I had done wrong. The next loaf was much better, although it still looked "
            "nothing (13) ___ the photograph in the book.\n\nSince then, I have kept a notebook of "
            "small changes to the recipe. Instead (14) ___ judging each attempt as a success or "
            "failure, I ask myself what it has taught me. There is always something (15) ___ can be "
            "improved. I still make mistakes, but I am no (16) ___ embarrassed by them. They are "
            "simply part of learning a skill.",
        items: [
          ExamItem(
            number: 9,
            stem: "9",
            explanation:
                "“Long enough to rise” means for a sufficient amount of time. “Enough” follows the "
                "adjective or adverb.",
          ),
          ExamItem(
            number: 10,
            stem: "10",
            explanation: "The result structure is “so disappointed that ...”.",
          ),
          ExamItem(
            number: 11,
            stem: "11",
            explanation:
                "“Point out” means draw attention to a fact or explain it.",
          ),
          ExamItem(
            number: 12,
            stem: "12",
            explanation: "“What I had done wrong” means the thing or things I had done incorrectly.",
          ),
          ExamItem(
            number: 13,
            stem: "13",
            explanation:
                "“Look nothing like” means not resemble something at all.",
          ),
          ExamItem(
            number: 14,
            stem: "14",
            explanation: "The expression is “instead of”, followed here by an -ing form.",
          ),
          ExamItem(
            number: 15,
            stem: "15",
            explanation:
                "“That” or “which” introduces a relative clause describing “something”. It is the subject"
                " of “can be improved”.",
          ),
          ExamItem(
            number: 16,
            stem: "16",
            explanation:
                "“No longer” means a previous situation has ended. The writer used to be embarrassed but "
                "is not now.",
          ),
        ],
        answers: {
          9: "enough",
          10: "that",
          11: "out",
          12: "what",
          13: "like",
          14: "of",
          15: "that/which",
          16: "longer",
        },
      ),
      ExamPart(
        number: 3,
        name: "Word formation",
        from: 17,
        to: 24,
        type: AnswerType.word,
        marksPerQuestion: 1,
        howToAnswer: "Exactly one word in each gap.",
        passage:
            "A GARDEN ABOVE THE ROAD\n\nAn unused car park has become an (17) ___ (ATTRACT) garden "
            "above a busy road. The project began when residents noticed that the top level had been "
            "empty for years. Their (18) ___ (PROPOSE) was simple: replace parking spaces with "
            "growing spaces.\n\nEngineers first checked the (19) ___ (STRONG) of the structure. Safety "
            "was essential, particularly because wet soil is (20) ___ (SURPRISE) heavy. Only after "
            "the building passed the checks did planting begin.\n\nToday the garden contains "
            "vegetables, flowers and a small (21) ___ (COLLECT) of fruit trees. Residents share (22) "
            "___ (RESPONSIBLE) for watering and clearing paths. New members are given practical "
            "advice, so a lack of gardening experience is no (23) ___ (ADVANTAGE). The space has "
            "become a place where people meet as well as grow food. Its (24) ___ (CREATE) has changed"
            " how the whole neighbourhood thinks about an ugly building that once seemed useful only "
            "for cars.",
        items: [
          ExamItem(
            number: 17,
            stem: "17",
            explanation: "An adjective describes “garden”. “Attractive” means pleasant to look at.",
          ),
          ExamItem(
            number: 18,
            stem: "18",
            explanation: "“Their proposal” is the suggestion they put forward. The possessive needs a noun.",
          ),
          ExamItem(
            number: 19,
            stem: "19",
            explanation: "The noun from “strong” is “strength”: the building’s ability to support weight.",
          ),
          ExamItem(
            number: 20,
            stem: "20",
            explanation:
                "An adverb modifies the adjective “heavy”. “Surprisingly heavy” means heavier than "
                "expected.",
          ),
          ExamItem(
            number: 21,
            stem: "21",
            explanation:
                "“A small collection of” describes a group of fruit trees.",
          ),
          ExamItem(
            number: 22,
            stem: "22",
            explanation:
                "“Share responsibility for” means jointly take care of a task. Use the noun "
                "“responsibility”.",
          ),
          ExamItem(
            number: 23,
            stem: "23",
            explanation:
                "“No disadvantage” means the lack of experience does not put beginners in a worse "
                "position. The negative prefix matters.",
          ),
          ExamItem(
            number: 24,
            stem: "24",
            explanation: "The noun “creation” refers to making the garden. It is the subject of “has changed”.",
          ),
        ],
        answers: {
          17: "attractive",
          18: "proposal",
          19: "strength",
          20: "surprisingly",
          21: "collection",
          22: "responsibility",
          23: "disadvantage",
          24: "creation",
        },
      ),
      ExamPart(
        number: 4,
        name: "Key word transformation",
        from: 25,
        to: 30,
        type: AnswerType.transformation,
        marksPerQuestion: 2,
        howToAnswer: "Two to five words, including the given word unchanged. Each half earns one mark.",
        items: [
          ExamItem(
            number: 25,
            stem: "Parking here is forbidden.\nALLOWED\nYou ___ here.",
            explanation:
                "“Are not allowed to” expresses the prohibition. Add “park” to complete the five-word "
                "answer.",
          ),
          ExamItem(
            number: 26,
            stem: "Visiting the museum is a good idea.\nWORTH\nThe museum ___.",
            explanation:
                "“Be worth” is followed by an -ing form, not an infinitive.",
          ),
          ExamItem(
            number: 27,
            stem: "We managed to finish the work before lunch.\nSUCCEEDED\nWe ___ the work before lunch.",
            explanation: "“Succeed in” takes an -ing form. It means manage to achieve something.",
          ),
          ExamItem(
            number: 28,
            stem: "I started learning Spanish in January and I am still learning it.\nBEEN\nI ___ Spanish since January.",
            explanation:
                "The present perfect continuous describes an activity that began in the past and is still"
                " continuing.",
          ),
          ExamItem(
            number: 29,
            stem: "A mechanic repaired my bicycle yesterday.\nHAD\nI ___ yesterday.",
            explanation:
                "“Have something done” means arrange for another person to do it. The past time requires "
                "“had”.",
          ),
          ExamItem(
            number: 30,
            stem: "The weather was so bad that the picnic was cancelled.\nSUCH\nIt ___ that the picnic was cancelled.",
            explanation:
                "“Such + adjective + uncountable noun” replaces “so + adjective”. “Weather” does not take"
                " “a”.",
          ),
        ],
        answers: {
          25: "are not allowed | to park",
          26: "is worth | visiting",
          27: "succeeded | in finishing",
          28: "have been | learning",
          29: "had | my bicycle repaired",
          30: "was | such bad weather",
        },
      ),
    ],
  ),
  ExamPaper(
    id: 'cil-8-reading',
    name: 'Cíl Paper 8 · Reading',
    source: PaperSource.cil,
    level: ExamLevel.b2,
    minutes: 35,
    note: "Translating games, a community newspaper and changing routines. Original B2 practice with a comment for every answer.",
    parts: [
      ExamPart(
        number: 5,
        name: "Multiple choice",
        from: 31,
        to: 36,
        type: AnswerType.choice,
        marksPerQuestion: 2,
        howToAnswer: "One letter. Choose the option that best fits the text.",
        passage:
            "TRANSLATING THE RULES OF PLAY\n\nFor years, Aisha translated instruction manuals for "
            "household equipment. Then a small publisher asked her to translate a board game. She "
            "expected the task to be easier: there were fewer words, no complicated machinery and "
            "plenty of pictures. After three days she had translated every sentence but still could "
            "not work out how to play. The words were individually clear; the sequence of actions was"
            " not. It was an uncomfortable reminder that understanding a sentence and understanding "
            "an activity are different things.\n\nAisha persuaded the publisher to send her a "
            "prototype. Playing with two friends revealed questions that had never occurred to her at"
            " a desk. Could a player keep an unused card? Did a move end before or after a reward was"
            " collected? The original instructions did not always make this clear. She sent a list of"
            " questions to the designer, who was surprised that anyone could misunderstand something "
            "he had played hundreds of times. His familiarity with the game was part of the problem."
            "\n\nNow Aisha specialises in games. She begins by watching people play, ideally without "
            "explaining the rules herself. If she has to intervene, she notes exactly where the "
            "confusion arose. A successful translation, she says, should not require its translator "
            "to sit at every table. She also watches what people call the pieces. A technically "
            "precise term may be less useful than a short word that players can find quickly during "
            "an argument about whose turn comes next.\n\nHumour presents a different difficulty. One "
            "game used a joke based on two English words that sound alike. Translating either word "
            "accurately would have removed the joke. Aisha proposed a different joke that served the "
            "same purpose in the game. The designer initially objected because the wording was so "
            "different, then accepted it after hearing players laugh in the right place. For Aisha, "
            "this was not permission to rewrite everything. It was a case in which preserving the "
            "effect required changing the words.\n\nPublishers occasionally ask whether automatic "
            "translation could reduce her workload. She uses digital tools for checking consistency, "
            "particularly when a game contains hundreds of cards. However, a tool cannot tell her "
            "that a perfectly grammatical instruction causes two players to perform the same action "
            "in different ways. That requires testing. She would rather spend money on an extra "
            "session with players than on making a rulebook look impressive before anyone has tried "
            "to use it.\n\nThe least visible part of her work is often the most satisfying. At a recent"
            " event, she watched a family play a game she had translated without once opening the "
            "section explaining disputed rules. Afterwards, nobody mentioned the translation. She "
            "took that as a compliment. Her job was not to make players admire her sentences, but to "
            "give them a fair chance of enjoying the game together.",
        items: [
          ExamItem(
            number: 31,
            stem: "31  What did Aisha discover during her first game translation?",
            options: [
              "Clear individual sentences did not necessarily explain the whole activity.",
              "Board-game publishers expected translations to be completed too quickly.",
              "Most players were unwilling to read written instructions.",
              "Pictures were less useful than technical diagrams.",
            ],
            explanation:
                "Aisha had translated every sentence but could not play. The problem was the sequence of "
                "actions rather than difficult vocabulary.",
          ),
          ExamItem(
            number: 32,
            stem: "32  Why was the designer surprised by Aisha’s questions?",
            options: [
              "He believed translators should already know the game well.",
              "His experience made it hard to notice what beginners needed explained.",
              "He wanted the players to invent their own sequence of actions.",
              "He had deliberately left some rules open to interpretation.",
            ],
            explanation:
                "Playing hundreds of times made the designer overlook ambiguities that were obvious to "
                "new players.",
          ),
          ExamItem(
            number: 33,
            stem: "33  Why does Aisha prefer not to explain the rules during testing?",
            options: [
              "To make the testing sessions shorter and less expensive.",
              "To discover whether the instructions work without additional help.",
              "To decide which players are best at explaining new games.",
              "To avoid influencing the players’ choice of strategy.",
            ],
            explanation:
                "She observes silently and notes when she must intervene. The translation should function"
                " without her presence.",
          ),
          ExamItem(
            number: 34,
            stem: "34  What does the example of the joke illustrate?",
            options: [
              "Accurate translation is less important in games than in manuals.",
              "Humour should be removed whenever it depends on word sounds.",
              "A change in wording can preserve the intended response.",
              "Designers generally prefer jokes written by translators.",
            ],
            explanation:
                "The new joke made players laugh at the intended point. This illustrates preserving an "
                "effect, not freely rewriting every rule.",
          ),
          ExamItem(
            number: 35,
            stem: "35  What is Aisha’s view of digital tools?",
            options: [
              "They can identify most problems before a prototype exists.",
              "They assist with some checks but cannot replace observing players.",
              "They mainly help make rulebooks visually attractive.",
              "They are useful only for games containing very few words.",
            ],
            explanation:
                "Aisha uses tools for consistency while relying on testing to reveal different "
                "interpretations of grammatical instructions.",
          ),
          ExamItem(
            number: 36,
            stem: "36  Why was Aisha pleased that nobody mentioned her translation?",
            options: [
              "The family had chosen to ignore the most difficult rules.",
              "Other translators at the event had praised her style.",
              "It had helped people play without drawing attention to itself.",
              "The publisher had reduced the size of the rulebook.",
            ],
            explanation:
                "The family enjoyed the game without needing to discuss the translation. Aisha sees that "
                "unobtrusive usefulness as success.",
          ),
        ],
        answers: {31: "A", 32: "B", 33: "B", 34: "C", 35: "B", 36: "C"},
      ),
      ExamPart(
        number: 6,
        name: "Gapped text",
        from: 37,
        to: 42,
        type: AnswerType.choice,
        marksPerQuestion: 2,
        howToAnswer: "One letter, A to G. Six gaps, seven sentences: one sentence is not used.",
        passage:
            "NEWS FROM THREE STREETS\n\nWhen the last local newspaper stopped printing, residents still"
            " had social media, but many felt less informed about nearby events. Important notices "
            "disappeared between advertisements and arguments. (37) ___ A folded sheet delivered once"
            " a month seemed an unlikely answer to a digital problem.\n\nThe first issue was produced "
            "by three neighbours around a kitchen table. They included a school concert, a road "
            "closure and a request for old gardening tools. (38) ___ People were clearly willing to "
            "read about small things when those things happened close to home.\n\nThe editors quickly "
            "discovered that collecting information was easier than checking it. Someone reported "
            "that a playground was about to close permanently, when it was actually being repaired "
            "for a week. (39) ___ The correction reached them just before the pages went to the "
            "printer.\n\nThey introduced a rule: every factual announcement needed a named source who "
            "could be contacted. This slowed the work, but contributors gradually learnt what details"
            " to include. (40) ___ It became easier to distinguish a confirmed event from a rumour.\n\n"
            "Money was another challenge. The editors wanted local businesses to advertise, but they "
            "did not want advertisers choosing the stories. (41) ___ A restaurant could buy space for"
            " an announcement, but it could not buy a favourable review.\n\nAfter a year, the paper "
            "covered three streets and had no plans to become a city-wide publication. Larger "
            "coverage would mean fewer reports about each place. (42) ___ The editors preferred to "
            "remain useful to a small group rather than vaguely interesting to everyone.\n\nTHE MISSING"
            " SENTENCES\n\nA  The team therefore kept advertising decisions separate from editorial "
            "ones.\nB  Several readers suggested that all local news should be replaced by national "
            "stories.\nC  That would remove the closeness which had made the paper worth reading.\nD  "
            "By the following weekend, requests for the next issue were already arriving.\nE  So a few"
            " residents decided to put the most useful information back on paper.\nF  The extra effort"
            " began to pay off.\nG  A telephone call to the council prevented the alarming mistake "
            "from being published.",
        items: [
          ExamItem(
            number: 37,
            stem: "37",
            explanation:
                "E introduces the decision to print local information. The following “folded sheet” "
                "describes the result of that decision.",
          ),
          ExamItem(
            number: 38,
            stem: "38",
            explanation:
                "Requests for another issue provide evidence for the next sentence’s claim that people "
                "wanted this local information.",
          ),
          ExamItem(
            number: 39,
            stem: "39",
            explanation:
                "The phone call checks the playground rumour. “The correction” in the next sentence "
                "follows naturally from that check.",
          ),
          ExamItem(
            number: 40,
            stem: "40",
            explanation:
                "Checking sources takes extra effort. The next sentence explains its benefit: separating "
                "confirmed events from rumours.",
          ),
          ExamItem(
            number: 41,
            stem: "41",
            explanation:
                "Separate decisions protect the newspaper from advertiser influence. The restaurant "
                "example illustrates this boundary.",
          ),
          ExamItem(
            number: 42,
            stem: "42",
            explanation:
                "“That” refers to wider coverage with fewer reports about each place. Losing local "
                "closeness would undermine the paper’s purpose.",
          ),
        ],
        answers: {37: "E", 38: "D", 39: "G", 40: "F", 41: "A", 42: "C"},
      ),
      ExamPart(
        number: 7,
        name: "Multiple matching",
        from: 43,
        to: 52,
        type: AnswerType.choice,
        marksPerQuestion: 1,
        howToAnswer:
            "One letter, A to D. You may use each section more than once.",
        passage:
            "FOUR PEOPLE CHANGE A DAILY HABIT\n\nA — EVIE, leaving her phone outside the bedroom\nI used"
            " to check messages before I was properly awake. I bought a cheap alarm clock and started"
            " charging my phone in the kitchen. For the first week, I kept imagining that I could "
            "hear it. Now I read a few pages before sleeping, something I had not done for years. I "
            "am not against technology, and I still need my phone for work. The change works because "
            "it concerns one room and one part of the day. When friends suggest giving up my phone "
            "entirely, I know that would never last.\n\nB — LUIS, cycling to work\nI began because the "
            "bus fare had increased again, not because I wanted to train for a race. My first route "
            "followed the main road and was unpleasant. A colleague showed me a quieter way through a"
            " park. It adds ten minutes, but that is now my favourite part of the day. Rain was my "
            "biggest worry. After buying a decent jacket, I discovered that traffic, not weather, was"
            " what made the journey stressful. I still take the bus occasionally, and I do not count "
            "those days as failures.\n\nC — MAYA, planning meals\nAt the end of each week, I used to "
            "throw away vegetables I had forgotten buying. Now I check the cupboards before making a "
            "short shopping list. My original plan was much too ambitious: seven different recipes "
            "with ingredients I rarely used. I simplified it to three basic meals that could be "
            "adapted. The unexpected benefit has been less decision-making after work. My partner was"
            " sceptical at first, but started helping once we could see how much less food we were "
            "wasting. We spend a little time on Sunday to save effort later.\n\nD — OWEN, walking "
            "during lunch\nI work from home, and some days the furthest I moved was between the desk "
            "and the kettle. I arranged to meet a neighbour for a short walk at lunchtime. On busy "
            "days, knowing she is waiting gets me out of the door. I expected the break to reduce the"
            " amount of work I finished. In practice, I often solve a problem during the walk that "
            "had kept me stuck all morning. We avoid discussing our jobs unless one of us "
            "specifically wants advice. The walk is a pause, not another meeting.",
        items: [
          ExamItem(
            number: 43,
            stem: "43  Who was initially motivated by a higher financial cost?",
            explanation: "Luis explicitly says the rising bus fare, rather than sport, made him begin cycling.",
          ),
          ExamItem(
            number: 44,
            stem: "44  Who believes a limited change is more sustainable than a complete ban?",
            explanation:
                "Evie’s change is limited to the bedroom and nighttime. She expects a total ban to be "
                "unsustainable.",
          ),
          ExamItem(
            number: 45,
            stem: "45  Who relies on a commitment to another person to maintain the habit?",
            explanation: "The neighbour’s expectation that Owen will arrive helps him leave the desk on busy days.",
          ),
          ExamItem(
            number: 46,
            stem: "46  Who had to make an overambitious plan simpler?",
            explanation: "Maya replaced seven complex recipes with three adaptable basic meals.",
          ),
          ExamItem(
            number: 47,
            stem: "47  Who accepted a longer journey in exchange for a more pleasant one?",
            explanation: "A colleague suggested the park route, which is longer but much more enjoyable.",
          ),
          ExamItem(
            number: 48,
            stem: "48  Who discovered that the change reduced mental effort later in the day?",
            explanation: "Maya did not expect the reduction in decisions after work to be such a benefit.",
          ),
          ExamItem(
            number: 49,
            stem: "49  Who returned to an activity they had stopped doing?",
            explanation: "Leaving the phone elsewhere led Evie to read before bed again after several years.",
          ),
          ExamItem(
            number: 50,
            stem: "50  Who found that taking time away could help them work more effectively?",
            explanation: "Owen expected to finish less work but instead often solves problems during the break.",
          ),
          ExamItem(
            number: 51,
            stem: "51  Who gained another person’s support after showing a practical result?",
            explanation:
                "Maya’s partner began helping after visible reductions in food waste overcame initial "
                "scepticism.",
          ),
          ExamItem(
            number: 52,
            stem: "52  Who accepts occasional exceptions without considering the habit unsuccessful?",
            explanation: "Luis sometimes takes the bus and explicitly does not treat those days as failures.",
          ),
        ],
        answers: {
          43: "B",
          44: "A",
          45: "D",
          46: "C",
          47: "B",
          48: "C",
          49: "A",
          50: "D",
          51: "C",
          52: "B",
        },
      ),
    ],
  ),
];
