/// C1 Advanced practice items.
///
/// C1 is not "B2 but harder vocabulary". What changes is what the paper
/// rewards: at B2 you pick the option that is correct, at C1 you pick the one
/// that is *exact* while two others are merely defensible. So these items
/// lean on the things the Advanced paper actually tests — participle clauses,
/// inversion, hedging, register, and fixed expressions you either know or do
/// not.
///
/// Every explanation says why the other options fail, not only why the answer
/// works. At this level that is the part worth reading.
library;

import 'cambridge.dart';
import 'practice.dart';

final List<Exercise> exercisesC1 = [
  // ── Inversion and emphasis ────────────────────────────────────────────────
  const Exercise(
    id: 'c1-in-1',
    topic: 'inversion',
    level: ExamLevel.c1,
    prompt: 'No sooner ___ the door than the phone rang.',
    options: ['he had closed', 'had he closed', 'he closed', 'did he close'],
    correct: 'had he closed',
    explanation:
        'No sooner takes the past perfect and inverts: “No sooner had he '
        'closed…”. It also takes *than*, never *when* — that pairing is half '
        'the mark in a transformation.',
    hint: 'Two things are fixed here: the tense and the word that follows.',
  ),
  const Exercise(
    id: 'c1-in-2',
    topic: 'inversion',
    level: ExamLevel.c1,
    prompt: 'Only after the meeting ___ what had really been decided.',
    options: [
      'I understood',
      'did I understand',
      'I did understand',
      'had I understood',
    ],
    correct: 'did I understand',
    explanation:
        'Only + a time phrase inverts the clause that follows it, and with no '
        'other auxiliary in play you supply *do*. Past simple gives “did I '
        'understand”; the past perfect would need a second, earlier event to '
        'sit before.',
  ),
  const Exercise(
    id: 'c1-in-3',
    topic: 'inversion',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'Rarely ___ I seen a performance quite like it.',
    correct: 'have',
    explanation:
        'Rarely, seldom, hardly and scarcely all invert. The tense here is '
        'present perfect — a life experience up to now — so the auxiliary is '
        'have, and it moves in front of the subject.',
  ),
  const Exercise(
    id: 'c1-in-4',
    topic: 'inversion',
    level: ExamLevel.c1,
    prompt: '___ I known about the deadline, I would have started earlier.',
    options: ['If', 'Had', 'Should', 'Were'],
    correct: 'Had',
    explanation:
        'A third conditional can drop *if* and invert instead: “Had I known…” '
        'for “If I had known…”. The same trick gives “Were I you…” and '
        '“Should you need anything…”, and Cambridge likes all three because '
        'they are the formal register in one move.',
    hint: 'The sentence is a third conditional with the *if* taken out.',
  ),
  const Exercise(
    id: 'c1-in-5',
    topic: 'inversion',
    level: ExamLevel.c1,
    prompt: '___ was the noise that we had to leave.',
    options: ['So loud', 'Such loud', 'So loudly', 'Such a loud'],
    correct: 'So loud',
    explanation:
        'So + adjective, such + noun phrase. The noun here is *the noise*, '
        'already the subject, so what is fronted is the adjective: “So loud '
        'was the noise…”. “Such was the noise that…” also exists, but “Such '
        'loud was” does not.',
  ),
  const Exercise(
    id: 'c1-in-6',
    topic: 'inversion',
    level: ExamLevel.c1,
    prompt: '___ is my sister who paid for the tickets, not me.',
    options: ['It', 'She', 'That', 'There'],
    correct: 'It',
    explanation:
        'A cleft sentence: “It is X who/that…” puts one element under a '
        'spotlight and pushes everything else into the background. It is the '
        'cleanest way in English to correct someone, and it earns marks in '
        'Writing for exactly that reason.',
  ),

  // ── Nuance and hedging ────────────────────────────────────────────────────
  const Exercise(
    id: 'c1-ma-1',
    topic: 'matiz',
    level: ExamLevel.c1,
    prompt:
        'The results ___ suggest a link, though more work is needed to be '
        'sure.',
    options: ['definitely', 'arguably', 'certainly', 'undoubtedly'],
    correct: 'arguably',
    explanation:
        'The second half of the sentence backs away from certainty, so the '
        'first half cannot claim it. Arguably means "a case can be made"; the '
        'other three close the door that the rest of the sentence is holding '
        'open. Matching the strength of a claim to the evidence is what C1 '
        'calls register.',
    hint: 'Read the clause after the comma first, then pick.',
  ),
  const Exercise(
    id: 'c1-ma-2',
    topic: 'matiz',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'The policy is, ___ large, working well.',
    correct: 'by',
    explanation:
        '“By and large” means generally, on the whole. It is a fixed phrase: '
        'no other preposition works, and there is nothing to work out — you '
        'either have met it or you have not. Part 2 of the Advanced paper is '
        'full of these.',
  ),
  const Exercise(
    id: 'c1-ma-3',
    topic: 'matiz',
    level: ExamLevel.c1,
    prompt: 'It ___ that the two events are connected.',
    options: ['would appear', 'will appear', 'appeared', 'is appearing'],
    correct: 'would appear',
    explanation:
        '“It would appear/seem that…” is the standard academic hedge: it says '
        'the same as “it appears” while leaving you room to be wrong. The '
        'conditional *would* here is not about the future or about a '
        'condition; it is politeness towards the evidence.',
  ),
  const Exercise(
    id: 'c1-ma-4',
    topic: 'matiz',
    level: ExamLevel.c1,
    prompt: 'The delay was due ___ no small part to the weather.',
    options: ['in', 'to', 'for', 'at'],
    correct: 'in',
    explanation:
        '“In no small part” = to a considerable extent, and it is understated '
        'on purpose: a double negative that says "a lot" while sounding '
        'measured. Note the trap — *due to* is right there, and the gap is '
        'not part of it.',
    hint: 'The gap belongs to a phrase of its own, not to “due ___”.',
  ),
  const Exercise(
    id: 'c1-ma-5',
    topic: 'matiz',
    level: ExamLevel.c1,
    prompt: 'I ___ inclined to agree with you on that point.',
    options: ['am rather', 'am very', 'have rather', 'do rather'],
    correct: 'am rather',
    explanation:
        '“I am rather inclined to agree” is agreement with the volume turned '
        'down — common in discussion and in Writing Part 2. *Inclined* is an '
        'adjective here, so it takes *be*, and *rather* softens it where '
        '*very* would defeat the purpose.',
  ),
  const Exercise(
    id: 'c1-ma-6',
    topic: 'matiz',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'To some ___, the criticism is justified.',
    correct: 'extent',
    alternatives: ['degree'],
    explanation:
        '“To some extent” or “to some degree” concedes part of a point before '
        'you argue with the rest. Examiners look for exactly this move in '
        'Writing Part 1, where you are asked to weigh two sides.',
  ),

  // ── Participle and reduced clauses ────────────────────────────────────────
  const Exercise(
    id: 'c1-pa-1',
    topic: 'participio',
    level: ExamLevel.c1,
    prompt: '___ the report, she went straight to bed.',
    options: [
      'Having finished',
      'Having been finished',
      'Finishing',
      'To finish',
    ],
    correct: 'Having finished',
    explanation:
        'Having + past participle says the first action was complete before '
        'the second began. A plain -ing would suggest the two happened at '
        'once, and the passive would make the report the one going to bed.',
    hint: 'Did the two things happen together, or one after the other?',
  ),
  const Exercise(
    id: 'c1-pa-2',
    topic: 'participio',
    level: ExamLevel.c1,
    prompt: '___ in 1823, the building is the oldest in the town.',
    options: ['Built', 'Building', 'Having built', 'It was built'],
    correct: 'Built',
    explanation:
        'A past participle opens a reduced passive clause: “Built in 1823” = '
        '“Which was built in 1823”. The building did not build anything, so '
        'the -ing forms are out.',
  ),
  const Exercise(
    id: 'c1-pa-3',
    topic: 'participio',
    level: ExamLevel.c1,
    prompt: '___ that nobody objected, the plan went ahead.',
    options: ['Given', 'Giving', 'Gave', 'To give'],
    correct: 'Given',
    explanation:
        '“Given that…” means "since" or "considering that" and is fixed in '
        'that form. It belongs to a small set — given, granted, provided, '
        'supposing — where a participle has hardened into a conjunction.',
  ),
  const Exercise(
    id: 'c1-pa-4',
    topic: 'participio',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'Not ___ what to say, he said nothing at all.',
    correct: 'knowing',
    explanation:
        'A negative participle clause puts *not* in front of the -ing: “Not '
        'knowing what to say”. It reads as "because he did not know", and it '
        'costs four words fewer.',
  ),
  const Exercise(
    id: 'c1-pa-5',
    topic: 'participio',
    level: ExamLevel.c1,
    prompt: 'The weather ___ fine, we decided to walk the whole way home.',
    options: ['being', 'was', 'is', 'been'],
    correct: 'being',
    explanation:
        'An absolute clause: the participle keeps its own subject — “The '
        'weather being fine” — instead of borrowing the one from the main '
        'clause. It is formal and it is the kind of structure that lifts a '
        'Writing answer out of the middle band.',
    hint:
        'The two halves have different subjects, so the clause keeps its '
        'own.',
  ),
  const Exercise(
    id: 'c1-pa-6',
    topic: 'participio',
    level: ExamLevel.c1,
    prompt: 'Anyone ___ to take part should sign the list by Friday.',
    options: ['wishing', 'wished', 'wishes', 'who wish'],
    correct: 'wishing',
    explanation:
        'An -ing clause reduces an active relative: “anyone wishing to take '
        'part” = “anyone who wishes to take part”. Notice the register — '
        'this is the phrasing of notices and formal letters, which is where '
        'Writing Part 2 often puts you.',
  ),

  // ── Idioms and fixed expressions ──────────────────────────────────────────
  const Exercise(
    id: 'c1-id-1',
    topic: 'idioms',
    level: ExamLevel.c1,
    prompt: 'The new rules were a ___ in the ocean given the scale of it.',
    options: ['drop', 'splash', 'fall', 'piece'],
    correct: 'drop',
    explanation:
        '“A drop in the ocean” — an amount too small to matter. Idioms are '
        'fixed word for word: the sense of the other options is close and '
        'they are still simply wrong, which is precisely what Part 1 of the '
        'Advanced paper is testing.',
  ),
  const Exercise(
    id: 'c1-id-2',
    topic: 'idioms',
    level: ExamLevel.c1,
    prompt: 'I was ___ two minds about whether to accept the offer.',
    options: ['in', 'on', 'at', 'of'],
    correct: 'in',
    explanation:
        '“In two minds about something” = unable to decide. Worth keeping '
        'beside its neighbours: *on the fence* and *torn between* mean the '
        'same and each takes its own preposition.',
  ),
  const Exercise(
    id: 'c1-id-3',
    topic: 'idioms',
    level: ExamLevel.c1,
    prompt: 'Let us not ___ the gun — the results are not out yet.',
    options: ['jump', 'shoot', 'run', 'beat'],
    correct: 'jump',
    explanation:
        '“Jump the gun” = act before the right moment, from a runner starting '
        'before the starting pistol. Compare “beat about the bush” (avoid the '
        'point) — same shape, entirely different meaning.',
  ),
  const Exercise(
    id: 'c1-id-4',
    topic: 'idioms',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'The project was put on ___ until the funding came through.',
    correct: 'hold',
    explanation:
        '“Put something on hold” = pause it. The pattern *put on* + noun runs '
        'a long way: on hold, on trial, on show, on the map — and the noun '
        'changes the meaning completely each time.',
  ),
  const Exercise(
    id: 'c1-id-5',
    topic: 'idioms',
    level: ExamLevel.c1,
    prompt: 'She took the criticism ___ her stride and carried on.',
    options: ['in', 'on', 'with', 'at'],
    correct: 'in',
    explanation:
        '“Take something in your stride” = deal with it calmly, without '
        'breaking rhythm. Note the possessive: it is always *in his/her/their '
        'stride*, never “in the stride”.',
  ),
  const Exercise(
    id: 'c1-id-6',
    topic: 'idioms',
    level: ExamLevel.c1,
    prompt: 'Their argument does not hold ___ when you look at the figures.',
    options: ['water', 'ground', 'air', 'weight'],
    correct: 'water',
    explanation:
        '“Hold water” = stand up to examination, used of arguments and '
        'theories. *Carry weight* and *gain ground* are real phrases too, but '
        'they mean "be influential" and "become more accepted" — near enough '
        'to be the distractors, far enough to be wrong.',
    hint: 'The phrase is about a container that does not leak.',
  ),

  // ── Register and formality ────────────────────────────────────────────────
  const Exercise(
    id: 'c1-re-1',
    topic: 'registro',
    level: ExamLevel.c1,
    prompt:
        'Formal report: “The committee ___ the proposal at its last meeting.”',
    options: ['turned down', 'rejected', 'said no to', 'knocked back'],
    correct: 'rejected',
    explanation:
        'All four mean the same. A formal report takes the single Latinate '
        'verb; the phrasal verbs belong in speech and in an informal email. '
        'Cambridge marks Writing on register, so choosing the wrong one of '
        'two correct words costs marks.',
  ),
  const Exercise(
    id: 'c1-re-2',
    topic: 'registro',
    level: ExamLevel.c1,
    prompt: 'Informal email to a friend: “___ you can make it on Saturday!”',
    options: [
      'I trust that',
      'It is to be hoped that',
      'Hope',
      'I should be grateful if',
    ],
    correct: 'Hope',
    explanation:
        'Informal English drops the subject pronoun at the start of a line: '
        '“Hope you can make it”, “Sorry about that”, “See you Friday”. The '
        'other three are the register of a formal letter and would read as a '
        'joke to a friend.',
  ),
  const Exercise(
    id: 'c1-re-3',
    topic: 'registro',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt:
        'Formal letter: “I am writing with ___ to your advertisement of 3 '
        'May.”',
    correct: 'reference',
    alternatives: ['regard'],
    explanation:
        '“With reference to” and “with regard to” both open a formal letter. '
        'Note the singular: *with regard to*, not "with regards to" — regards '
        'go at the end of the letter, not the beginning.',
  ),
  const Exercise(
    id: 'c1-re-4',
    topic: 'registro',
    level: ExamLevel.c1,
    prompt: 'Proposal to a manager: “___ that additional staff be recruited.”',
    options: [
      'It is recommended',
      'I reckon',
      'We really need it',
      'Why not say',
    ],
    correct: 'It is recommended',
    explanation:
        'A proposal is impersonal and its recommendations are explicit. Note '
        'what follows: *be recruited*, the subjunctive, which survives in '
        'English almost only after "it is recommended/essential/vital that". '
        'The other three are speech, and in Writing Part 2 they cost you the '
        'register mark.',
  ),
  const Exercise(
    id: 'c1-re-5',
    topic: 'registro',
    level: ExamLevel.c1,
    prompt: 'Review: “What the place lacks in size it ___ for in charm.”',
    options: [
      'more than makes up',
      'makes more up',
      'is more than making up',
      'more than takes up',
    ],
    correct: 'more than makes up',
    explanation:
        'A review is allowed to be lively, and the band descriptors reward '
        'range: this one sentence carries a cleft and a fixed expression. '
        '“Make up for something” is the phrase, and *more than* sits in front '
        'of the whole verb, not inside it.',
    hint: 'The phrase is make up for. Where can “more than” go?',
  ),

  // ── Key word transformations at C1 ────────────────────────────────────────
  const Exercise(
    id: 'c1-tr-1',
    topic: 'transformar',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt:
        '“I am sorry I did not call you.” → He apologised ___ called her. '
        '(NOT)',
    correct: 'for not having',
    alternatives: ['for not'],
    explanation:
        'Apologise takes *for*, a preposition takes -ing, and the call came '
        'before the apology, so the -ing goes perfect: “for not having '
        'called”. *Not* sits in front of the whole -ing form, never inside '
        'it.',
    hint: 'Preposition, then negative, then a form that shows it came first.',
  ),
  const Exercise(
    id: 'c1-tr-2',
    topic: 'transformar',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt:
        '“You should not have told her.” → It ___ better if you had said '
        'nothing. (BEEN)',
    correct: 'would have been',
    explanation:
        'Third conditional in the main clause: would + have + past '
        'participle. The *if* half is already there in the past perfect, so '
        'the gap only has to match it.',
  ),
  const Exercise(
    id: 'c1-tr-3',
    topic: 'transformar',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt:
        '“Nobody expected him to win.” → His victory came ___ surprise to '
        'everyone. (AS)',
    correct: 'as a complete',
    alternatives: ['as a total', 'as a', 'as something of a'],
    explanation:
        '“Come as a surprise to someone” is the fixed frame; an intensifier '
        'between the article and the noun is optional and is what makes the '
        'sentence sound native. Two marks: one for *as a … surprise*, one for '
        'keeping the meaning of "nobody expected".',
  ),
  const Exercise(
    id: 'c1-tr-4',
    topic: 'transformar',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt:
        '“The only thing that matters is the deadline.” → ___ matters is the '
        'deadline. (ALL)',
    correct: 'all that',
    explanation:
        'A cleft with *all*: “All that matters is…”. It is the shortest way '
        'to front the important element, and the transformation key word is '
        'telling you which cleft to build.',
  ),
  const Exercise(
    id: 'c1-tr-5',
    topic: 'transformar',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt:
        '“I would rather you did not smoke here.” → I would prefer ___ smoke '
        'here. (NOT)',
    correct: 'you not to',
    explanation:
        'Would rather takes a clause with a past tense; would prefer takes an '
        'object and an infinitive: “I would prefer you not to smoke”. Two '
        'structures that mean one thing and never share a shape — a Part 4 '
        'favourite.',
    hint: 'Prefer does not take a that-clause here; it takes an object.',
  ),

  // ── Word formation at C1 ──────────────────────────────────────────────────
  const Exercise(
    id: 'c1-fo-1',
    topic: 'formacion',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'The evidence was ___ , so the case collapsed. (CONCLUDE)',
    correct: 'inconclusive',
    explanation:
        'Two changes at once: the suffix -ive makes the adjective and the '
        'prefix in- negates it. Part 3 of the Advanced paper almost always '
        'has at least one item needing both, and candidates who only add the '
        'suffix lose the mark.',
    hint: 'The case collapsed — so the adjective has to be a negative one.',
  ),
  const Exercise(
    id: 'c1-fo-2',
    topic: 'formacion',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'She spoke with great ___ about her years abroad. (FOND)',
    correct: 'fondness',
    explanation:
        '-ness turns an adjective into the noun for its quality. The trap is '
        'that *fondly* is far more common, and an adverb cannot follow '
        '“with great”.',
  ),
  const Exercise(
    id: 'c1-fo-3',
    topic: 'formacion',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'The two accounts are ___ : both cannot be true. (RECONCILE)',
    correct: 'irreconcilable',
    explanation:
        'Three moves: -able for the adjective, the *e* dropped, and *ir-* '
        'before an r for the negative. Which negative prefix you use is '
        'governed by the first letter — il- before l, im- before m and p, '
        'ir- before r, in- elsewhere.',
  ),
  const Exercise(
    id: 'c1-fo-4',
    topic: 'formacion',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'His ___ of the situation turned out to be right. (READ)',
    correct: 'reading',
    explanation:
        'Not every noun needs a Latin suffix. *Reading* here means '
        'interpretation, and Part 3 does test this: the word you are given is '
        'sometimes already the answer with nothing but -ing on it.',
  ),
  const Exercise(
    id: 'c1-fo-5',
    topic: 'formacion',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'Without witnesses the rule is simply ___ . (ENFORCE)',
    correct: 'unenforceable',
    explanation:
        'Three moves in one word: -able for the adjective, the final e '
        'dropped, and un- for the negative. Work out the part of speech '
        'first — the gap follows *is*, so it is an adjective — and then ask '
        'whether the sentence is positive or negative. "Without witnesses" '
        'settles it.',
    hint: 'What part of speech goes after “is simply”, and is it positive?',
  ),

  // ── Linking and cohesion at C1 ────────────────────────────────────────────
  const Exercise(
    id: 'c1-co-1',
    topic: 'conectores',
    level: ExamLevel.c1,
    prompt:
        'The cost is high. ___ , the benefits over ten years are larger '
        'still.',
    options: ['That said', 'Therefore', 'Moreover', 'Namely'],
    correct: 'That said',
    explanation:
        'The second sentence contradicts the weight of the first, so the '
        'linker has to be concessive. *Moreover* would add to the complaint, '
        '*therefore* would draw it as a conclusion, and *namely* introduces a '
        'list. Getting the direction of a linker wrong reverses your '
        'argument.',
    hint: 'Does the second sentence agree with the first or push back?',
  ),
  const Exercise(
    id: 'c1-co-2',
    topic: 'conectores',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'The scheme failed, ___ as it was never properly funded.',
    correct: 'inasmuch',
    alternatives: ['insofar', 'in so far', 'in as much'],
    explanation:
        '“Inasmuch as” and “insofar as” both mean "to the extent that". '
        'Formal, and regulars in Part 6, where you have to work out which '
        'sentence a cross-text reference is pointing at.',
  ),
  const Exercise(
    id: 'c1-co-3',
    topic: 'conectores',
    level: ExamLevel.c1,
    prompt: 'The trial was stopped, ___ leaving the question unanswered.',
    options: ['thereby', 'therefore', 'thus far', 'whereby'],
    correct: 'thereby',
    explanation:
        '*Thereby* + -ing states the consequence of what was just said. '
        '*Therefore* is an adverb and would need a full clause after it, and '
        '*whereby* means "by which" and introduces a relative clause.',
  ),
  const Exercise(
    id: 'c1-co-4',
    topic: 'conectores',
    level: ExamLevel.c1,
    prompt: '___ the difficulties, the team finished on time.',
    options: ['Despite', 'Although', 'However', 'Even'],
    correct: 'Despite',
    explanation:
        'Despite and in spite of take a noun; although takes a clause; '
        'however takes a comma and a new sentence. Three ways to concede, and '
        'what they are followed by decides which you can use.',
  ),

  // ── Speculating at C1 ─────────────────────────────────────────────────────
  const Exercise(
    id: 'c1-es-1',
    topic: 'especular',
    level: ExamLevel.c1,
    prompt: 'She ___ left already — her coat is gone.',
    options: ['must have', 'should have', 'might not have', 'cannot have'],
    correct: 'must have',
    explanation:
        'Must + have + past participle is deduction about the past: the '
        'evidence forces the conclusion. *Cannot have* is the negative of the '
        'same certainty, and *should have* is regret, not deduction.',
  ),
  const Exercise(
    id: 'c1-es-2',
    topic: 'especular',
    level: ExamLevel.c1,
    prompt: 'He ___ be waiting outside — I told him three o\'clock.',
    options: ['may well', 'may as well', 'might just as well', 'had better'],
    correct: 'may well',
    explanation:
        '“May well” = there is a good chance. “May as well” is something '
        'quite different — it suggests doing something for want of a better '
        'option. One word apart, no overlap in meaning.',
    hint: 'One of these is about probability, the rest are about choosing.',
  ),
  const Exercise(
    id: 'c1-es-3',
    topic: 'especular',
    level: ExamLevel.c1,
    type: ExerciseType.write,
    prompt: 'The letter ___ to have been written in a hurry.',
    correct: 'appears',
    alternatives: ['seems'],
    explanation:
        '“Appear/seem to have been + past participle” speculates about the '
        'past at a distance: you are reporting an impression, not a fact. It '
        'is the safest structure in the Listening paper, where the question '
        'often asks what the speaker *suggests* rather than states.',
  ),
];
