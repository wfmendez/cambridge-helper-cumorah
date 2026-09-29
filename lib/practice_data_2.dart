/// The second batch of exercises: the topics added after the first pass.
///
/// Split into its own file purely so neither file becomes unmanageable. The
/// two lists are concatenated in `practice_data.dart`.
///
/// Items tagged `ExamLevel.c1` only surface once C1 is the chosen goal.
library;

import 'cambridge.dart';
import 'practice.dart';

final List<Exercise> exercisesExtra = [
  // ── Conditionals and wishes ───────────────────────────────────────────────
  const Exercise(
    id: 'co-1',
    topic: 'condicionales',
    prompt: 'If I ___ you, I would take the job.',
    options: ['am', 'was', 'were', 'would be'],
    correct: 'were',
    explanation:
        'The second conditional talks about an unreal present, and with the '
        'verb “be” English uses “were” for every person. “If I was you” is '
        'heard in speech but marked wrong in the exam.',
  ),
  const Exercise(
    id: 'co-2',
    topic: 'condicionales',
    prompt: 'If she ___ earlier, she would not have missed the train.',
    options: ['left', 'had left', 'would leave', 'has left'],
    correct: 'had left',
    explanation:
        'Third conditional: an unreal past. The pattern is if + past perfect, '
        'then would have + past participle. Both halves have to move back.',
    hint: 'Did this happen, or is it a regret about something that did not?',
  ),
  const Exercise(
    id: 'co-3',
    topic: 'condicionales',
    prompt: 'I wish I ___ how to drive — it would make this so much easier.',
    options: ['know', 'knew', 'had known', 'would know'],
    correct: 'knew',
    explanation:
        'A present regret takes wish + past simple. Use the past perfect '
        '(“I wish I had known”) only when you are regretting the past itself.',
  ),
  const Exercise(
    id: 'co-4',
    topic: 'condicionales',
    prompt: 'If I had studied medicine, I ___ a doctor now.',
    options: ['would be', 'would have been', 'will be', 'was'],
    correct: 'would be',
    explanation:
        'A mixed conditional: past condition, present result. The “if” half is '
        'third conditional, the result half is second. “Now” is the giveaway.',
    hint: 'When is the condition, and when is the result?',
  ),
  const Exercise(
    id: 'co-5',
    topic: 'condicionales',
    prompt: 'I wish you ___ making that noise.',
    options: ['stop', 'stopped', 'would stop', 'had stopped'],
    correct: 'would stop',
    explanation:
        'Wish + would is for complaining about somebody else’s behaviour that '
        'you want changed. It does not work about yourself: you cannot say '
        '“I wish I would stop”.',
  ),

  // ── Reported speech ───────────────────────────────────────────────────────
  const Exercise(
    id: 'rp-1',
    topic: 'reportado',
    prompt: 'She said she ___ finished the report.',
    options: ['has', 'had', 'have', 'was'],
    correct: 'had',
    explanation:
        'Reporting in the past shifts the tense back one step: present perfect '
        'becomes past perfect. “Has” would only survive if the reporting verb '
        'were present (“she says she has finished”).',
  ),
  const Exercise(
    id: 'rp-2',
    topic: 'reportado',
    prompt: 'He ___ me to wait outside.',
    options: ['said', 'told', 'asked to', 'spoke'],
    correct: 'told',
    explanation:
        'Tell takes a person straight after it: tell someone to do something. '
        'Say does not — it is “he said that…” with no object. This pair is '
        'tested constantly.',
    hint: 'Which of the two can be followed directly by “me”?',
  ),
  const Exercise(
    id: 'rp-3',
    topic: 'reportado',
    prompt: 'She ___ having taken the money.',
    options: ['denied', 'refused', 'rejected', 'declined'],
    correct: 'denied',
    explanation:
        'Deny means saying you did not do something, and takes -ing. Refuse '
        'means saying you will not do something, and takes to + infinitive. '
        'They are not interchangeable.',
  ),
  const Exercise(
    id: 'rp-4',
    topic: 'reportado',
    prompt: 'He ___ on paying for dinner.',
    options: ['insisted', 'suggested', 'offered', 'promised'],
    correct: 'insisted',
    explanation:
        'Insist takes “on” plus -ing. Suggest would take -ing with no '
        'preposition; offer and promise take to + infinitive. Reporting verbs '
        'are worth learning with their pattern attached.',
  ),

  // ── Relative clauses ──────────────────────────────────────────────────────
  const Exercise(
    id: 're-1',
    topic: 'relativas',
    prompt: 'The woman ___ car was stolen called the police.',
    options: ['who', 'whose', 'which', 'that'],
    correct: 'whose',
    explanation:
        'Whose shows possession, and it works for people and for things. The '
        'car belongs to the woman, so “whose” is the only option that links '
        'them.',
  ),
  const Exercise(
    id: 're-2',
    topic: 'relativas',
    prompt: 'My brother, ___ lives in Berlin, is visiting next week.',
    options: ['who', 'that', 'which', 'whom'],
    correct: 'who',
    explanation:
        'After a comma the clause is non-defining — extra information — and '
        '“that” is never allowed there. It has to be who for a person, which '
        'for a thing.',
    hint: 'What does the comma tell you about the clause?',
  ),
  const Exercise(
    id: 're-3',
    topic: 'relativas',
    prompt: 'The hotel ___ we stayed had no hot water.',
    options: ['which', 'where', 'that', 'what'],
    correct: 'where',
    explanation:
        '“Where” replaces “in which”. You could also write “which we stayed '
        'in”, but not “which we stayed” — the preposition cannot just vanish.',
  ),
  const Exercise(
    id: 're-4',
    topic: 'relativas',
    prompt: 'He failed the exam, ___ surprised everyone.',
    options: ['which', 'what', 'that', 'who'],
    correct: 'which',
    explanation:
        'Here “which” refers to the whole previous clause, not to a single '
        'noun. English uses which for that, never what — a very common B2 '
        'mistake.',
  ),

  // ── Modals ────────────────────────────────────────────────────────────────
  const Exercise(
    id: 'mo-1',
    topic: 'modales',
    prompt: 'You ___ have told me — I would have helped.',
    options: ['should', 'must', 'could have', 'might'],
    correct: 'should',
    explanation:
        'Should have + past participle is criticism or regret about something '
        'that did not happen. “Must have” would mean you are deducing that it '
        'did happen, which is the opposite.',
  ),
  const Exercise(
    id: 'mo-2',
    topic: 'modales',
    prompt: 'You ___ take an umbrella; it is not going to rain.',
    options: ['must not', 'do not have to', 'should not', 'cannot'],
    correct: 'do not have to',
    explanation:
        'Absence of obligation is “do not have to”. “Must not” is prohibition '
        '— it would mean taking an umbrella is forbidden, which is not the '
        'idea here. This pair catches almost everyone.',
    hint: 'Is it forbidden, or just unnecessary?',
  ),
  const Exercise(
    id: 'mo-3',
    topic: 'modales',
    prompt: 'She ___ have left already; her coat is still here.',
    options: ['must', 'cannot', 'should', 'might not'],
    correct: 'cannot',
    explanation:
        'The coat is evidence against, so this is a confident negative '
        'deduction: can’t have + past participle. English never uses “mustn’t '
        'have” for this.',
  ),
  const Exercise(
    id: 'mo-4',
    topic: 'modales',
    prompt: 'When I was a child I ___ swim for hours without getting tired.',
    options: ['could', 'was able to', 'managed to', 'can'],
    correct: 'could',
    explanation:
        'For a general ability in the past, use could. “Was able to” and '
        '“managed to” are for one specific occasion where you succeeded at '
        'something difficult.',
  ),

  // ── Prepositions and articles ─────────────────────────────────────────────
  const Exercise(
    id: 'pr-1',
    topic: 'preposiciones',
    type: ExerciseType.write,
    prompt: 'She is very good ___ explaining difficult ideas.',
    correct: 'at',
    explanation:
        'Good, bad, brilliant and hopeless all take “at”, and a preposition is '
        'always followed by -ing. Adjective plus preposition pairs are worth '
        'learning as single units.',
  ),
  const Exercise(
    id: 'pr-2',
    topic: 'preposiciones',
    type: ExerciseType.write,
    prompt: 'It depends ___ how much it costs.',
    correct: 'on',
    alternatives: ['upon'],
    explanation:
        'Depend always takes “on” in English, even though many languages use '
        'the equivalent of “of”. Part 2 of Use of English is full of exactly '
        'this kind of gap.',
  ),
  const Exercise(
    id: 'pr-3',
    topic: 'preposiciones',
    type: ExerciseType.write,
    prompt: 'In spite ___ the rain, the match went ahead.',
    correct: 'of',
    explanation:
        '“In spite of” is a three-word unit and the “of” is not optional. Note '
        'that “despite” means the same but takes no preposition at all.',
  ),
  const Exercise(
    id: 'pr-4',
    topic: 'preposiciones',
    type: ExerciseType.write,
    prompt: 'This is ___ far the best coffee in Prague.',
    correct: 'by',
    explanation:
        '“By far” is a fixed phrase that intensifies a superlative. These '
        'set phrases are what Part 2 tests: no grammar rule generates them, '
        'you either know them or you do not.',
  ),
  const Exercise(
    id: 'pr-5',
    topic: 'preposiciones',
    type: ExerciseType.write,
    prompt: 'I have been living here ___ 2019.',
    correct: 'since',
    explanation:
        'Since marks a starting point; for marks a length of time. “Since '
        '2019” and “for six years” can describe the same span, but they are '
        'not interchangeable in the sentence.',
  ),

  // ── Phrasal verbs ─────────────────────────────────────────────────────────
  const Exercise(
    id: 'ph-1',
    topic: 'phrasal',
    prompt: 'I need to ___ this word in the dictionary.',
    options: ['look up', 'look after', 'look into', 'look for'],
    correct: 'look up',
    explanation:
        'Look up means to search for information in a reference source. Look '
        'after is to take care of, look into is to investigate, and look for '
        'is to search for something lost.',
  ),
  const Exercise(
    id: 'ph-2',
    topic: 'phrasal',
    prompt: 'The meeting was ___ until next Monday.',
    options: ['put off', 'put up', 'put out', 'put down'],
    correct: 'put off',
    explanation:
        'Put off means to postpone. Put up with means to tolerate, put out '
        'means to extinguish, and put down means to write or to criticise. '
        'One verb, four unrelated meanings.',
  ),
  const Exercise(
    id: 'ph-3',
    topic: 'phrasal',
    prompt: 'I cannot ___ his constant complaining any more.',
    options: ['put up with', 'put up', 'get on with', 'take up'],
    correct: 'put up with',
    explanation:
        'A three-part phrasal verb meaning to tolerate. The whole thing moves '
        'as a block: you cannot split it, and dropping the “with” changes the '
        'meaning entirely.',
  ),
  const Exercise(
    id: 'ph-4',
    topic: 'phrasal',
    prompt: 'She ___ smoking three years ago.',
    options: ['gave up', 'gave in', 'gave away', 'gave out'],
    correct: 'gave up',
    explanation:
        'Give up is to stop a habit, and it takes -ing. Give in is to '
        'surrender, give away is to donate, give out is to distribute or to '
        'run out.',
  ),
  const Exercise(
    id: 'ph-5',
    topic: 'phrasal',
    prompt: 'How are you ___ with your new flatmates?',
    options: ['getting on', 'getting up', 'getting over', 'getting by'],
    correct: 'getting on',
    explanation:
        'Get on with someone is to have a good relationship with them. Get '
        'over is to recover from something, and get by is to manage with '
        'barely enough.',
  ),

  // ── Collocations ──────────────────────────────────────────────────────────
  const Exercise(
    id: 'cl-1',
    topic: 'colocaciones',
    prompt: 'It is time to ___ a decision.',
    options: ['make', 'do', 'take', 'have'],
    correct: 'make',
    explanation:
        'Make a decision, not take one. Roughly: you make things that did not '
        'exist before — a decision, a mistake, progress — and you do tasks and '
        'activities.',
  ),
  const Exercise(
    id: 'cl-2',
    topic: 'colocaciones',
    prompt: 'Could you ___ me a favour?',
    options: ['do', 'make', 'give', 'take'],
    correct: 'do',
    explanation:
        'Do a favour, do the washing-up, do your homework, do business. It is '
        'the exception that proves how unreliable the “make = create” rule is: '
        'a favour feels created, but the verb is do.',
  ),
  const Exercise(
    id: 'cl-3',
    topic: 'colocaciones',
    prompt: 'The company ___ a record profit last year.',
    options: ['made', 'did', 'took', 'got'],
    correct: 'made',
    explanation:
        'Make a profit, make money, make a loss. Business English leans on '
        '“make” for anything produced as a result.',
  ),
  const Exercise(
    id: 'cl-4',
    topic: 'colocaciones',
    prompt: 'I need to ___ a break.',
    options: ['take', 'make', 'do', 'have'],
    correct: 'take',
    alternatives: ['have'],
    explanation:
        'Take a break and have a break are both correct and common. Make a '
        'break means something else entirely — to escape. Some collocations '
        'genuinely allow two verbs.',
  ),
  const Exercise(
    id: 'cl-5',
    topic: 'colocaciones',
    prompt: 'The new rules ___ into effect next month.',
    options: ['come', 'go', 'get', 'take'],
    correct: 'come',
    explanation:
        'Come into effect, come into force, come to a decision. Fixed phrases '
        'like this are exactly what Part 1 of Use of English is testing, and '
        'the other three verbs are all plausible-sounding traps.',
  ),

  // ── Linking and cohesion ──────────────────────────────────────────────────
  const Exercise(
    id: 'ln-1',
    topic: 'conectores',
    prompt: 'The plan is expensive. ___, it is the only one that would work.',
    options: ['However', 'Although', 'Despite', 'Whereas'],
    correct: 'However',
    explanation:
        'After a full stop you need a linker that can open a sentence alone. '
        'Although and whereas join clauses inside one sentence; despite takes '
        'a noun or -ing.',
  ),
  const Exercise(
    id: 'ln-2',
    topic: 'conectores',
    prompt: 'He had no experience. ___, they gave him the job.',
    options: ['Nevertheless', 'Moreover', 'Therefore', 'Similarly'],
    correct: 'Nevertheless',
    explanation:
        'The second fact contradicts what the first would lead you to expect, '
        'so you need a concession. Therefore would signal a consequence, '
        'moreover an addition — both point the wrong way.',
    hint: 'Does the second sentence agree with the first, or push against it?',
  ),
  const Exercise(
    id: 'ln-3',
    topic: 'conectores',
    type: ExerciseType.write,
    prompt: 'She left early ___ order to catch the last train.',
    correct: 'in',
    explanation:
        '“In order to” expresses purpose. You could also write just “to catch”, '
        'but the gap here needs the fixed phrase completing.',
  ),
  const Exercise(
    id: 'ln-4',
    topic: 'conectores',
    prompt: '___ the delay, everyone arrived in good spirits.',
    options: ['Despite', 'Although', 'However', 'Because of'],
    correct: 'Despite',
    explanation:
        'Despite takes a noun phrase (“the delay”). Although would need a '
        'clause with a verb. Because of would reverse the logic of the '
        'sentence.',
  ),

  // ── Inversion and emphasis · C1 ───────────────────────────────────────────
  const Exercise(
    id: 'in-1',
    topic: 'inversion',
    level: ExamLevel.c1,
    prompt: 'Never before ___ such a beautiful sunset.',
    options: ['I had seen', 'had I seen', 'I saw', 'did I saw'],
    correct: 'had I seen',
    explanation:
        'When a negative adverbial opens the sentence — never, rarely, seldom, '
        'little — the subject and auxiliary swap places, exactly as in a '
        'question. This is standard C1 material and almost absent from B2.',
    hint: 'What happens to the word order after a negative opener?',
  ),
  const Exercise(
    id: 'in-2',
    topic: 'inversion',
    level: ExamLevel.c1,
    prompt: 'Not only ___ the exam, he got the highest mark in the class.',
    options: ['he passed', 'did he pass', 'he did pass', 'passed he'],
    correct: 'did he pass',
    explanation:
        'Not only triggers inversion, and because “pass” has no auxiliary of '
        'its own you have to supply “did”. The second half usually continues '
        'with “but also”.',
  ),
  const Exercise(
    id: 'in-3',
    topic: 'inversion',
    level: ExamLevel.c1,
    prompt: 'No sooner ___ the door than the phone rang.',
    options: [
      'had she closed',
      'she had closed',
      'did she close',
      'she closed',
    ],
    correct: 'had she closed',
    explanation:
        'No sooner… than is a fixed pair and takes the past perfect with '
        'inversion. Watch the second half: it is “than”, not “when”, which is '
        'where most people lose the mark.',
  ),
  const Exercise(
    id: 'in-4',
    topic: 'inversion',
    level: ExamLevel.c1,
    prompt: 'It ___ her support that got me through it.',
    options: ['was', 'is', 'had', 'has been'],
    correct: 'was',
    explanation:
        'A cleft sentence: It was X that… It pulls one element to the front '
        'for emphasis. At C1 these show up in Part 4 transformations '
        'constantly.',
  ),

  // ── Nuance and hedging · C1 ───────────────────────────────────────────────
  const Exercise(
    id: 'nu-1',
    topic: 'matiz',
    level: ExamLevel.c1,
    prompt: 'The results ___ suggest that the method works.',
    options: ['would appear to', 'appear', 'are appearing to', 'appears to'],
    correct: 'would appear to',
    explanation:
        '“Would appear to” is careful academic hedging: it claims less than '
        '“appear to”, which in turn claims less than stating it flatly. This '
        'graded distance is a large part of what C1 Writing rewards.',
  ),
  const Exercise(
    id: 'nu-2',
    topic: 'matiz',
    level: ExamLevel.c1,
    prompt: 'There is a ___ that the data was misread.',
    options: [
      'slight possibility',
      'small possible',
      'little possibility',
      'few possibility',
    ],
    correct: 'slight possibility',
    explanation:
        'Slight collocates with possibility, chance, doubt and difference. '
        '“Little possibility” exists but means almost none, which is a '
        'different claim.',
  ),
  const Exercise(
    id: 'nu-3',
    topic: 'matiz',
    level: ExamLevel.c1,
    prompt: 'His argument is ___ flawed, though not entirely without merit.',
    options: ['somewhat', 'somehow', 'somewhere', 'someway'],
    correct: 'somewhat',
    explanation:
        'Somewhat softens an adjective: somewhat flawed, somewhat unusual. '
        'Somehow means “in some way I cannot explain” and is not a softener at '
        'all — a very frequent confusion.',
  ),
  const Exercise(
    id: 'nu-4',
    topic: 'matiz',
    level: ExamLevel.c1,
    type: ExerciseType.transformation,
    prompt:
        'People say the painting is worth millions.\n'
        'SAID\n'
        'The painting ___ worth millions.',
    correct: 'is said to be',
    explanation:
        'The impersonal passive: it distances you from the claim. Cambridge '
        'tests this shape repeatedly at C1 — is thought to, is believed to, is '
        'alleged to.',
  ),

  // ── More transformations, B2 and C1 ───────────────────────────────────────
  const Exercise(
    id: 'kw-5',
    topic: 'transformar',
    type: ExerciseType.transformation,
    prompt:
        'They started building the bridge two years ago.\n'
        'BEEN\n'
        'The bridge ___ for two years.',
    correct: 'has been under construction',
    alternatives: ['has been being built'],
    explanation:
        'An action begun in the past and still going takes the present '
        'perfect. “For two years” forces the perfect rather than the past '
        'simple.',
  ),
  const Exercise(
    id: 'kw-6',
    topic: 'transformar',
    type: ExerciseType.transformation,
    prompt:
        'It is not necessary for you to come early.\n'
        'HAVE\n'
        'You ___ come early.',
    correct: 'do not have to',
    alternatives: ["don't have to"],
    explanation:
        'Absence of obligation is “do not have to”. Writing “must not” would '
        'reverse the meaning into a prohibition, and score zero even though '
        'the grammar is fine.',
  ),
  const Exercise(
    id: 'kw-7',
    topic: 'transformar',
    type: ExerciseType.transformation,
    prompt:
        'I have never eaten such good pasta.\n'
        'BEST\n'
        'This is ___ ever eaten.',
    correct: 'the best pasta I have',
    alternatives: ["the best pasta I've"],
    explanation:
        'Superlative plus present perfect with “ever”. Note the relative '
        'pronoun is dropped: “the best pasta (that) I have ever eaten”.',
  ),
  const Exercise(
    id: 'kw-8',
    topic: 'transformar',
    level: ExamLevel.c1,
    type: ExerciseType.transformation,
    prompt:
        'The moment she arrived, the argument stopped.\n'
        'SOONER\n'
        'No ___ than the argument stopped.',
    correct: 'sooner had she arrived',
    explanation:
        'No sooner… than, with inversion and the past perfect. Three to six '
        'words at C1, and the key word cannot change: “sooner” stays.',
  ),

  // ── More word formation ───────────────────────────────────────────────────
  const Exercise(
    id: 'wf-5',
    topic: 'formacion',
    type: ExerciseType.write,
    prompt: 'The government has been criticised for its ___.  (ACT)',
    correct: 'inaction',
    explanation:
        'Two steps and a negative prefix: act → action → inaction. The word '
        '“criticised” signals that the gap must be negative.',
    hint: 'Does the sentence need a positive or a negative word?',
  ),
  const Exercise(
    id: 'wf-6',
    topic: 'formacion',
    type: ExerciseType.write,
    prompt: 'She spoke with great ___ about the project.  (ENTHUSIASTIC)',
    correct: 'enthusiasm',
    explanation:
        'After “great” you need a noun, so the adjective has to go backwards: '
        'enthusiastic → enthusiasm. Part 3 often gives you the adjective and '
        'wants the noun.',
  ),
  const Exercise(
    id: 'wf-7',
    topic: 'formacion',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'The proposal was rejected on the grounds of ___.  (PRACTICAL)',
    correct: 'impracticality',
    explanation:
        'Three steps: practical → impractical → impracticality. C1 word '
        'formation routinely stacks a prefix and a suffix on the same stem.',
  ),
  const Exercise(
    id: 'wf-8',
    topic: 'formacion',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'Her ___ to detail is what makes the work stand out.  (ATTEND)',
    correct: 'attention',
    explanation:
        'Attend → attention, and the fixed phrase is “attention to detail”. '
        'Spotting the collocation is faster here than working the morphology.',
  ),
];
