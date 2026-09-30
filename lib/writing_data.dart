/// Writing tasks, in the shape Cambridge sets them.
///
/// Written here rather than copied from a paper, but following the real
/// format: Part 1 is a compulsory email at B1 and an essay at B2/C1.
/// Part 2 offers a choice of text types, each with its own conventions.
///
/// The `checklist` on each task is the part worth reading. Content is a whole
/// subscale of its own, and it is lost by ignoring a bullet point, not by
/// writing bad English.
library;

import 'cambridge.dart';

part 'writing_extra_data.dart';

enum TextType {
  essay('Essay'),
  article('Article'),
  email('Email or letter'),
  report('Report'),
  review('Review'),
  proposal('Proposal'),
  story('Story');

  const TextType(this.label);
  final String label;
}

class WritingTask {
  const WritingTask({
    required this.id,
    required this.level,
    required this.part,
    required this.kind,
    required this.instructions,
    required this.question,
    required this.checklist,
    this.notes = const [],
    this.register,
    this.title,
  });

  final String id;
  final String? title;
  final ExamLevel level;

  /// 1 is the compulsory task, 2 is the one you choose.
  final int part;

  final TextType kind;

  /// The framing: who is asking and why.
  final String instructions;

  /// The question itself.
  final String question;

  /// The bullet points you have to cover. Skipping one costs Content marks.
  final List<String> notes;

  /// What tone this text type expects.
  final String? register;

  /// What to check before you call it finished.
  final List<String> checklist;

  /// The word count Cambridge asks for, and the minutes the paper allows.
  ///
  /// It lives on the task rather than in the editor so that the model answers
  /// can be checked against the same numbers the counter uses. Two copies of
  /// a rule is how the two of them end up disagreeing.
  // B1 asks for about 100 words. 90–110 is a practice target, not an exam rule.
  (int, int) get wordRange => switch (level) {
    ExamLevel.b1 => (90, 110),
    ExamLevel.b2 => (140, 190),
    ExamLevel.c1 => (220, 260),
  };

  String get wordTarget => level == ExamLevel.b1
      ? 'about 100 words'
      : '${wordRange.$1}–${wordRange.$2} words';

  int get minutes => switch (level) {
    ExamLevel.b1 => part == 1 ? 22 : 23,
    ExamLevel.b2 => 40,
    ExamLevel.c1 => 45,
  };

  bool get isCompulsory => part == 1;
}

final List<WritingTask> writingTasks = [
  // ── B1 Preliminary ──────────────────────────────────────────────────────
  const WritingTask(
    id: 'b1-p1-weekend',
    level: ExamLevel.b1,
    part: 1,
    kind: TextType.email,
    instructions:
        'Read this email from your English friend Alex:\n\n'
        '“I am visiting you on Saturday! Shall we meet at the station at ten? '
        'What could we do together? Should I bring anything? I can stay until '
        'Sunday morning. Is that OK?”',
    question: 'Write your email to Alex, using all the notes.',
    notes: [
      'Confirm the meeting time.',
      'Suggest an activity and say why.',
      'Tell Alex what to bring.',
      'Explain why staying overnight is not possible.',
    ],
    register: 'Friendly and informal.',
    checklist: [
      'Reply to all four points.',
      'Give a reason for your suggestion.',
      'Use a greeting and a friendly ending.',
      'Write about 100 words.',
    ],
  ),
  const WritingTask(
    id: 'b1-p2-hobby',
    level: ExamLevel.b1,
    part: 2,
    kind: TextType.article,
    instructions:
        'You see this notice on an English-language website:\n\n'
        '“A HOBBY WORTH TRYING. What do you enjoy doing in your free time? '
        'How did you start? Why would you recommend it to other young people?”',
    question: 'Write an article answering these questions.',
    register: 'Friendly and interesting for other young readers.',
    checklist: [
      'Name your hobby and explain how you started.',
      'Give reasons for recommending it.',
      'Use a title and short paragraphs.',
      'Write about 100 words.',
    ],
  ),
  const WritingTask(
    id: 'b1-p2-story',
    level: ExamLevel.b1,
    part: 2,
    kind: TextType.story,
    instructions:
        'Your English teacher has asked you to write a story. '
        'Your story must begin with this sentence:',
    question: 'When I opened the bag, I knew it was not mine.',
    register: 'A clear, engaging story for your teacher.',
    checklist: [
      'Use the given sentence as your opening.',
      'Keep the same narrator and use past tenses consistently.',
      'Give the story a beginning, a problem and an ending.',
      'Write about 100 words.',
    ],
  ),
  // ── B2 First · Part 1, compulsory ─────────────────────────────────────────
  const WritingTask(
    id: 'b2-p1-tech',
    level: ExamLevel.b2,
    part: 1,
    kind: TextType.essay,
    instructions:
        'In your English class you have been talking about technology and '
        'learning. Now your teacher has asked you to write an essay.',
    question:
        'Some people say that students learn better with a teacher in front '
        'of them than they do online. Do you agree?',
    notes: ['attention', 'cost', '(your own idea)'],
    register: 'Formal or neutral. No contractions, no slang.',
    checklist: [
      'All three notes covered, including your own idea.',
      'A clear position, stated early and held to the end.',
      'Four paragraphs: introduction, two points, conclusion.',
      'Linking that does work: however, furthermore, whereas, in contrast.',
      '140–190 words.',
    ],
  ),
  const WritingTask(
    id: 'b2-p1-city',
    level: ExamLevel.b2,
    part: 1,
    kind: TextType.essay,
    instructions:
        'Your class has been discussing how towns and cities change. Your '
        'teacher has asked you to write an essay.',
    question:
        'Is it better for young people to live in a big city or in a small '
        'town?',
    notes: ['work', 'cost of living', '(your own idea)'],
    register: 'Formal or neutral.',
    checklist: [
      'Do not just list advantages: compare them.',
      'Your own idea has to be genuinely yours, not a rewording of the notes.',
      'Say which factor matters most, and why.',
      '140–190 words.',
    ],
  ),

  // ── B2 First · Part 2, choose one ─────────────────────────────────────────
  const WritingTask(
    id: 'b2-p2-review',
    level: ExamLevel.b2,
    part: 2,
    kind: TextType.review,
    instructions:
        'You see this announcement in an English-language magazine:\n\n'
        '“Send us a review of a place you have eaten at recently. Tell us '
        'what the food and the atmosphere were like, and say whether you '
        'would recommend it.”',
    question: 'Write your review.',
    register:
        'Semi-formal, but with personality. A review is allowed an '
        'opinion and a bit of colour.',
    checklist: [
      'Both asked-for points: the food AND the atmosphere.',
      'A recommendation, stated plainly.',
      'Descriptive adjectives beyond “good” and “nice”.',
      'A title helps here — reviews normally have one.',
      '140–190 words.',
    ],
  ),
  const WritingTask(
    id: 'b2-p2-email',
    level: ExamLevel.b2,
    part: 2,
    kind: TextType.email,
    instructions:
        'You have received this email from your English friend Sam:\n\n'
        '“I am coming to your country for a week next month and I have no '
        'idea what to do. Where should I go, and is there anything I should '
        'avoid? Also, how much money should I bring?”',
    question: 'Write your email to Sam.',
    register: 'Informal. Contractions are fine, and expected.',
    checklist: [
      'Answer all three questions: where to go, what to avoid, how much money.',
      'Open and close like an email to a friend, not like a letter to a bank.',
      'Ask something back — it makes it read like real correspondence.',
      '140–190 words.',
    ],
  ),
  const WritingTask(
    id: 'b2-p2-report',
    level: ExamLevel.b2,
    part: 2,
    kind: TextType.report,
    instructions:
        'Your college principal has asked you to write a report on the study '
        'spaces available to students, and to suggest one improvement.',
    question: 'Write your report.',
    register:
        'Formal and impersonal. This is the one place where sounding '
        'dry is correct.',
    checklist: [
      'Use headings. A report without sections is an essay wearing a hat.',
      'Describe the current situation before recommending anything.',
      'Exactly one improvement, argued properly, not five listed.',
      'Passive and impersonal forms: “it was found that…”, “students report…”',
      '140–190 words.',
    ],
  ),

  const WritingTask(
    id: 'b2-p2-article',
    level: ExamLevel.b2,
    part: 2,
    kind: TextType.article,
    instructions:
        'An English-language student magazine wants articles about '
        'learning outside the classroom. Describe a useful skill you learnt '
        'in your free time, explain what made learning it difficult, and give '
        'advice to someone who wants to try it.',
    question: 'Write your article for the magazine.',
    register: 'Lively and conversational, addressing fellow students.',
    checklist: [
      'Cover the skill, the difficulty and practical advice.',
      'Give the article a title that invites the reader in.',
      'Use a specific example instead of general encouragement.',
      '140–190 words.',
    ],
  ),

  // ── C1 Advanced · Part 1, compulsory ──────────────────────────────────────
  const WritingTask(
    id: 'c1-p1-arts',
    level: ExamLevel.c1,
    part: 1,
    kind: TextType.essay,
    instructions:
        'You have listened to a radio discussion about how governments should '
        'spend limited cultural budgets. You have made the notes below.\n\n'
        'Write an essay discussing TWO of the areas in your notes. Explain '
        'which you think is more important to fund, giving reasons.',
    question:
        'Which area most deserves public funding: museums, live music or '
        'public libraries?',
    notes: [
      'museums — preserve what would otherwise be lost',
      'live music — supports working artists directly',
      'public libraries — the only free option for many people',
      'Opinions heard: “museums are for tourists, not residents” · '
          '“libraries do far more than lend books”',
    ],
    register: 'Formal. An academic register, sustained throughout.',
    checklist: [
      'TWO areas only. Discussing all three is a Content failure, not thorough.',
      'Say which is more important AND why — at C1 covering is not enough.',
      'Engage with at least one of the opinions quoted in the notes.',
      'Complex structures under control: it is not enough to be correct, the '
          'range has to show.',
      '220–260 words.',
    ],
  ),

  // ── C1 Advanced · Part 2, choose one ──────────────────────────────────────
  const WritingTask(
    id: 'c1-p2-proposal',
    level: ExamLevel.c1,
    part: 2,
    kind: TextType.proposal,
    instructions:
        'The director of the international centre where you study wants to '
        'increase the number of students who take part in evening activities. '
        'You have been asked to write a proposal outlining the current '
        'problem, suggesting two changes, and explaining what each would '
        'achieve.',
    question: 'Write your proposal.',
    register:
        'Formal, and forward-looking. A proposal argues for a future '
        'action; a report describes a present situation.',
    checklist: [
      'Headings, and a recommendation section at the end.',
      'Exactly two changes, each with its expected effect.',
      'Persuasive language: “this would allow…”, “a further benefit would be…”',
      '220–260 words.',
    ],
  ),
  const WritingTask(
    id: 'c1-p2-letter',
    level: ExamLevel.c1,
    part: 2,
    kind: TextType.email,
    instructions:
        'You recently attended a three-day training course that was cancelled '
        'halfway through. The organisers have offered a partial refund. Write '
        'to them explaining why you consider this insufficient and what you '
        'expect instead.',
    question: 'Write your letter.',
    register:
        'Formal and firm, but not rude. Complaining well in English is '
        'a register skill in itself.',
    checklist: [
      'State the facts before the complaint — dates, what was promised.',
      'Say precisely what you want. “I would appreciate a full refund” beats '
          '“I am not happy”.',
      'Controlled indignation: “I was disappointed to find that…”',
      '220–260 words.',
    ],
  ),
  const WritingTask(
    id: 'c1-p2-review',
    level: ExamLevel.c1,
    part: 2,
    kind: TextType.review,
    instructions:
        'An international magazine is publishing reviews of films '
        'that changed the way viewers think. Review a film you have seen, '
        'evaluate how effectively it communicates its ideas, and explain '
        'which readers would benefit most from watching it.',
    question: 'Write your review.',
    register: 'Engaging and evaluative, for an adult magazine readership.',
    checklist: [
      'Evaluate the film rather than retelling the plot.',
      'Support your judgement with specific details.',
      'Recommend it to a defined audience and explain why.',
      '220–260 words.',
    ],
  ),
  const WritingTask(
    id: 'c1-p2-report',
    level: ExamLevel.c1,
    part: 2,
    kind: TextType.report,
    instructions:
        'You volunteer at a community centre. Its manager has asked '
        'for a report on the first month of a new language exchange. Evaluate '
        'what has worked well, identify problems affecting participation, '
        'and recommend changes for the next month.',
    question: 'Write your report to the manager.',
    register: 'Formal, factual and constructive.',
    checklist: [
      'Use clear headings and an explicit purpose.',
      'Distinguish observations from your interpretation.',
      'Connect each recommendation to a problem you identified.',
      '220–260 words.',
    ],
  ),
  ...extraWritingTasks,
];

List<WritingTask> writingTasksFor(ExamLevel level) =>
    writingTasks.where((t) => t.level == level).toList();
