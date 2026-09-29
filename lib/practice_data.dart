/// The exercises. Written here, not copied from a workbook: they can be
/// repeated without using up the paper, and each one explains why.
///
/// The topics come from what is being covered in class — Progress Check 1, the
/// grammar units and Speaking Part 2 — and from the real exam format.
///
/// The quotes in the text are typographic (“ ”) on purpose: that way no string
/// needs double quotes in Dart and the analyser stays quiet.
library;

import 'practice.dart';
import 'practice_data_2.dart';
import 'practice_data_b1.dart';
import 'practice_data_c1.dart';

final List<Exercise> exercises = [
  ...exercisesB1,
  ...exercisesExtra,
  ...exercisesC1,
  // ── Present perfect: simple vs continuous ──────────────────────────────────
  const Exercise(
    id: 'pp-1',
    topic: 'perfect',
    prompt: 'I ___ English for three years, but I still make mistakes.',
    options: ['have studied', 'have been studying', 'am studying', 'studied'],
    correct: 'have been studying',
    explanation:
        'The continuous stresses the activity going on over time, not a '
        'finished result. With “for three years” and an unfinished situation, '
        '“have been studying” is the natural choice. “Have studied” would '
        'point at a completed achievement instead.',
    hint: 'Is the focus on the process or on the result?',
  ),
  const Exercise(
    id: 'pp-2',
    topic: 'perfect',
    prompt: 'She ___ three emails this morning and she is not done yet.',
    options: ['has written', 'has been writing', 'wrote', 'was writing'],
    correct: 'has written',
    explanation:
        'When you count the result —three emails— you need the simple. The '
        'continuous does not go with a finished quantity: you say “she has '
        'been writing emails”, but “she has written three emails”.',
    hint: 'Can you count what was produced?',
  ),
  const Exercise(
    id: 'pp-3',
    topic: 'perfect',
    prompt: 'Your hands are filthy! What ___?',
    options: [
      'have you done',
      'have you been doing',
      'did you do',
      'are you doing',
    ],
    correct: 'have you been doing',
    explanation:
        'The dirty hands are present evidence of a recent activity, and you '
        'are asking about the activity itself, not about a result. That is '
        'exactly what the present perfect continuous is for.',
  ),

  // ── Passive voice ─────────────────────────────────────────────────────────
  const Exercise(
    id: 'pa-1',
    topic: 'passive',
    prompt: 'The results ___ next Monday.',
    options: [
      'will announce',
      'will be announced',
      'are announcing',
      'have announced',
    ],
    correct: 'will be announced',
    explanation:
        'The results do not announce anything — somebody announces them. When '
        'the subject receives the action you need “be” + past participle: '
        'will be announced.',
    hint: 'Does the subject do the action, or receive it?',
  ),
  const Exercise(
    id: 'pa-2',
    topic: 'passive',
    prompt: 'This bridge ___ in 1890 by a Czech engineer.',
    options: ['built', 'was built', 'has built', 'was building'],
    correct: 'was built',
    explanation:
        'A finished action at a stated past time takes the past simple '
        'passive: was/were + past participle. Note that “by a Czech engineer” '
        'is optional — the passive is often used precisely to leave the agent '
        'out.',
  ),
  const Exercise(
    id: 'pa-3',
    topic: 'passive',
    prompt: 'I hate ___ when I am speaking.',
    options: [
      'interrupting',
      'being interrupted',
      'to interrupt',
      'be interrupted',
    ],
    correct: 'being interrupted',
    explanation:
        'After “hate” you need an -ing form, and here you are on the receiving '
        'end, so it has to be passive: being + past participle.',
  ),

  // ── Comparatives and superlatives ─────────────────────────────────────────
  const Exercise(
    id: 'cs-1',
    topic: 'comparativos',
    prompt: 'Prague is ___ city I have ever lived in.',
    options: [
      'the most beautiful',
      'the beautifulest',
      'more beautiful',
      'most beautiful',
    ],
    correct: 'the most beautiful',
    explanation:
        'Adjectives of three or more syllables form the superlative with “the '
        'most”, never with -est. And the article “the” is not optional in a '
        'superlative.',
  ),
  const Exercise(
    id: 'cs-2',
    topic: 'comparativos',
    prompt: 'This exam was ___ than I expected.',
    options: ['more easy', 'easier', 'the easiest', 'as easy'],
    correct: 'easier',
    explanation:
        'Two-syllable adjectives ending in -y drop the y and take -ier: easy → '
        'easier, happy → happier. “More easy” is a very common mistake at B2.',
  ),
  const Exercise(
    id: 'cs-3',
    topic: 'comparativos',
    prompt: 'My new flat is not ___ my old one.',
    options: ['as big as', 'so big than', 'bigger as', 'as big than'],
    correct: 'as big as',
    explanation:
        'The structure for equality is as + adjective + as, and it stays the '
        'same in the negative. “Than” only appears with comparatives '
        '(bigger than), never with “as”.',
  ),
  const Exercise(
    id: 'cs-4',
    topic: 'comparativos',
    prompt: 'The ___ you practise, the ___ you get.',
    options: ['more / better', 'most / best', 'more / best', 'much / better'],
    correct: 'more / better',
    explanation:
        'The double comparative “the more… the better…” links two things that '
        'change together. Both halves take comparatives, not superlatives.',
  ),

  // ── Gerunds and infinitives ───────────────────────────────────────────────
  const Exercise(
    id: 'gi-1',
    topic: 'gerundios',
    prompt: 'I really enjoy ___ early in the morning.',
    options: ['to run', 'running', 'run', 'to running'],
    correct: 'running',
    explanation:
        'Enjoy is always followed by -ing. The group that behaves like this is '
        'worth memorising: enjoy, avoid, mind, suggest, finish, practise, '
        'consider, imagine.',
  ),
  const Exercise(
    id: 'gi-2',
    topic: 'gerundios',
    prompt: 'She decided ___ the job offer.',
    options: ['accepting', 'to accept', 'accept', 'to accepting'],
    correct: 'to accept',
    explanation:
        'Decide takes the infinitive with “to”. Same family: agree, hope, '
        'promise, refuse, manage, offer, afford.',
  ),
  const Exercise(
    id: 'gi-3',
    topic: 'gerundios',
    prompt: 'I stopped ___ coffee because it kept me awake.',
    options: ['to drink', 'drinking', 'drink', 'to drinking'],
    correct: 'drinking',
    explanation:
        'This is the classic trap. “Stop doing” = you quit the habit. “Stop to '
        'do” = you interrupt what you were doing in order to do something '
        'else. Here the habit ended, so it is -ing.',
    hint: 'Did he quit the habit, or pause to do something?',
  ),
  const Exercise(
    id: 'gi-4',
    topic: 'gerundios',
    prompt: 'Remember ___ the door when you leave.',
    options: ['locking', 'to lock', 'lock', 'locked'],
    correct: 'to lock',
    explanation:
        '“Remember to do” points forward: do not forget about a future task. '
        '“Remember doing” points back: you have a memory of it. The same split '
        'applies to forget and regret.',
  ),

  // ── used to / be used to / get used to ────────────────────────────────────
  const Exercise(
    id: 'ut-1',
    topic: 'usedto',
    prompt: 'I ___ live in Caracas, but I moved away years ago.',
    options: ['used to', 'am used to', 'got used to', 'use to'],
    correct: 'used to',
    explanation:
        '“Used to + infinitive” describes a past habit or state that is no '
        'longer true. It has no present form: for present habits you just use '
        'the present simple.',
  ),
  const Exercise(
    id: 'ut-2',
    topic: 'usedto',
    prompt: 'After a month in Prague I ___ the cold.',
    options: ['used to', 'am used to', 'got used to', 'was used to'],
    correct: 'got used to',
    explanation:
        '“Get used to” is the process of becoming accustomed — it describes '
        'the change itself. “Be used to” is the finished state. The month is '
        'what made the change happen, so “got used to” fits.',
    hint: 'Is this the change, or the state after the change?',
  ),
  const Exercise(
    id: 'ut-3',
    topic: 'usedto',
    prompt: 'I am used to ___ up early; it does not bother me any more.',
    options: ['get', 'getting', 'to get', 'got'],
    correct: 'getting',
    explanation:
        'In “be used to” and “get used to”, the word “to” is a preposition, '
        'not part of an infinitive — so it is followed by -ing. This is the '
        'single most common mistake with these three structures.',
  ),

  // ── Speculating ───────────────────────────────────────────────────────────
  const Exercise(
    id: 'sp-1',
    topic: 'especular',
    prompt: 'She is wearing a gown and a hat — she ___ at a graduation.',
    options: ['must be', 'can’t be', 'might not be', 'must have been'],
    correct: 'must be',
    explanation:
        'When the evidence points strongly to one conclusion, English uses '
        '“must be” — not “must to be” and not “should be”. For the opposite, '
        'when something is clearly impossible, you use “can’t be”.',
  ),
  const Exercise(
    id: 'sp-2',
    topic: 'especular',
    prompt: 'It looks ___ they are having an argument.',
    options: ['as though', 'like that', 'as if that', 'that'],
    correct: 'as though',
    explanation:
        '“It looks as though / as if” + a full clause. You can also say “It '
        'looks like they are…” in informal English, but “as though” is safer '
        'in the exam and reads better in Speaking Part 2.',
  ),
  const Exercise(
    id: 'sp-3',
    topic: 'especular',
    prompt: 'They ___ be twins — they look nothing alike.',
    options: ['can’t', 'mustn’t', 'do not must', 'may not'],
    correct: 'can’t',
    alternatives: ['cant', 'cannot'],
    explanation:
        'For a confident negative deduction English uses “can’t”, never '
        '“mustn’t”. “Mustn’t” means prohibition, which is a completely '
        'different idea.',
  ),

  // ── Comparing and contrasting (Speaking Part 2) ───────────────────────────
  const Exercise(
    id: 'ct-1',
    topic: 'contrastar',
    prompt: 'Tennis is competitive, ___ an exercise class is more relaxed.',
    options: ['whereas', 'however', 'despite', 'in spite of'],
    correct: 'whereas',
    explanation:
        '“Whereas” joins two contrasting clauses inside one sentence. '
        '“However” needs its own sentence or a semicolon; “despite” and “in '
        'spite of” are followed by a noun or -ing, not a clause.',
  ),
  const Exercise(
    id: 'ct-2',
    topic: 'contrastar',
    prompt: '___ the rain, we went for a walk.',
    options: ['Despite', 'Although', 'However', 'Whereas'],
    correct: 'Despite',
    explanation:
        '“Despite” and “in spite of” take a noun (the rain) or an -ing form. '
        'If you wanted “although”, you would need a full clause: “Although it '
        'was raining, we went for a walk.”',
    hint: 'What follows: a noun or a full clause?',
  ),
  const Exercise(
    id: 'ct-3',
    topic: 'contrastar',
    prompt: 'Both photos show people outdoors. ___, the first one is at night.',
    options: ['On the other hand', 'Whereas', 'Despite', 'Even though'],
    correct: 'On the other hand',
    explanation:
        'After a full stop you need a linker that can open a sentence on its '
        'own. “On the other hand” does that; “whereas” cannot start an '
        'independent sentence in careful writing.',
  ),

  // ── Key word transformations (Part 4) ─────────────────────────────────────
  const Exercise(
    id: 'kw-1',
    topic: 'transformar',
    type: ExerciseType.transformation,
    prompt:
        '“I am sorry I broke your window,” said Tom.\n'
        'APOLOGISED\n'
        'Tom ___ my window.',
    correct: 'apologised for breaking',
    alternatives: ['apologized for breaking'],
    explanation:
        'Apologise takes “for” and the preposition forces an -ing form. Two to '
        'five words including the key word, and the key word never changes: '
        'apologised for breaking.',
    hint: 'Which preposition goes with “apologise”?',
  ),
  const Exercise(
    id: 'kw-2',
    topic: 'transformar',
    type: ExerciseType.transformation,
    prompt:
        'It is a pity I did not study harder.\n'
        'WISH\n'
        'I ___ harder.',
    correct: 'wish I had studied',
    explanation:
        'Regret about the past uses “wish + past perfect”. Present regret '
        'would be “wish + past simple” (I wish I studied harder), which is a '
        'different meaning.',
  ),
  const Exercise(
    id: 'kw-3',
    topic: 'transformar',
    type: ExerciseType.transformation,
    prompt:
        'Somebody stole my bike last night.\n'
        'WAS\n'
        'My bike ___ last night.',
    correct: 'was stolen',
    explanation:
        'Turning it around makes the bike the subject, so you need the past '
        'simple passive. You do not need “by somebody” — the passive exists '
        'precisely so you can drop an unknown agent.',
  ),
  const Exercise(
    id: 'kw-4',
    topic: 'transformar',
    type: ExerciseType.transformation,
    prompt:
        'I have not seen her since Monday.\n'
        'LAST\n'
        'The ___ was on Monday.',
    correct: 'last time I saw her',
    explanation:
        '“Since Monday” becomes a noun phrase built on “the last time”. Watch '
        'the tense: inside the clause you switch to the past simple, saw.',
  ),

  // ── Word formation (Part 3) ───────────────────────────────────────────────
  const Exercise(
    id: 'wf-1',
    topic: 'formacion',
    type: ExerciseType.write,
    prompt: 'Her ___ of the problem was very clear.  (EXPLAIN)',
    correct: 'explanation',
    explanation:
        'After a possessive like “her” you need a noun. Explain → explanation, '
        'and note the spelling change: the -ai- disappears.',
    hint: 'A noun has to follow “her”.',
  ),
  const Exercise(
    id: 'wf-2',
    topic: 'formacion',
    type: ExerciseType.write,
    prompt: 'The instructions were completely ___.  (USE)',
    correct: 'useless',
    explanation:
        'The context — “completely” plus a negative idea — calls for the '
        'suffix -less, meaning “without”. If the sentence had been positive '
        'you would have needed “useful”.',
  ),
  const Exercise(
    id: 'wf-3',
    topic: 'formacion',
    type: ExerciseType.write,
    prompt: 'It is ___ to swim here when the current is strong.  (DANGER)',
    correct: 'dangerous',
    explanation:
        'After “it is” you need an adjective. Danger → dangerous. Part 3 '
        'almost always hinges on spotting which word class the gap needs '
        'before you even think about meaning.',
  ),
  const Exercise(
    id: 'wf-4',
    topic: 'formacion',
    type: ExerciseType.write,
    prompt: 'He behaved very ___ during the interview.  (PROFESSION)',
    correct: 'professionally',
    explanation:
        'The gap modifies the verb “behaved”, so it needs an adverb: '
        'profession → professional → professionally. Two steps, which is '
        'typical of the harder items in this part.',
  ),
];
