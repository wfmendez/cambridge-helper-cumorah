/// Cíl Paper 2 — B2 First Reading, Parts 5 to 7.
///
/// The reading half of the paper: one long text with multiple choice, a gapped
/// text, and multiple matching across four short texts. All three written for
/// this app, so the passages travel with it.
///
/// Twenty-two questions, thirty-four marks. Parts 5 and 6 are worth two marks
/// each, Part 7 one — the same weighting as the real paper, which is why
/// rushing Part 7 costs less than rushing Part 5.
library;

import 'cambridge.dart';

const ExamPaper cilPaper2 = ExamPaper(
  id: 'cil-2-reading',
  level: ExamLevel.b2,
  source: PaperSource.cil,
  name: 'Cíl Paper 2 · Reading',
  minutes: 35,
  note:
      'Parts 5, 6 and 7 with their texts included. Read on the phone, answer '
      'on the phone.',
  parts: [
    ExamPart(
      number: 5,
      name: 'Multiple choice',
      blurb: 'One long text. Detail, opinion, attitude and implication.',
      howToAnswer:
          'One letter: A, B, C or D. The questions follow the order '
          'of the text.',
      from: 31,
      to: 36,
      type: AnswerType.choice,
      marksPerQuestion: 2,
      passage:
          'THE MAP RESTORER\n\n'
          'Ana Ferreira did not set out to spend her life repairing paper. She '
          'trained as a chemist, and for six years she tested adhesives for a '
          'packaging firm in Porto. The work paid well and bored her '
          'completely. When a friend asked whether she could do anything about '
          'a water-damaged sea chart inherited from an uncle, Ana said yes '
          'mainly to have something to think about on a Sunday.\n\n'
          'The chart took her four months. She now describes the result as '
          'clumsy, and keeps a photograph of it above her bench as a '
          'corrective. What it taught her, she says, was not technique but '
          'patience: the discovery that a repair which takes a week and holds '
          'for a century is a better piece of work than one finished in an '
          'afternoon.\n\n'
          'Her studio in Lisbon now handles maps from collectors and museums '
          'across Europe. Collectors are the harder clients, though not for '
          'the reasons people assume. They are rarely difficult about money. '
          'What they struggle with is being told that a map should be left '
          'alone. Ana estimates that she turns away one commission in five '
          'because the damage is part of the object’s history rather than '
          'a fault in it — a fold worn through by two hundred years of use, a '
          'corner darkened by the hands that held it.\n\n'
          'Museums, by contrast, tend to arrive having already decided what '
          'they want, which brings its own difficulties. Ana recalls one '
          'institution that insisted on removing a nineteenth-century owner’s '
          'annotations from a Portuguese coastal chart. She refused, and lost '
          'the contract. The annotations, she argued, were the only evidence '
          'anyone had ever used the thing.\n\n'
          'Asked whether she misses the laboratory, she laughs. The chemistry '
          'never left, she points out: she still spends her mornings thinking '
          'about how substances behave over time. The difference is that '
          'nobody at the packaging firm ever cared what happened to their '
          'work after fifty years.',
      items: [
        ExamItem(
          number: 31,
          stem: '31  Why did Ana agree to repair her friend’s sea chart?',
          options: [
            'She wanted to prove her chemical training was useful.',
            'She was looking for an interest outside her job.',
            'She hoped it might lead to paid work.',
            'She felt she could not refuse a friend.',
          ],
        ),
        ExamItem(
          number: 32,
          stem: '32  Why does Ana keep a photograph of her first restoration?',
          options: [
            'It reminds her of how much she has improved.',
            'It was the work that changed her career.',
            'It stops her from becoming satisfied with her work.',
            'It is the only record of a map she no longer owns.',
          ],
        ),
        ExamItem(
          number: 33,
          stem:
              '33  What does Ana say is difficult about working with '
              'collectors?',
          options: [
            'They argue about what the work should cost.',
            'They expect repairs to be finished quickly.',
            'They do not accept that some damage should stay.',
            'They know less about maps than they claim.',
          ],
        ),
        ExamItem(
          number: 34,
          stem:
              '34  What does “which brings its own difficulties” in the '
              'fourth paragraph refer to?',
          options: [
            'the distance museums are willing to send maps',
            'museums having settled on a decision in advance',
            'the age of the documents museums hold',
            'the number of people involved in a museum commission',
          ],
        ),
        ExamItem(
          number: 35,
          stem: '35  Why did Ana refuse the museum commission?',
          options: [
            'The annotations proved the map had been used.',
            'Removing the annotations would have damaged the paper.',
            'She disagreed with the museum about the map’s age.',
            'The work would have taken longer than agreed.',
          ],
        ),
        ExamItem(
          number: 36,
          stem:
              '36  What does Ana suggest about her old job in the final '
              'paragraph?',
          options: [
            'It required less scientific knowledge than her work now.',
            'It was more demanding than she had expected.',
            'Its results were not meant to last.',
            'She regrets having stayed in it for so long.',
          ],
        ),
      ],
      answers: {31: 'B', 32: 'C', 33: 'C', 34: 'B', 35: 'A', 36: 'C'},
    ),
    ExamPart(
      number: 6,
      name: 'Gapped text',
      blurb: 'Six sentences have been removed. One is never used.',
      howToAnswer:
          'One letter, A to G. Look at what points backwards and '
          'forwards: this, those, even so, meanwhile.',
      from: 37,
      to: 42,
      type: AnswerType.choice,
      marksPerQuestion: 2,
      passage:
          'BEES ON THE ROOF\n\n'
          'Ten years ago, keeping bees in the middle of a city sounded like a '
          'hobby for people with more enthusiasm than sense. Today there are '
          'hives on the roofs of hospitals, hotels and at least one opera '
          'house. (37) ___\n\n'
          'The appeal is easy to understand. A rooftop costs nothing to rent '
          'if you already own the building, and bees are undemanding tenants. '
          'They need water, some shelter from wind, and to be left alone for '
          'most of the year. (38) ___ Beekeepers in the countryside often '
          'report worse harvests than their urban counterparts.\n\n'
          'This is not because cities are unusually kind to insects. It is '
          'because modern farmland is unusually hostile to them. A field of a '
          'single crop offers an intense burst of food for three weeks and '
          'nothing at all for the rest of the summer. (39) ___\n\n'
          'Not everyone is convinced that more hives are the answer. '
          '(40) ___ Honeybees are livestock, kept in large managed colonies, '
          'and where they are dense they compete for flowers with the wild '
          'bees that most plants actually depend on.\n\n'
          'The researchers making this argument are not against urban '
          'beekeeping as such. Their objection is to the idea that installing '
          'a hive is a conservation act. (41) ___ A hive, they point out, '
          'feeds itself; a meadow feeds everything.\n\n'
          'Several cities have started to listen. Paris and London now '
          'publish guidance suggesting a maximum density of hives per square '
          'kilometre, and some councils have quietly stopped approving new '
          'ones. (42) ___ For the moment, the rooftops are still filling up.\n\n'
          '— — —\n\n'
          'THE MISSING SENTENCES\n\n'
          'A  Even so, the guidance carries no legal weight.\n\n'
          'B  Planting for pollinators, they argue, does far more good than '
          'keeping them.\n\n'
          'C  A city, by contrast, flowers unevenly but almost continuously, '
          'from February crocuses to October ivy.\n\n'
          'D  In return they produce honey that, blind-tasted, regularly beats '
          'the rural sort.\n\n'
          'E  The shift has been fast enough to surprise the people who '
          'started it.\n\n'
          'F  Most of them had never kept an animal of any kind before.\n\n'
          'G  Their concern is that the word “bee” hides an important '
          'distinction.',
      items: [
        ExamItem(number: 37, stem: '37'),
        ExamItem(number: 38, stem: '38'),
        ExamItem(number: 39, stem: '39'),
        ExamItem(number: 40, stem: '40'),
        ExamItem(number: 41, stem: '41'),
        ExamItem(number: 42, stem: '42'),
      ],
      answers: {37: 'E', 38: 'D', 39: 'C', 40: 'G', 41: 'B', 42: 'A'},
    ),
    ExamPart(
      number: 7,
      name: 'Multiple matching',
      blurb: 'Four short texts. Sections can be chosen more than once.',
      howToAnswer:
          'One letter: A, B, C or D. Read the questions first, then '
          'scan — do not read the texts properly.',
      from: 43,
      to: 52,
      type: AnswerType.choice,
      marksPerQuestion: 1,
      passage:
          'FOUR PEOPLE WHO CHANGED CAREER AFTER FORTY\n\n'
          'A — MIRIAM, now a paramedic\n'
          'I spent twenty-two years in insurance and I was good at it, which '
          'turned out to be the problem: nobody could understand why I would '
          'leave. My husband was the only one who did not try to talk me out '
          'of it. The training was brutal and I was the oldest on the course '
          'by fifteen years, but I had one advantage the others did not — I '
          'had already learned how to stay calm while somebody shouted at me. '
          'The pay cut was severe and I have never once regretted it. What I '
          'miss, oddly, is having colleagues who sit still long enough to have '
          'a conversation.\n\n'
          'B — TOMÁS, now a secondary school teacher\n'
          'People assume I left engineering because I burned out. In fact I '
          'left because my company moved me into management and I discovered I '
          'disliked being responsible for adults. Teenagers are far easier. My '
          'family thought it was a phase and said so repeatedly, which made '
          'the first year harder than it needed to be. I earn roughly half '
          'what I did. The thing nobody warns you about is how long it takes '
          'to stop thinking like your old profession: I still catch myself '
          'trying to optimise a lesson plan as though it were a production '
          'line.\n\n'
          'C — GRETA, now a carpenter\n'
          'I was a translator for eighteen years, freelance, working alone in '
          'a small flat. The decision took about four years and one bad '
          'winter. Everyone I told was encouraging, almost suspiciously so, as '
          'though they had all been waiting for me to say it. Financially it '
          'was easier than people expect, because I had been paid badly for so '
          'long that the apprenticeship wage was not much of a drop. I do miss '
          'the words. Sometimes I finish a cabinet and catch myself wanting to '
          'explain it in three languages, with nobody to explain it to.\n\n'
          'D — PAUL, now a nurse\n'
          'Twenty-six years as a chef. I left because my knees went, and I '
          'would probably still be there otherwise, so I cannot claim it was '
          'brave. Everybody was supportive, which I found almost annoying at '
          'the time. Money-wise it is comparable, slightly better in fact once '
          'you count the hours. What surprised me was how much transferred: a '
          'busy ward at four in the morning is a kitchen during service, and I '
          'already knew how to work a twelve-hour shift without losing my '
          'temper. The part I have not got used to is going home before '
          'midnight.',
      items: [
        ExamItem(
          number: 43,
          stem:
              '43  Which person had their decision '
              'questioned by their family?',
        ),
        ExamItem(
          number: 44,
          stem:
              '44  Which person says their earnings '
              'barely changed?',
        ),
        ExamItem(
          number: 45,
          stem:
              '45  Which person mentions an advantage '
              'their younger classmates lacked?',
        ),
        ExamItem(
          number: 46,
          stem:
              '46  Which person found other people’s '
              'approval slightly irritating?',
        ),
        ExamItem(
          number: 47,
          stem:
              '47  Which person misses something about '
              'their old working environment?',
        ),
        ExamItem(
          number: 48,
          stem:
              '48  Which person says the change was '
              'forced on them physically?',
        ),
        ExamItem(
          number: 49,
          stem:
              '49  Which person says old habits of '
              'thought have stayed with them?',
        ),
        ExamItem(
          number: 50,
          stem:
              '50  Which person took several years to '
              'decide?',
        ),
        ExamItem(
          number: 51,
          stem:
              '51  Which person had been promoted into '
              'work they did not enjoy?',
        ),
        ExamItem(
          number: 52,
          stem:
              '52  Which person accepted a much lower '
              'income without regret?',
        ),
      ],
      answers: {
        43: 'B',
        44: 'D',
        45: 'A',
        46: 'D',
        47: 'A',
        48: 'D',
        49: 'B',
        50: 'C',
        51: 'B',
        52: 'A',
      },
    ),
  ],
);
