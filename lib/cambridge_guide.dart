/// Everything worth knowing about the exam, in one place.
///
/// The format facts come from Cambridge's own *Classroom Handouts* and the
/// *Handbook for Teachers*. They describe how the exam works; they are not
/// content from the papers themselves.
library;

class GuideSection {
  const GuideSection({
    required this.title,
    required this.body,
    this.points = const [],
  });

  final String title;
  final String body;

  /// The bullet points under the body. Named `points`, not `marks`: in this
  /// app a mark is a score, and reusing the word here was confusing.
  final List<String> points;
}

class GuideBlock {
  const GuideBlock({required this.title, required this.sections});
  final String title;
  final List<GuideSection> sections;
}

const List<GuideBlock> cambridgeGuide = [
  GuideBlock(
    title: 'The exam in one page',
    sections: [
      GuideSection(
        title: 'Two names for the same exam',
        body:
            'Cambridge renamed its exams in 2019. PET, FCE and CAE became B1 '
            'Preliminary, B2 First and C1 Advanced. Nothing about the papers '
            'changed with the name — an old FCE past paper is a B2 First past '
            'paper. Teachers and schools still say the short names, while the '
            'certificate, the university and the employer use the level. If '
            'you have ever wondered whether FCE and B2 are two different '
            'things: they are not.',
        points: [
          'B1 Preliminary = PET (Preliminary English Test).',
          'B2 First = FCE (First Certificate in English).',
          'C1 Advanced = CAE (Certificate in Advanced English).',
          'Above and below: A2 Key was KET, C2 Proficiency was CPE.',
          'B1, B2 and C1 are CEFR levels — the Council of Europe scale, which '
              'is not a Cambridge invention and is what most institutions ask '
              'for by name.',
        ],
      ),
      GuideSection(
        title: 'B2 First, and where C1 sits',
        body:
            'B2 First (FCE) certifies an upper-intermediate level. Your goal '
            'is C1 Advanced (CAE), which is the next certificate up — a '
            'different exam with longer texts, faster listening and a higher '
            'bar for accuracy. B2 is not a detour: it is the standard way to '
            'measure where you are before committing to C1, and every skill '
            'you build here transfers.',
        points: [
          'B2 First: 4 papers, about 3 hours 30 minutes in total.',
          'C1 Advanced: same four skills, roughly 4 hours, harder input.',
          'Cambridge certificates do not expire.',
        ],
      ),
      GuideSection(
        title: 'How the four papers weigh',
        body:
            'Each paper counts for 25% of the final result. That is worth '
            'repeating: Speaking is worth exactly as much as Reading and Use '
            'of English, even though it lasts 14 minutes instead of 75.',
        points: [
          'Reading and Use of English — 75 min, 52 questions, 25%',
          'Writing — 80 min, 2 tasks, 25%',
          'Listening — about 40 min, 30 questions, 25%',
          'Speaking — 14 min in pairs, 25%',
        ],
      ),
      GuideSection(
        title: 'How it is scored',
        body:
            'Raw marks are converted to the Cambridge English Scale. For B2 '
            'First you need about 160 to pass (grade C), and 180 or more earns '
            'a C1 certificate on the same exam. Roughly 60% of the raw marks '
            'is the usual pass threshold, but the conversion is not linear, so '
            'treat any percentage here as a guide, not a promise.',
        points: [
          '160–172: grade C — B2 certificate',
          '173–180: grade B',
          '180–190: grade A — certifies C1',
          'Below 160 but above 140: a B1 certificate is issued',
        ],
      ),
    ],
  ),
  GuideBlock(
    title: 'Reading and Use of English',
    sections: [
      GuideSection(
        title: 'What it is',
        body:
            '75 minutes, seven parts, 52 questions. Parts 1 to 4 test grammar '
            'and vocabulary; parts 5 to 7 test reading. It is the longest '
            'paper and the one where time management decides your mark.',
        points: [
          'Part 1 — Multiple-choice cloze, 8 questions, 1 mark each. '
              'Vocabulary: collocations, fixed phrases, phrasal verbs.',
          'Part 2 — Open cloze, 8 questions, 1 mark each. Grammar: you write '
              'one word per gap, usually a preposition, article or auxiliary.',
          'Part 3 — Word formation, 8 questions, 1 mark each. You change the '
              'word given using prefixes and suffixes.',
          'Part 4 — Key word transformations, 6 questions, up to 2 marks each. '
              'Two to five words, and the key word cannot be changed.',
          'Part 5 — Multiple choice, 6 questions, 2 marks each. Detail, '
              'opinion, attitude, tone, implication.',
          'Part 6 — Gapped text, 6 questions, 2 marks each. Cohesion and text '
              'structure.',
          'Part 7 — Multiple matching, 10 questions, 1 mark each. Scanning for '
              'specific information.',
        ],
      ),
      GuideSection(
        title: 'Where the marks actually are',
        body:
            'Part 4 is the best return on effort in the whole paper: six '
            'questions worth 12 marks, and each one is split into two halves '
            'that are marked separately. That means half a right answer still '
            'scores. Never leave one blank — write the part you are sure of.',
        points: [
          'Parts 5 and 6 are worth 2 marks per question: 24 marks between them.',
          'Part 7 has 10 questions but only 1 mark each — do not overspend '
              'time on it.',
          'Suggested timing: about 45 minutes for parts 1–4, 30 for parts 5–7.',
        ],
      ),
      GuideSection(
        title: 'Habits that pay',
        body:
            'For the cloze parts, read the whole text once before filling '
            'anything in. Decide what kind of word each gap needs — noun, '
            'verb, adverb — before you think about meaning. In Part 3 the gap '
            'often needs two steps: profession → professional → '
            'professionally.',
        points: [
          'Check that your answer fits grammatically AND makes sense in the '
              'sentence.',
          'If you are unsure, cross out the options you know are wrong and '
              'choose from the rest.',
          'Read the completed sentence back to see whether it sounds right.',
        ],
      ),
    ],
  ),
  GuideBlock(
    title: 'Writing',
    sections: [
      GuideSection(
        title: 'What it is',
        body:
            '80 minutes, two tasks of 140–190 words each. Part 1 is always an '
            'essay and is compulsory. Part 2 offers a choice: an article, an '
            'email or letter, a report or a review.',
      ),
      GuideSection(
        title: 'The four things they mark',
        body:
            'Each task is marked on four subscales, 0 to 5 each. Knowing them '
            'changes how you write, because three of the four have nothing to '
            'do with vocabulary.',
        points: [
          'Content — did you cover every point the task asked for? Missing one '
              'bullet costs you heavily.',
          'Communicative Achievement — is the register right for the reader, '
              'and does it read like the text type it claims to be?',
          'Organisation — paragraphs, linking, a clear beginning and end.',
          'Language — range and accuracy of grammar and vocabulary.',
        ],
      ),
      GuideSection(
        title: 'What separates a 3 from a 5',
        body:
            'Not longer words — control. A 5 uses a range of structures '
            'confidently and makes few errors; a 3 repeats simple patterns or '
            'reaches for ambitious language and loses control of it. Plan for '
            'five minutes before writing: it buys you Organisation and Content '
            'marks almost for free.',
        points: [
          'Answer every bullet point in the task, explicitly.',
          'Keep the register consistent — do not mix "Furthermore" with '
              '"gonna".',
          'Leave three minutes at the end to check verb endings, articles and '
              'plurals.',
        ],
      ),
    ],
  ),
  GuideBlock(
    title: 'Listening',
    sections: [
      GuideSection(
        title: 'What it is',
        body:
            'About 40 minutes, four parts, 30 questions, one mark each — 20% '
            'of the total exam. Everything is played twice. You write your '
            'answers on the question paper while you listen, and you get five '
            'minutes of transfer time at the end to copy them onto a separate '
            'answer sheet.',
        points: [
          'Part 1 — 8 questions. Eight unrelated short extracts, multiple '
              'choice.',
          'Part 2 — 10 questions. Sentence completion from one long text.',
          'Part 3 — 5 questions. Five speakers matched to eight options: three '
              'are not used.',
          'Part 4 — 7 questions. One long interview, multiple choice.',
        ],
      ),
      GuideSection(
        title: 'Part 2 is the one to drill',
        body:
            'Part 2 is the only part not marked by computer — trained markers '
            'read it. You write the words you hear, without rephrasing them. '
            'Answers are a maximum of three words, and complete sentences are '
            'not required.',
        points: [
          'Numbers, phrases and names are written exactly as heard: no changes '
              'needed.',
          'Minor spelling errors do not cost you the mark as long as the '
              'meaning is clear.',
          'Do not try to paraphrase — the word you need is literally spoken.',
          'One mark per correct answer, ten marks in the part.',
        ],
      ),
      GuideSection(
        title: 'The transfer trap',
        body:
            'Every year candidates lose marks not because they misheard but '
            'because they ran out of transfer time or copied into the wrong '
            'row. Write clearly on the question paper the first time, and use '
            'the second listening to confirm rather than to start over.',
      ),
    ],
  ),
  GuideBlock(
    title: 'Speaking',
    sections: [
      GuideSection(
        title: 'What it is',
        body:
            '14 minutes, normally in pairs, with two examiners: one talks to '
            'you, the other only listens and marks. Four parts. This is the '
            'paper you cannot practise alone — and you are living on a campus '
            'full of people who need the same practice.',
        points: [
          'Part 1 — Interview, about 2 minutes. Personal questions.',
          'Part 2 — Individual long turn, 1 minute each. You compare two '
              'photos and answer a question printed above them.',
          'Part 3 — Collaborative task, about 4 minutes. You discuss with your '
              'partner and reach a decision.',
          'Part 4 — Discussion, about 4 minutes. Broader questions on the '
              'same theme.',
        ],
      ),
      GuideSection(
        title: 'Part 2: the long turn',
        body:
            'One full minute is yours and nobody interrupts. The task is not '
            'to describe the photos — it is to compare them and answer the '
            'question. Then your partner speaks for 30 seconds about your '
            'pictures.',
        points: [
          'Say which picture you mean: "The picture at the top shows…"',
          'Compare: "These people are moving much more quickly than those."',
          'Contrast: "Tennis is competitive, whereas an exercise class is '
              'relaxed."',
          'Speculate: "They look as though they are enjoying it", "He might be '
              'a professional."',
          'Say what you would prefer: "I\'d rather do something '
              'non-competitive."',
        ],
      ),
      GuideSection(
        title: 'What the examiners are listening for',
        body:
            'Grammar and vocabulary, discourse management (can you keep going '
            'coherently?), pronunciation, and interactive communication. That '
            'last one is why Part 3 rewards asking your partner questions and '
            'reacting to what they say — not delivering a monologue.',
        points: [
          'Silence costs more than a small mistake. Keep talking.',
          'If you do not know a word, talk around it — that is a skill they '
              'reward.',
          'Invite your partner in: "What do you think?", "Do you agree?"',
        ],
      ),
    ],
  ),
  GuideBlock(
    title: 'B1 Preliminary — the step below',
    sections: [
      GuideSection(
        title: 'What it is',
        body:
            'B1 Preliminary (PET) certifies an intermediate level: enough '
            'English to handle everyday situations, travel and straightforward '
            'work. It is not a lesser version of B2 First — it is a shorter '
            'exam with a different shape, and worth sitting on its own terms '
            'if B2 is still out of reach.',
        points: [
          'Reading — 45 minutes, 6 parts, 32 questions',
          'Writing — 45 minutes, 2 parts of about 100 words each',
          'Listening — about 30 minutes, 4 parts, 25 questions',
          'Speaking — 10–12 minutes in pairs',
        ],
      ),
      GuideSection(
        title: 'The big structural difference',
        body:
            'There is no separate Use of English paper at B1. The grammar is '
            'tested inside Reading Part 6, a six-gap open cloze, and that is '
            'the whole of it. At B2 the same skill is spread over four parts '
            'and thirty questions — which is why the jump from B1 to B2 feels '
            'larger than one level.',
        points: [
          'Part 1 — signs and short messages, 5 questions',
          'Part 2 — matching people to descriptions, 5 questions',
          'Part 3 — multiple choice on one long text, 5 questions',
          'Part 4 — gapped text, 5 sentences from a list of 8',
          'Part 5 — multiple-choice cloze, 6 questions',
          'Part 6 — open cloze, 6 questions. The grammar lives here',
        ],
      ),
      GuideSection(
        title: 'How it is scored, and what it is worth',
        body:
            'Same Cambridge English Scale, different band. You pass B1 '
            'Preliminary at 140, and 160 or above earns a B2 certificate from '
            'the B1 exam — the same trick that lets a strong B2 First result '
            'certify C1.',
        points: [
          '140–152: grade C — B1 certificate',
          '153–159: grade B',
          '160–170: grade A — certifies B2',
          'Below 140 but above 120: an A2 certificate is issued',
        ],
      ),
      GuideSection(
        title: 'When to sit it rather than B2',
        body:
            'If a B2 mock comes out below about 50%, B1 is the better exam to '
            'sit first. A pass at B1 is a real certificate and a real piece of '
            'evidence; a fail at B2 is neither. And a grade A at B1 gets you '
            'the B2 certificate anyway.',
      ),
    ],
  ),
  GuideBlock(
    title: 'C1 Advanced — the step above',
    sections: [
      GuideSection(
        title: 'What changes from B2',
        body:
            'Taken from the official C1 Advanced handbook. It is not simply '
            '“the same exam but harder”: the Reading and Use of English paper '
            'grows from seven parts to eight, gains a genuinely new task '
            'type, and runs fifteen minutes longer.',
        points: [
          'Reading and Use of English — 1 h 30 min, 8 parts, 56 questions '
              '(B2: 1 h 15 min, 7 parts, 52 questions)',
          'Writing — 1 h 30 min, two tasks of 220–260 words (B2: 1 h 20 min, '
              '140–190 words)',
          'Listening — about 40 minutes, 30 questions, as at B2',
          'Speaking — 15 minutes in pairs, 23 in threes (B2: 14 minutes)',
        ],
      ),
      GuideSection(
        title: 'The eight parts of Reading and Use of English',
        body:
            'Parts 1 to 4 are Use of English and parts 5 to 8 are reading, '
            'same as B2. The new one is Part 6.',
        points: [
          'Part 1 — Multiple-choice cloze, questions 1–8',
          'Part 2 — Open cloze, questions 9–16',
          'Part 3 — Word formation, questions 17–24',
          'Part 4 — Key word transformations, questions 25–30. Three to six '
              'words, not two to five',
          'Part 5 — Multiple choice, questions 31–36',
          'Part 6 — Cross-text multiple matching, questions 37–40. NEW: four '
              'texts giving opinions on one subject, and you compare who '
              'agrees with whom',
          'Part 7 — Gapped text, questions 41–46. Whole paragraphs removed, '
              'not single sentences',
          'Part 8 — Multiple matching, questions 47–56',
        ],
      ),
      GuideSection(
        title: 'Listening at C1',
        body:
            'Still 30 questions in about 40 minutes, but redistributed, and '
            'Part 4 asks you to answer twice about the same five speakers.',
        points: [
          'Part 1 — Three extracts, two questions each: questions 1–6',
          'Part 2 — Sentence completion: questions 7–14',
          'Part 3 — Multiple choice with four options: questions 15–20',
          'Part 4 — Five monologues, two parallel matching tasks: '
              'questions 21–30',
        ],
      ),
      GuideSection(
        title: 'The shortcut worth knowing',
        body:
            'You do not have to sit C1 Advanced to hold a C1 certificate. '
            'Score 180 or above on B2 First and Cambridge issues a '
            'certificate stating C1 level. It works the other way too: fall '
            'short on C1 Advanced but stay above 160 and you get a B2 '
            'certificate rather than nothing.',
        points: [
          'B2 First, grade A (180–190) — certifies C1',
          'C1 Advanced, grade C (180–192) — certifies C1',
          'C1 Advanced below 180 but above 160 — certifies B2',
          'Either way the certificate never expires',
        ],
      ),
      GuideSection(
        title: 'What to do between now and then',
        body:
            'Monday is a B2 mock and that is the right thing to sit: it '
            'measures where you actually are. The C1 work starts after you '
            'see that score, and the gap it shows tells you what to train.',
        points: [
          'If B2 comes out above 80%, C1 is a realistic target this year.',
          'The parts that punish you hardest at C1 are 6 and 7 of Reading — '
              'start there.',
          'Writing doubles in length. Length alone is a skill: 250 words of '
              'controlled argument is a different exercise from 170.',
          'The official C1 handbook is in data/cambridge/ with full sample '
              'papers.',
        ],
      ),
    ],
  ),
];
