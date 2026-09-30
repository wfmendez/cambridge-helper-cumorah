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
  const Exercise(
    id: 'b1-pp-4',
    topic: 'perfect',
    level: ExamLevel.b1,
    prompt: 'We ___ to the new shopping centre last Saturday.',
    options: ['went', 'have gone', 'have been', 'go'],
    correct: 'went',
    explanation:
        '“Last Saturday” is finished, and a finished time takes the past '
        'simple. The present perfect only works when the time reaches up '
        'to now — this week, ever, or no time at all. This is the most '
        'common tense mistake at B1.',
    hint: 'Is last Saturday over, or does it reach up to now?',
  ),
  const Exercise(
    id: 'b1-pp-5',
    topic: 'perfect',
    level: ExamLevel.b1,
    prompt: 'Has your brother ever ___ a horse?',
    options: ['ridden', 'rode', 'ride', 'riding'],
    correct: 'ridden',
    explanation:
        'After has or have comes the past participle: ride, rode, ridden. '
        '“Ever” in a question means at any time in your life, which is '
        'why the sentence uses the present perfect.',
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
  const Exercise(
    id: 'b1-cs-4',
    topic: 'comparativos',
    level: ExamLevel.b1,
    prompt: 'Today is ___ day of the year so far.',
    options: ['the hottest', 'the hotter', 'hottest', 'more hot'],
    correct: 'the hottest',
    explanation:
        'A superlative needs “the”. Short adjectives that end consonant, '
        'vowel, consonant double the last letter: hot, hotter, the '
        'hottest — and big, bigger, the biggest.',
  ),
  const Exercise(
    id: 'b1-cs-5',
    topic: 'comparativos',
    level: ExamLevel.b1,
    prompt: 'My new phone is much ___ than my old one.',
    options: ['better', 'more good', 'best', 'gooder'],
    correct: 'better',
    explanation:
        'Good is irregular: good, better, the best — “more good” and '
        '“gooder” do not exist. Much before a comparative makes the '
        'difference bigger: much better, much cheaper.',
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
  const Exercise(
    id: 'b1-gi-3',
    topic: 'gerundios',
    level: ExamLevel.b1,
    prompt: 'I enjoy ___ to music on the bus.',
    options: ['listening', 'to listen', 'listen', 'listened'],
    correct: 'listening',
    explanation:
        'Enjoy is always followed by -ing, never by to. Finish, mind and '
        'suggest work the same way — they are worth learning as a group.',
  ),
  const Exercise(
    id: 'b1-gi-4',
    topic: 'gerundios',
    level: ExamLevel.b1,
    prompt: 'We decided ___ a taxi because it was raining.',
    options: ['to take', 'taking', 'take', 'took'],
    correct: 'to take',
    explanation:
        'Decide, want, hope, plan and promise take to + infinitive. They '
        'point forward, to something that has not happened yet.',
  ),
  const Exercise(
    id: 'b1-gi-5',
    topic: 'gerundios',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'Thank you for ___ me with my project. (help)',
    correct: 'helping',
    explanation:
        'After a preposition — for, of, about, without — a verb always '
        'takes -ing. So it is “thank you for helping”, never “for help” '
        'or “for to help”.',
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
  const Exercise(
    id: 'b1-mo-3',
    topic: 'modales',
    level: ExamLevel.b1,
    prompt: 'You ___ bring food — there will be plenty at the party.',
    options: ['don\'t have to', 'mustn\'t', 'can\'t', 'couldn\'t'],
    correct: 'don\'t have to',
    explanation:
        'Don\'t have to means it is not necessary; mustn\'t means it is not '
        'allowed. Bringing food would be fine, just not needed — so don\'t '
        'have to.',
    hint: 'Is bringing food forbidden, or just unnecessary?',
  ),
  const Exercise(
    id: 'b1-mo-4',
    topic: 'modales',
    level: ExamLevel.b1,
    prompt: 'You ___ use your phone during the exam. It is against the rules.',
    options: ['mustn\'t', 'don\'t have to', 'needn\'t', 'wouldn\'t'],
    correct: 'mustn\'t',
    explanation:
        'Mustn\'t means something is forbidden. Don\'t have to and needn\'t '
        'only say it is not necessary — the opposite idea, and a pair '
        'Cambridge likes to test.',
  ),
  const Exercise(
    id: 'b1-mo-5',
    topic: 'modales',
    level: ExamLevel.b1,
    prompt: 'You look tired. You ___ go to bed earlier.',
    options: ['should', 'would', 'ought', 'are'],
    correct: 'should',
    explanation:
        'Should + infinitive gives advice. Ought means the same but needs '
        '“to” — ought to go — and would is for imagined situations, not '
        'advice.',
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
  const Exercise(
    id: 'b1-pr-4',
    topic: 'preposiciones',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'My birthday is ___ July.',
    correct: 'in',
    explanation:
        'In for months, years and seasons: in July, in 2025, in winter. '
        'On is for days and dates: on 5 July, on Friday.',
  ),
  const Exercise(
    id: 'b1-pr-5',
    topic: 'preposiciones',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'We arrived ___ Prague late at night.',
    correct: 'in',
    explanation:
        'Arrive in a city or a country, arrive at a building or a smaller '
        'place: arrive in Prague, arrive at the airport. It is never '
        '“arrive to”.',
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
  const Exercise(
    id: 'b1-ph-3',
    topic: 'phrasal',
    level: ExamLevel.b1,
    prompt: 'Can you ___ my cat while I\'m on holiday?',
    options: ['look after', 'look for', 'look up', 'look at'],
    correct: 'look after',
    explanation:
        'Look after means take care of. Look for means search, and look '
        'up means find information — in a dictionary, for example.',
  ),
  const Exercise(
    id: 'b1-ph-4',
    topic: 'phrasal',
    level: ExamLevel.b1,
    prompt: 'The plane ___ at seven in the morning.',
    options: ['took off', 'took after', 'took up', 'took out'],
    correct: 'took off',
    explanation:
        'Take off is what a plane does when it leaves the ground. Take '
        'after means look like a parent, and take up means start a hobby.',
  ),
  const Exercise(
    id: 'b1-ph-5',
    topic: 'phrasal',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'Please fill ___ this form and give it to the receptionist.',
    correct: 'in',
    alternatives: ['out'],
    explanation:
        'Fill in a form in British English, fill out in American English: '
        'both mean complete it with your information. Both are accepted '
        'here.',
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
  const Exercise(
    id: 'b1-cl-3',
    topic: 'colocaciones',
    level: ExamLevel.b1,
    prompt: 'Please don\'t ___ any noise — the baby is sleeping.',
    options: ['make', 'do', 'take', 'have'],
    correct: 'make',
    explanation:
        'Make a noise, make a mistake, make a phone call. Do goes with '
        'work and tasks: do your homework, do the shopping.',
  ),
  const Exercise(
    id: 'b1-cl-4',
    topic: 'colocaciones',
    level: ExamLevel.b1,
    prompt: 'Could you ___ me a favour?',
    options: ['do', 'make', 'take', 'give'],
    correct: 'do',
    explanation:
        'Do someone a favour is a fixed phrase — you never make a favour. '
        'It is one of the do expressions worth learning whole.',
  ),
  const Exercise(
    id: 'b1-cl-5',
    topic: 'colocaciones',
    level: ExamLevel.b1,
    prompt: 'We ___ a great time at the party.',
    options: ['had', 'made', 'did', 'took'],
    correct: 'had',
    explanation:
        'Have a good time, have fun, have a party: English uses have for '
        'experiences. Make fun of means laugh at someone unkindly — a '
        'very different thing.',
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
  const Exercise(
    id: 'b1-co-3',
    topic: 'condicionales',
    level: ExamLevel.b1,
    prompt: 'If you heat ice, it ___.',
    options: ['melts', 'melted', 'would melt', 'melting'],
    correct: 'melts',
    explanation:
        'For things that are always true — facts, rules of science — both '
        'halves take the present simple. This is the zero conditional.',
  ),
  const Exercise(
    id: 'b1-co-4',
    topic: 'condicionales',
    level: ExamLevel.b1,
    prompt: 'I would call her if I ___ her number.',
    options: ['knew', 'know', 'would know', 'will know'],
    correct: 'knew',
    explanation:
        'Second conditional: if + past simple. The past tense here does '
        'not mean the past — it means “not real”. I don\'t know her '
        'number, so: if I knew it.',
  ),
  const Exercise(
    id: 'b1-co-5',
    topic: 'condicionales',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'If I ___ you, I would study a little every day.',
    correct: 'were',
    alternatives: ['was'],
    explanation:
        'For advice, English says “If I were you”. “If I was you” is '
        'common in speech and is accepted, but were is the form exams '
        'expect.',
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
  const Exercise(
    id: 'b1-pa-2',
    topic: 'passive',
    level: ExamLevel.b1,
    prompt: 'English ___ in many countries around the world.',
    options: ['is spoken', 'speaks', 'is speaking', 'spoke'],
    correct: 'is spoken',
    explanation:
        'People speak English; English does not speak anything. When the '
        'subject receives the action, use the passive: am, is or are + '
        'past participle.',
  ),
  const Exercise(
    id: 'b1-pa-3',
    topic: 'passive',
    level: ExamLevel.b1,
    prompt: 'The windows ___ every Friday.',
    options: ['are cleaned', 'is cleaned', 'clean', 'are cleaning'],
    correct: 'are cleaned',
    explanation:
        'Windows is plural, so are; and the windows do not clean anything '
        '— someone cleans them. Present simple passive: are + cleaned.',
  ),
  const Exercise(
    id: 'b1-pa-4',
    topic: 'passive',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'My bike was ___ last night. (steal)',
    correct: 'stolen',
    explanation:
        'The passive needs the past participle: steal, stole, stolen. '
        'Irregular participles are where most B1 passive mistakes happen.',
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
  const Exercise(
    id: 'b1-re-2',
    topic: 'relativas',
    level: ExamLevel.b1,
    prompt: 'This is the town ___ I was born.',
    options: ['where', 'which', 'who', 'what'],
    correct: 'where',
    explanation:
        'Where is for places, when it means “in which”. “The town which I '
        'was born” is missing its preposition — it would need “in” at the '
        'end.',
  ),
  const Exercise(
    id: 'b1-re-3',
    topic: 'relativas',
    level: ExamLevel.b1,
    prompt: 'I have a friend ___ brother plays for a football team.',
    options: ['whose', 'who', 'who\'s', 'which'],
    correct: 'whose',
    explanation:
        'Whose shows that something belongs to someone: her brother, his '
        'brother. Who\'s sounds the same but means who is.',
  ),
  const Exercise(
    id: 'b1-re-4',
    topic: 'relativas',
    level: ExamLevel.b1,
    prompt: 'The book ___ you lent me was really exciting.',
    options: ['that', 'who', 'where', 'what'],
    correct: 'that',
    explanation:
        'Which or that for things. Here you could even leave it out — '
        '“the book you lent me” — because the book is the object. What '
        'can never follow a noun like this.',
  ),

  // ── Past simple and continuous ───────────────────────────────────────
  const Exercise(
    id: 'b1-ps-1',
    topic: 'pasado',
    level: ExamLevel.b1,
    prompt: 'I ___ a shower when the phone rang.',
    options: ['was having', 'had', 'have', 'am having'],
    correct: 'was having',
    explanation:
        'The past continuous — was or were + -ing — is the longer action '
        'that was already in progress. The past simple, rang, is the '
        'short action that interrupts it.',
    hint: 'Which action was already happening?',
  ),
  const Exercise(
    id: 'b1-ps-2',
    topic: 'pasado',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'What ___ you do last weekend?',
    correct: 'did',
    explanation:
        'Questions in the past simple use did + the base verb. The main '
        'verb goes back to its base form — do, not did — because did '
        'already shows the past.',
  ),
  const Exercise(
    id: 'b1-ps-3',
    topic: 'pasado',
    level: ExamLevel.b1,
    prompt: 'When I was a child, I ___ climb trees every summer.',
    options: ['used to', 'use to', 'was used to', 'am used to'],
    correct: 'used to',
    explanation:
        'Used to + infinitive is for past habits that have stopped. In '
        'positive sentences it is always used, with a d. Be used to means '
        'something else: being familiar with something.',
  ),
  const Exercise(
    id: 'b1-ps-4',
    topic: 'pasado',
    level: ExamLevel.b1,
    prompt: 'While we ___ dinner, the lights suddenly went out.',
    options: ['were eating', 'ate', 'eat', 'are eating'],
    correct: 'were eating',
    explanation:
        'While usually introduces the longer background action, so it '
        'goes with the past continuous. We is plural: were, not was.',
  ),
  const Exercise(
    id: 'b1-ps-5',
    topic: 'pasado',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'I ___ the end of the film because I fell asleep. (not see)',
    correct: 'didn\'t see',
    alternatives: ['did not see'],
    explanation:
        'The negative of the past simple is didn\'t + base verb: didn\'t '
        'see, never didn\'t saw. Did already carries the past.',
  ),

  // ── Future forms ─────────────────────────────────────────────────────
  const Exercise(
    id: 'b1-fu-1',
    topic: 'futuro',
    level: ExamLevel.b1,
    prompt: 'Look at those black clouds! It ___ rain.',
    options: ['is going to', 'will', 'rains', 'is raining'],
    correct: 'is going to',
    explanation:
        'Going to is for predictions based on something you can see now — '
        'the clouds. Will is for predictions from opinion: “I think it '
        'will rain tomorrow.”',
  ),
  const Exercise(
    id: 'b1-fu-2',
    topic: 'futuro',
    level: ExamLevel.b1,
    prompt:
        'I ___ my grandparents this Sunday — we have already booked the train.',
    options: ['am visiting', 'visit', 'visited', 'have visited'],
    correct: 'am visiting',
    explanation:
        'The present continuous is for fixed arrangements: the time is '
        'set and something is booked. It is the most natural way to talk '
        'about what is already in your diary.',
  ),
  const Exercise(
    id: 'b1-fu-3',
    topic: 'futuro',
    level: ExamLevel.b1,
    prompt: 'The phone is ringing. Don\'t worry, I ___ get it.',
    options: ['will', 'am going to', 'get', 'am getting'],
    correct: 'will',
    explanation:
        'A decision made at the moment of speaking takes will: the phone '
        'rings and you decide there and then. Going to is for plans made '
        'before.',
  ),
  const Exercise(
    id: 'b1-fu-4',
    topic: 'futuro',
    level: ExamLevel.b1,
    prompt: 'When I ___ home, I will call you.',
    options: ['get', 'will get', 'am going to get', 'got'],
    correct: 'get',
    explanation:
        'After when, as soon as, before and after, English uses the '
        'present simple for the future — just like the if-half of a first '
        'conditional.',
    hint: 'This half starts with when. What does the if-half of a conditional take?',
  ),
  const Exercise(
    id: 'b1-fu-5',
    topic: 'futuro',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'We are going ___ have a party for Ana\'s birthday.',
    correct: 'to',
    explanation:
        'Going to + infinitive: the to never disappears in writing. '
        '“Gonna” is only how it sounds in fast speech.',
  ),

  // ── Quantifiers ──────────────────────────────────────────────────────
  const Exercise(
    id: 'b1-qu-1',
    topic: 'cuantificadores',
    level: ExamLevel.b1,
    prompt: 'How ___ money do you need for the trip?',
    options: ['much', 'many', 'a lot', 'few'],
    correct: 'much',
    explanation:
        'Much with uncountable nouns — money, time, water; many with '
        'countable plurals — euros, days. So how much money, but how many '
        'euros.',
  ),
  const Exercise(
    id: 'b1-qu-2',
    topic: 'cuantificadores',
    level: ExamLevel.b1,
    prompt: 'There aren\'t ___ eggs left — can you buy some?',
    options: ['any', 'some', 'no', 'much'],
    correct: 'any',
    explanation:
        'Any in negatives and most questions, some in positive sentences. '
        '“Aren\'t no” would be a double negative, and much is for '
        'uncountable nouns.',
  ),
  const Exercise(
    id: 'b1-qu-3',
    topic: 'cuantificadores',
    level: ExamLevel.b1,
    prompt: 'I only have ___ time before my bus leaves, so let\'s be quick.',
    options: ['a little', 'a few', 'many', 'few'],
    correct: 'a little',
    explanation:
        'A little with uncountable nouns, a few with countable plurals. '
        'Time is uncountable here: a little time — but a few minutes.',
  ),
  const Exercise(
    id: 'b1-qu-4',
    topic: 'cuantificadores',
    level: ExamLevel.b1,
    prompt: 'Very ___ people came to the meeting, so we cancelled it.',
    options: ['few', 'a few', 'little', 'much'],
    correct: 'few',
    explanation:
        'Few, without a, means not many — a negative idea, which is why '
        'the meeting was cancelled. A few means some, and sounds '
        'positive.',
  ),
  const Exercise(
    id: 'b1-qu-5',
    topic: 'cuantificadores',
    level: ExamLevel.b1,
    type: ExerciseType.write,
    prompt: 'Would you like ___ tea?',
    correct: 'some',
    alternatives: ['more'],
    explanation:
        'Offers and requests take some, even though they are questions: '
        'Would you like some tea? Can I have some water? “More” is also '
        'accepted here.',
  ),
];
