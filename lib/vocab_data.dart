/// The word bank.
///
/// Practice tests you on words; this is the list to read before being tested.
/// Everything here is chosen because Cambridge keeps coming back to it — the
/// word families that Part 3 is built from, the dependent prepositions that
/// Part 2 lives on, and the formal/informal pairs that decide the register
/// mark in Writing.
///
/// Each entry says what the word means in plain English and shows it in a
/// sentence. A list of words with no sentence is a list you cannot use.
library;

import 'cambridge.dart';

class VocabEntry {
  const VocabEntry(this.term, this.meaning, this.example);

  final String term;
  final String meaning;
  final String example;
}

class VocabSet {
  const VocabSet({
    required this.id,
    required this.name,
    required this.blurb,
    required this.entries,
    this.level = ExamLevel.b2,
  });

  final String id;
  final String name;
  final String blurb;
  final ExamLevel level;
  final List<VocabEntry> entries;
}

/// The sets at or below a goal, hardest last.
List<VocabSet> vocabForGoal(ExamLevel goal) =>
    vocabSets.where((s) => s.level.index <= goal.index).toList();

const List<VocabSet> vocabSets = [
  // ── Dependent prepositions ────────────────────────────────────────────────
  VocabSet(
    id: 'prepositions',
    name: 'Dependent prepositions',
    blurb:
        'The preposition is part of the word, not a choice. Learn them as one '
        'unit and Part 2 stops being a guess.',
    level: ExamLevel.b1,
    entries: [
      VocabEntry(
        'good / bad at',
        'skilled or unskilled in something',
        'She is unusually good at reading maps.',
      ),
      VocabEntry(
        'interested in',
        'wanting to know more',
        'He became interested in architecture at school.',
      ),
      VocabEntry(
        'afraid / frightened of',
        'scared by',
        'I was never afraid of the dark, only of the stairs.',
      ),
      VocabEntry(
        'depend / rely on',
        'need in order to work',
        'The whole plan depends on the weather holding.',
      ),
      VocabEntry(
        'succeed in',
        'manage to do',
        'They succeeded in raising the money in a month.',
      ),
      VocabEntry(
        'accuse someone of',
        'say they did something wrong',
        'He was accused of copying the report.',
      ),
      VocabEntry(
        'blame someone for',
        'say it is their fault',
        'Nobody blamed her for leaving early.',
      ),
      VocabEntry(
        'apologise for',
        'say sorry about',
        'She apologised for not having replied sooner.',
      ),
      VocabEntry(
        'insist on',
        'demand firmly',
        'He insisted on paying for everyone.',
      ),
      VocabEntry(
        'consist of',
        'be made up of',
        'The course consists of four short modules.',
      ),
      VocabEntry(
        'result in / from',
        'cause / be caused by',
        'The delay resulted in extra costs; the costs resulted from the '
            'delay.',
      ),
      VocabEntry(
        'capable of',
        'able to do',
        'He is perfectly capable of finishing it alone.',
      ),
      VocabEntry(
        'aware of',
        'knowing about',
        'I was not aware of the deadline until Friday.',
      ),
      VocabEntry(
        'responsible for',
        'in charge of, or to blame for',
        'Who is responsible for locking up?',
      ),
      VocabEntry(
        'similar to / different from',
        'alike / unlike',
        'This is similar to the last one but different from the first.',
      ),
    ],
  ),

  // ── make · do · take · have ───────────────────────────────────────────────
  VocabSet(
    id: 'colocaciones',
    name: 'make, do, take, have',
    blurb:
        'Four verbs that carry half of everyday English. Which one goes with '
        'which noun is fixed, and there is no rule that covers it.',
    level: ExamLevel.b1,
    entries: [
      VocabEntry(
        'make a decision / an effort / a mistake',
        'produce something that was not there before',
        'She made an effort and it showed.',
      ),
      VocabEntry(
        'make progress / sense / a difference',
        'the abstract half of *make*',
        'Your being there made a real difference.',
      ),
      VocabEntry(
        'do the washing-up / homework / the shopping',
        'tasks and chores',
        'I will do the shopping if you do the cooking.',
      ),
      VocabEntry(
        'do business / research / harm',
        'carry out an activity',
        'The company has done business here for thirty years.',
      ),
      VocabEntry(
        'take a photo / a break / the bus / a decision',
        'a surprising range of everyday actions',
        'Take a break before you take any decisions.',
      ),
      VocabEntry(
        'take part / place / care',
        'three fixed phrases worth learning together',
        'The meeting took place without him taking part.',
      ),
      VocabEntry(
        'have a look / a go / a word',
        'do something briefly',
        'Can I have a word with you afterwards?',
      ),
      VocabEntry(
        'have trouble / difficulty doing',
        'find something hard — and note the -ing',
        'I had trouble finding the entrance.',
      ),
      VocabEntry(
        'pay attention / a visit / a compliment',
        'pay does more than money',
        'He paid her a compliment and she ignored it.',
      ),
      VocabEntry(
        'keep a promise / a secret / in touch',
        'keep = maintain over time',
        'We said we would keep in touch and, unusually, we did.',
      ),
      VocabEntry(
        'break a promise / the law / the news',
        'the opposite of keep, plus one surprise',
        'Somebody had to break the news to her.',
      ),
      VocabEntry(
        'raise a question / an objection / awareness',
        'bring something up',
        'Her report raised more questions than it answered.',
      ),
    ],
  ),

  // ── Phrasal verbs by particle ─────────────────────────────────────────────
  VocabSet(
    id: 'phrasal',
    name: 'Phrasal verbs, by particle',
    blurb:
        'Grouped by the particle, because the particle carries a meaning of '
        'its own: *up* tends to finish, *off* to separate, *out* to exhaust.',
    entries: [
      VocabEntry(
        'bring up',
        'raise a subject, or raise a child',
        'She brought up the cost, which nobody wanted to discuss.',
      ),
      VocabEntry(
        'come up with',
        'think of an idea or a solution',
        'He came up with a way round it in about a minute.',
      ),
      VocabEntry(
        'give up',
        'stop trying, or stop a habit',
        'I gave up halfway through the second page.',
      ),
      VocabEntry(
        'make up for',
        'compensate for',
        'What it lacks in size it makes up for in charm.',
      ),
      VocabEntry(
        'put up with',
        'tolerate',
        'I could not put up with the noise any longer.',
      ),
      VocabEntry(
        'call off',
        'cancel',
        'The match was called off an hour before kick-off.',
      ),
      VocabEntry(
        'put off',
        'postpone, or discourage',
        'Do not put it off — and do not let the price put you off.',
      ),
      VocabEntry(
        'take off',
        'leave the ground, or become popular',
        'The idea took off faster than anyone expected.',
      ),
      VocabEntry(
        'carry out',
        'perform a task or a study',
        'The survey was carried out over three weeks.',
      ),
      VocabEntry(
        'point out',
        'draw attention to a fact',
        'She pointed out that nobody had read the contract.',
      ),
      VocabEntry(
        'run out of',
        'have none left',
        'We ran out of time before we ran out of questions.',
      ),
      VocabEntry(
        'work out',
        'calculate, solve, or exercise',
        'It took me a while to work out what he meant.',
      ),
      VocabEntry(
        'look into',
        'investigate',
        'The council has promised to look into the complaint.',
      ),
      VocabEntry(
        'get over',
        'recover from',
        'It took her a month to get over the flu.',
      ),
      VocabEntry(
        'go through',
        'experience something hard, or examine in detail',
        'Let us go through the figures once more.',
      ),
      VocabEntry(
        'turn down',
        'refuse, or reduce the volume',
        'He turned down the offer without explaining why.',
      ),
    ],
  ),

  // ── Word families ─────────────────────────────────────────────────────────
  VocabSet(
    id: 'familias',
    name: 'Word families',
    blurb:
        'Part 3 gives you one word and wants another from the same family. '
        'Learn the set, not the word, and work out the part of speech before '
        'you write anything.',
    entries: [
      VocabEntry(
        'ANALYSE',
        'analysis (n) · analytical (adj) · analytically (adv)',
        'Her analysis was the only analytical thing in the room.',
      ),
      VocabEntry(
        'DECIDE',
        'decision (n) · decisive (adj) · decisively (adv) · indecisive',
        'He was decisive for once, and the decision held.',
      ),
      VocabEntry(
        'ECONOMY',
        'economic (about the economy) · economical (cheap to run) · '
            'economically',
        'An economical car is not the same as an economic policy.',
      ),
      VocabEntry(
        'SUCCEED',
        'success (n) · successful (adj) · successfully · unsuccessful',
        'The application was unsuccessful, which is not the same as a '
            'failure.',
      ),
      VocabEntry(
        'RESPOND',
        'response (n) · responsive (adj) · unresponsive · responsible',
        'The response was quick; the department is not usually responsive.',
      ),
      VocabEntry(
        'CONCLUDE',
        'conclusion (n) · conclusive (adj) · inconclusive · conclusively',
        'The evidence was inconclusive, so no conclusion was drawn.',
      ),
      VocabEntry(
        'RELY',
        'reliance (n) · reliable (adj) · unreliable · reliably',
        'He is reliable in a way his brother is not.',
      ),
      VocabEntry(
        'SENSE',
        'sensible (reasonable) · sensitive (easily affected) · sensitivity',
        'A sensible person and a sensitive person are two different people.',
      ),
      VocabEntry(
        'ADVISE',
        'advice (n, uncountable) · adviser (n) · advisable (adj)',
        'It is advisable to take advice before signing.',
      ),
      VocabEntry(
        'STRONG',
        'strength (n) · strengthen (v) · strongly (adv)',
        'The pound strengthened, which is a strange sort of strength.',
      ),
      VocabEntry(
        'ENFORCE',
        'enforcement (n) · enforceable (adj) · unenforceable',
        'Without witnesses the rule is simply unenforceable.',
      ),
      VocabEntry(
        'RECONCILE',
        'reconciliation (n) · reconcilable (adj) · irreconcilable',
        'The two accounts are irreconcilable: both cannot be true.',
      ),
      VocabEntry(
        'LEGAL — the negative prefixes',
        'illegal, immoral, impossible, irregular, inconvenient, unable',
        'il- before l, im- before m and p, ir- before r, in- and un- '
            'elsewhere.',
      ),
    ],
  ),

  // ── Formal and informal ───────────────────────────────────────────────────
  VocabSet(
    id: 'registro',
    name: 'Formal ↔ informal pairs',
    blurb:
        'The same meaning in two registers. Writing is marked on choosing the '
        'right one, and a report full of phrasal verbs loses marks that '
        'nothing else can win back.',
    level: ExamLevel.c1,
    entries: [
      VocabEntry(
        'find out → establish, ascertain',
        'discover a fact',
        'The committee has yet to establish who authorised the payment.',
      ),
      VocabEntry(
        'turn down → reject, decline',
        'say no to',
        'The proposal was rejected at the first reading.',
      ),
      VocabEntry(
        'put off → postpone, defer',
        'move to a later date',
        'The decision has been deferred until March.',
      ),
      VocabEntry(
        'get in touch with → contact',
        'reach someone',
        'Please contact the office directly.',
      ),
      VocabEntry(
        'help → assist, facilitate',
        'make something easier',
        'The grant is intended to facilitate research.',
      ),
      VocabEntry(
        'need → require',
        'have to have',
        'Applicants are required to provide two references.',
      ),
      VocabEntry(
        'ask for → request',
        'say you want something',
        'We requested a copy of the report and heard nothing.',
      ),
      VocabEntry(
        'go up / go down → rise, increase / fall, decline',
        'change in quantity',
        'Attendance has fallen steadily since 2023.',
      ),
      VocabEntry(
        'but → however, nevertheless',
        'the contrast linker, one register up',
        'The costs are high. Nevertheless, the benefits are larger.',
      ),
      VocabEntry(
        'so → therefore, consequently',
        'the consequence linker',
        'The funding ended; consequently the project stopped.',
      ),
      VocabEntry(
        'about → regarding, with reference to',
        'introducing a subject',
        'I am writing with reference to your advertisement.',
      ),
      VocabEntry(
        'a lot of → a great deal of, considerable',
        'a large amount',
        'Considerable time was spent on a question nobody had asked.',
      ),
      VocabEntry(
        'Sorry → I apologise for, I regret',
        'apologising in a letter',
        'I regret that we are unable to refund the full amount.',
      ),
      VocabEntry(
        'Thanks → I should be grateful if, I appreciate',
        'thanking, formally',
        'I should be grateful if you would confirm by Friday.',
      ),
    ],
  ),

  // ── Fixed expressions at C1 ───────────────────────────────────────────────
  VocabSet(
    id: 'expresiones',
    name: 'Fixed expressions',
    blurb:
        'Word for word, or wrong. These are what Part 1 of the Advanced paper '
        'is made of: no rule will get you there, only having met them.',
    level: ExamLevel.c1,
    entries: [
      VocabEntry(
        'by and large',
        'generally, on the whole',
        'By and large, the policy has worked.',
      ),
      VocabEntry(
        'to some extent',
        'partly — a way of conceding',
        'To some extent the criticism is justified.',
      ),
      VocabEntry(
        'in no small part',
        'to a considerable degree, said modestly',
        'The result was due in no small part to her.',
      ),
      VocabEntry(
        'in two minds about',
        'undecided',
        'I am in two minds about accepting.',
      ),
      VocabEntry(
        'take something in your stride',
        'deal with it calmly',
        'She took the criticism in her stride.',
      ),
      VocabEntry(
        'jump the gun',
        'act too early',
        'Let us not jump the gun — the results are not out.',
      ),
      VocabEntry(
        'hold water',
        'stand up to examination (of an argument)',
        'That explanation does not hold water.',
      ),
      VocabEntry(
        'a drop in the ocean',
        'far too little to matter',
        'The donation was a drop in the ocean.',
      ),
      VocabEntry(
        'put something on hold',
        'pause it',
        'The project was put on hold until the funding arrived.',
      ),
      VocabEntry(
        'that said',
        'even so — concedes and then contradicts',
        'The cost is high. That said, the benefits are larger.',
      ),
      VocabEntry(
        'it would appear that',
        'the standard academic hedge',
        'It would appear that the two events are connected.',
      ),
      VocabEntry(
        'may well',
        'there is a good chance — not the same as *may as well*',
        'He may well be waiting outside already.',
      ),
      VocabEntry(
        'given that',
        'since, considering that',
        'Given that nobody objected, the plan went ahead.',
      ),
      VocabEntry(
        'inasmuch as / insofar as',
        'to the extent that',
        'The scheme failed inasmuch as it was never funded.',
      ),
    ],
  ),
];
