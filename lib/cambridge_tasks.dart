/// What each exam task type is, with a worked example.
///
/// This exists because Cambridge's instructions are full of terms nobody
/// translates — *cloze*, *gapped text*, *multiple matching* — and you cannot
/// train properly for a task whose name you do not understand. Each card says
/// what it is, what it really tests, a worked example, and what changes at C1.
///
/// The examples are written here, not copied from the booklets.
library;

class TaskType {
  const TaskType({
    required this.id,
    required this.name,
    required this.where,
    required this.whatItIs,
    required this.whatItTests,
    required this.example,
    required this.respuesta,
    required this.why,
    this.trick,
    this.atC1,
  });

  final String id;
  final String name;

  /// Which paper and part it appears in.
  final String where;

  final String whatItIs;
  final String whatItTests;

  /// A short example, with the gap marked.
  final String example;
  final String respuesta;

  /// Why that is the answer.
  final String why;

  /// The shortcut that saves time or avoids the usual mistake.
  final String? trick;

  /// What changes at C1 Advanced compared with B2 First.
  final String? atC1;
}

const List<TaskType> taskTypes = [
  // ── Reading and Use of English ────────────────────────────────────────────
  TaskType(
    id: 'mc-cloze',
    name: 'Multiple-choice cloze',
    where: 'Reading and Use of English, Part 1',
    whatItIs:
        'A text with eight gaps. For each gap you pick one of four words. '
        'A “cloze” is simply a text with words taken out — the word comes from '
        '“closure”, because you close the gaps.',
    whatItTests:
        'Vocabulary, and specifically the company words keep: '
        'collocations (“make a decision”, not “do a decision”), fixed phrases '
        'and phrasal verbs. All four options usually mean roughly the same '
        'thing; only one fits this exact slot.',
    example:
        'She finally ___ a decision about the job.\n'
        'A did   B made   C took   D gave',
    respuesta: 'B — made',
    why:
        'All four verbs are common, and in other languages you might '
        '“take” a decision. In English the fixed pair is make a decision. '
        'Nothing in the grammar rules the others out; it is pure collocation.',
    trick:
        'If two options look equally right, read the words on both sides of '
        'the gap, not just the sentence. The answer is usually decided by the '
        'word immediately before or after.',
    atC1: 'Same shape, harder words, and the options are closer in meaning.',
  ),
  TaskType(
    id: 'open-cloze',
    name: 'Open cloze',
    where: 'Reading and Use of English, Part 2',
    whatItIs:
        'The same idea as Part 1, but with no options: you write the '
        'missing word yourself. One word per gap, always.',
    whatItTests:
        'Grammar, not vocabulary. The answers are almost always small '
        'function words: prepositions, articles, auxiliaries, pronouns, '
        'relatives, or a word inside a fixed phrase.',
    example: 'It was such a good film ___ we watched it twice.',
    respuesta: 'that',
    why:
        'The pattern is such a + adjective + noun + that + result. Once '
        'you spot “such”, the second half is forced.',
    trick:
        'If you find yourself wanting to write a noun or a full verb, you '
        'are probably wrong. Think small: of, to, been, it, which, had.',
    atC1:
        'Same eight gaps, but more of them sit inside idiomatic phrases '
        'rather than plain grammar.',
  ),
  TaskType(
    id: 'word-formation',
    name: 'Word formation',
    where: 'Reading and Use of English, Part 3',
    whatItIs:
        'A text with eight gaps. Next to each line there is a word in '
        'CAPITALS, and you change it so it fits the gap: add a prefix, add a '
        'suffix, or both.',
    whatItTests:
        'Whether you can move a word between its noun, verb, adjective '
        'and adverb forms — and whether you notice when the meaning has to '
        'turn negative.',
    example: 'His answer was completely ___.   (EXPECT)',
    respuesta: 'unexpected',
    why:
        'After “was” you need an adjective, so expect → expected. And '
        '“completely” plus the sense of the sentence calls for the negative, '
        'so the prefix un- goes on: unexpected. Two steps, which is typical.',
    trick:
        'Decide the word class before the meaning. Ask: does this gap need '
        'a noun, a verb, an adjective or an adverb? That alone cuts the '
        'possibilities to one or two.',
    atC1:
        'More gaps need two changes at once, and internal spelling shifts '
        'are common (strong → strength, deep → depth).',
  ),
  TaskType(
    id: 'transformation',
    name: 'Key word transformation',
    where: 'Reading and Use of English, Part 4',
    whatItIs:
        'You get a sentence, a word in CAPITALS, and a second sentence '
        'with a gap. You rewrite the first sentence so it means the same, and '
        'the capitalised word must appear in your answer, unchanged.',
    whatItTests:
        'Grammar and vocabulary at once: passives, reported speech, '
        'conditionals, wishes, phrasal verbs and the patterns verbs take.',
    example:
        '“I am sorry I shouted at you,” said Ben.\n'
        'APOLOGISED\n'
        'Ben ___ at me.',
    respuesta: 'apologised for shouting',
    why:
        'Apologise takes “for”, and a preposition is always followed by '
        '-ing. The key word cannot change form: “apologise” would be wrong '
        'because the sentence is in the past.',
    trick:
        'This is the best-paid part of the paper: each item is worth two '
        'marks, split into two halves that are marked separately. Half a '
        'right answer still scores, so never leave one blank.',
    atC1:
        'Three to six words instead of two to five, and the rewrites lean '
        'more on idiom than on clean grammar rules.',
  ),
  TaskType(
    id: 'mc-reading',
    name: 'Multiple choice (reading)',
    where: 'Reading and Use of English, Part 5',
    whatItIs:
        'One long text with six questions, four options each. The '
        'questions follow the order of the text.',
    whatItTests:
        'Detail, opinion, attitude, tone, purpose, and above all '
        'implication — what the writer suggests without saying it.',
    example:
        'After a paragraph where a chef says: “Of course, anyone can '
        'follow a recipe.”\n\n'
        'What does the chef imply?\n'
        'A Cooking is easy.   B Following recipes is not real cooking.',
    respuesta: 'B',
    why:
        '“Of course, anyone can…” is a concession: he grants the easy '
        'point in order to dismiss it. The literal words say A; the tone says '
        'B. Part 5 is built on exactly this gap.',
    trick:
        'Every right answer is anchored in a specific line. If you cannot '
        'point to the words that prove it, you are guessing from memory.',
    atC1:
        'Same task, but the texts are denser and the wrong options are '
        'closer to being right.',
  ),
  TaskType(
    id: 'gapped-text',
    name: 'Gapped text',
    where: 'B2 Part 6 · C1 Part 7',
    whatItIs:
        'A text with whole sentences (B2) or paragraphs (C1) removed and '
        'jumbled below. You put each one back where it belongs. There is '
        'always one extra that fits nowhere.',
    whatItTests:
        'Cohesion: how a text holds together. Reference words, linkers, '
        'and the logic of what has to come before and after.',
    example:
        'Gap in the text: “… the rescue took nine hours. ___ Only then '
        'did the team allow themselves to rest.”\n\n'
        'Option D: “Even so, every one of the climbers reached the valley '
        'alive.”',
    respuesta: 'D fits',
    why:
        '“Even so” has to answer something difficult just mentioned — the '
        'nine hours. And “Only then” in the next sentence needs a completed '
        'event to point back to, which D supplies.',
    trick:
        'Work on the words that point outwards: this, those, such, even '
        'so, however, meanwhile. They are the stitching, and they only match '
        'in one place.',
    atC1:
        'Whole paragraphs instead of single sentences, so each decision '
        'carries more text with it.',
  ),
  TaskType(
    id: 'multiple-matching',
    name: 'Multiple matching',
    where: 'B2 Part 7 · C1 Part 8',
    whatItIs:
        'A set of short texts or sections, and a list of statements. You '
        'match each statement to the text it belongs to. Texts can be used '
        'more than once.',
    whatItTests:
        'Scanning: finding specific information fast, without reading '
        'everything closely.',
    example: 'Which person mentions being encouraged by a family member?',
    respuesta: 'The one whose text says “my aunt kept telling me to apply”',
    why:
        'The statement never repeats the words of the text. “Encouraged '
        'by a family member” appears as “my aunt kept telling me to apply”. '
        'You are matching meaning, not words.',
    trick:
        'Read the questions first, then scan. Do not read the texts '
        'properly — this part rewards speed and has only one mark per '
        'question.',
    atC1:
        'Ten questions as at B2, but the paraphrasing is further from the '
        'original wording.',
  ),
  TaskType(
    id: 'cross-text',
    name: 'Cross-text multiple matching',
    where: 'C1 Part 6 only — it does not exist at B2',
    whatItIs:
        'Four short texts in which people give opinions on the same '
        'subject. The questions ask you to compare their views: who agrees '
        'with whom, who differs.',
    whatItTests:
        'Comparing opinions across texts, not within one. It is the part '
        'that makes C1 feel genuinely harder than B2.',
    example:
        'Which academic has a different view from the others on the '
        'funding of the arts?',
    respuesta: 'The one whose position contradicts the other three',
    why:
        'You cannot answer by reading one text. You have to hold four '
        'positions in your head at once and see where one breaks with the '
        'rest.',
    trick:
        'Make a one-word note next to each text — “for”, “against”, '
        '“mixed” — before you look at the questions. Otherwise you re-read '
        'everything four times.',
  ),

  // ── Listening ─────────────────────────────────────────────────────────────
  TaskType(
    id: 'listen-short',
    name: 'Short extracts',
    where: 'Listening, Part 1',
    whatItIs:
        'Unrelated short recordings with a question each. At B2 there are '
        'eight extracts with three options; at C1, three extracts with two '
        'questions each.',
    whatItTests:
        'Gist, detail, function, purpose, attitude, agreement — a '
        'different thing in each extract.',
    example:
        'You hear two friends talking about a concert.\n'
        'How does the woman feel about it?\n'
        'A disappointed   B surprised   C relieved',
    respuesta: 'Depends on tone as much as on words',
    why:
        'Attitude questions are rarely answered by a single word. Someone '
        'who says “well, it was certainly different” is not praising it.',
    trick:
        'Read the question before each extract, and underline the question '
        'word: how, why, what. Answering the wrong question is the most '
        'common way to lose these marks.',
  ),
  TaskType(
    id: 'sentence-completion',
    name: 'Sentence completion',
    where: 'Listening, Part 2',
    whatItIs:
        'One long recording and a set of unfinished sentences. You write '
        'the missing words — a maximum of three, and normally one or two.',
    whatItTests:
        'Catching specific words: numbers, names, nouns. It is the only '
        'listening part marked by people rather than by machine.',
    example: 'The museum was originally built as a ___.',
    respuesta: 'the exact word you hear',
    why:
        'You are not asked to summarise or rephrase. The word is spoken '
        'literally and you write it down as it comes.',
    trick:
        'Do not paraphrase — it is the fastest way to lose a mark you had. '
        'Minor spelling slips are forgiven as long as the meaning is clear, '
        'and words shown in brackets in the key are optional.',
  ),
  TaskType(
    id: 'listen-match',
    name: 'Multiple matching (listening)',
    where: 'B2 Part 3 · C1 Part 4',
    whatItIs:
        'Five speakers say something on a shared theme. You match each one '
        'to an option from a list of eight. Three options are never used.',
    whatItTests:
        'Gist and attitude under time pressure, with distractors: each '
        'speaker will mention words from the wrong options.',
    example:
        'Speaker 3: “I signed up mostly because my brother had done it '
        'and would not stop talking about it.”',
    respuesta: 'The “influenced by family” option',
    why:
        'The speaker never says “family” or “influenced”. Every option is '
        'a paraphrase, and the wrong ones are seeded with words you will '
        'actually hear.',
    trick:
        'At C1 this part has two parallel tasks over the same five '
        'speakers — you answer twice about each. Keep the two lists apart on '
        'the page or you will cross them.',
  ),

  // ── Writing and Speaking ──────────────────────────────────────────────────
  TaskType(
    id: 'essay',
    name: 'The essay',
    where: 'Writing, Part 1 — compulsory',
    whatItIs:
        'You get a question and some bullet points, and you write a '
        'discursive essay: 140–190 words at B2, 220–260 at C1.',
    whatItTests:
        'Four separate things, each scored 0–5: Content, Communicative '
        'Achievement, Organisation and Language. Only one of the four is '
        'about vocabulary and grammar.',
    example:
        'Some people think schools should teach cooking. Do you agree?\n'
        'Notes: health · time · cost',
    respuesta: 'Cover the points, state a position, structure it',
    why:
        'Missing one bullet point costs Content marks no matter how good '
        'the English is. At C1 you also have to say which of the points '
        'matters most and why — not just cover them.',
    trick:
        'Spend five minutes planning. Organisation and Content are half '
        'your marks and they are the two you can secure before writing a '
        'single sentence.',
  ),
  TaskType(
    id: 'long-turn',
    name: 'The long turn',
    where: 'Speaking, Part 2',
    whatItIs:
        'You get two or three photos and one minute to talk on your own. '
        'Nobody interrupts. There is a question printed above the pictures.',
    whatItTests:
        'Whether you can organise speech on the spot, compare, and '
        'speculate. It is not a description task, though almost everyone '
        'treats it as one.',
    example:
        'Two photos of people exercising. “Why might the people have '
        'chosen these activities?”',
    respuesta: 'Compare, then answer the question',
    why:
        'Listing what is in each photo uses up the minute and answers '
        'nothing. The marks are in the comparison and in the speculation.',
    trick:
        'Four moves, in order: say which photo, compare them, speculate '
        '(“they look as though…”, “he might be…”), then answer the printed '
        'question. That structure fills a minute on its own.',
  ),
];
