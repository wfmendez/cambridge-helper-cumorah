/// B1 Preliminary practice items.
///
/// Written separately because B1 is not "easier B2": it tests a different and
/// narrower set of things. The tenses are the basic ones, the vocabulary is
/// everyday, and the questions reward recognising a pattern rather than
/// weighing two near-synonyms.
///
/// Anyone aiming at B2 or C1 sees these too — they are the foundation, and it
/// is worth knowing they are solid.
library;

import 'cambridge.dart';
import 'practice.dart';

final List<Exercise> exercisesB1 = [
  // ── Present perfect ───────────────────────────────────────────────────────
  const Exercise(
    id: 'b1-pp-1',
    topic: 'perfect',
    level: ExamLevel.b1,
    prompt: 'I ___ never been to Italy.',
    options: ['have', 'has', 'am', 'did'],
    correct: 'have',
    explanation:
        'The present perfect is have/has + past participle, and with “I” it is '
        'always “have”. “Never been” is about life experience up to now, which '
        'is what this tense is for.',
  ),
  const Exercise(
    id: 'b1-pp-2',
    topic: 'perfect',
    level: ExamLevel.b1,
    prompt: 'She has lived here ___ 2020.',
    options: ['since', 'for', 'from', 'during'],
    correct: 'since',
    explanation:
        'Since marks the point where something started; for marks how long it '
        'has lasted. “Since 2020” and “for five years” can describe the same '
        'thing, but the words are not interchangeable.',
    hint: 'Is 2020 a starting point or a length of time?',
  ),
  const Exercise(
    id: 'b1-pp-3',
    topic: 'perfect',
    level: ExamLevel.b1,
    prompt: 'Have you finished your homework ___?',
    options: ['yet', 'still', 'already', 'ever'],
    correct: 'yet',
    explanation:
        '“Yet” goes at the end of questions and negatives. “Already” goes in '
        'positive sentences, and “still” goes before the verb. This trio is '
        'tested in almost every B1 paper.',
  ),

  // ── Comparatives ──────────────────────────────────────────────────────────
  const Exercise(
    id: 'b1-cs-1',
    topic: 'comparativos',
    level: ExamLevel.b1,
    prompt: 'My sister is ___ than me.',
    options: ['taller', 'tallest', 'more tall', 'the taller'],
    correct: 'taller',
    explanation:
        'Short adjectives add -er for the comparative. “Than” always follows a '
        'comparative, never a superlative.',
  ),
  const Exercise(
    id: 'b1-cs-2',
    topic: 'comparativos',
    level: ExamLevel.b1,
    prompt: 'This is ___ restaurant in town.',
    options: ['the best', 'the better', 'best', 'better'],
    correct: 'the best',
    explanation:
        'Good is irregular: good → better → the best. And a superlative always '
        'takes “the”.',
  ),
  const Exercise(
    id: 'b1-cs-3',
    topic: 'comparativos',
    level: ExamLevel.b1,
    prompt: 'The film was not ___ interesting as the book.',
    options: ['as', 'so much', 'more', 'than'],
    correct: 'as',
    explanation:
        'The pattern is as + adjective + as, and it stays the same in the '
        'negative: not as interesting as.',
  ),

  // ── Gerunds and infinitives ───────────────────────────────────────────────
  const Exercise(
    id: 'b1-gi-1',
    topic: 'gerundios',
    level: ExamLevel.b1,
    prompt: 'I want ___ a doctor.',
    options: ['being', 'to be', 'be', 'to being'],
    correct: 'to be',
    explanation:
        'Want always takes to + infinitive. The same group includes need, '
        'would like, hope and decide.',
  ),
  const Exercise(
    id: 'b1-gi-2',
    topic: 'gerundios',
    level: ExamLevel.b1,
    prompt: 'She finished ___ the dishes ten minutes ago.',
    options: ['to wash', 'washing', 'wash', 'washed'],
    correct: 'washing',
    explanation:
        'Finish takes -ing, like enjoy, avoid, mind and practise. The easiest '
        'way to learn these is in a short list you can recite.',
  ),

  // ── Modals ────────────────────────────────────────────────────────────────
  const Exercise(
    id: 'b1-mo-1',
    topic: 'modales',
    level: ExamLevel.b1,
    prompt: 'You ___ wear a helmet on this building site.',
    options: ['must', 'can', 'might', 'would'],
    correct: 'must',
    explanation:
        'Must is a strong obligation, usually a rule. Have to means much the '
        'same, but must tends to come from the speaker and have to from an '
        'outside rule.',
  ),
  const Exercise(
    id: 'b1-mo-2',
    topic: 'modales',
    level: ExamLevel.b1,
    prompt: '___ I open the window?',
    options: ['Shall', 'Will', 'Do', 'Am'],
    correct: 'Shall',
    explanation:
        '“Shall I…?” offers to do something or asks whether you should. It is '
        'one of the few places where shall is still common in everyday '
        'English.',
  ),

  // ── Prepositions ──────────────────────────────────────────────────────────
  const Exercise(
    id: 'b1-pr-1',
    topic: 'preposiciones',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'The meeting is ___ Monday morning.',
    correct: 'on',
    explanation:
        'On for days and dates, in for months and years, at for clock times. '
        '“On Monday morning” takes on because the day wins over the part of '
        'the day.',
  ),
  const Exercise(
    id: 'b1-pr-2',
    topic: 'preposiciones',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'I am interested ___ learning Czech.',
    correct: 'in',
    explanation:
        'Interested always takes “in”, and a preposition is followed by -ing, '
        'never by an infinitive.',
  ),
  const Exercise(
    id: 'b1-pr-3',
    topic: 'preposiciones',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'She is very good ___ maths.',
    correct: 'at',
    explanation:
        'Good at, bad at, terrible at. Learn the adjective and its preposition '
        'as one unit and you stop guessing.',
  ),

  // ── Phrasal verbs ─────────────────────────────────────────────────────────
  const Exercise(
    id: 'b1-ph-1',
    topic: 'phrasal',
    level: ExamLevel.b1,
    prompt: 'What time do you usually ___ in the morning?',
    options: ['get up', 'get on', 'get over', 'get in'],
    correct: 'get up',
    explanation:
        'Get up is to leave your bed. Get on is to make progress or to board '
        'something, get over is to recover, and get in is to arrive.',
  ),
  const Exercise(
    id: 'b1-ph-2',
    topic: 'phrasal',
    level: ExamLevel.b1,
    prompt: 'Please ___ the television, I am trying to study.',
    options: ['turn off', 'turn on', 'turn up', 'turn into'],
    correct: 'turn off',
    explanation:
        'Turn off stops a device; turn on starts it; turn up increases the '
        'volume. Note you can also say “turn the television off”: this one '
        'splits.',
  ),

  // ── Collocations ──────────────────────────────────────────────────────────
  const Exercise(
    id: 'b1-cl-1',
    topic: 'colocaciones',
    level: ExamLevel.b1,
    prompt: 'I have to ___ my homework before dinner.',
    options: ['do', 'make', 'take', 'have'],
    correct: 'do',
    explanation:
        'Do your homework, do the washing-up, do the shopping. Roughly: do for '
        'tasks and chores, make for things you produce.',
  ),
  const Exercise(
    id: 'b1-cl-2',
    topic: 'colocaciones',
    level: ExamLevel.b1,
    prompt: 'Can I ___ a photo of you?',
    options: ['take', 'make', 'do', 'get'],
    correct: 'take',
    explanation:
        'Take a photo, take a break, take a shower, take the bus. English uses '
        'take for a surprising number of everyday actions.',
  ),

  // ── Conditionals ──────────────────────────────────────────────────────────
  const Exercise(
    id: 'b1-co-1',
    topic: 'condicionales',
    level: ExamLevel.b1,
    prompt: 'If it ___ tomorrow, we will stay at home.',
    options: ['rains', 'will rain', 'rained', 'is raining'],
    correct: 'rains',
    explanation:
        'First conditional: if + present simple, then will + infinitive. The '
        '“if” half never takes will, however future the meaning is.',
    hint: 'Which half of the sentence is allowed to carry “will”?',
  ),
  const Exercise(
    id: 'b1-co-2',
    topic: 'condicionales',
    level: ExamLevel.b1,
    prompt: 'If I had more money, I ___ a new bike.',
    options: ['will buy', 'would buy', 'buy', 'bought'],
    correct: 'would buy',
    explanation:
        'Second conditional, for something imaginary: if + past simple, then '
        'would + infinitive.',
  ),

  // ── Passive ───────────────────────────────────────────────────────────────
  const Exercise(
    id: 'b1-pa-1',
    topic: 'passive',
    level: ExamLevel.b1,
    prompt: 'This cake ___ by my grandmother.',
    options: ['made', 'was made', 'is making', 'has making'],
    correct: 'was made',
    explanation:
        'The cake did not make anything — it received the action. Past simple '
        'passive is was/were + past participle.',
  ),

  // ── Relative clauses ──────────────────────────────────────────────────────
  const Exercise(
    id: 'b1-re-1',
    topic: 'relativas',
    level: ExamLevel.b1,
    prompt: 'That is the man ___ helped me yesterday.',
    options: ['who', 'which', 'where', 'whose'],
    correct: 'who',
    explanation:
        'Who for people, which for things, where for places. “That” would also '
        'work here, but who is the safer choice for a person.',
  ),
];
