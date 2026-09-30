part of 'writing_data.dart';

const extraWritingTasks = <WritingTask>[
  WritingTask(
    id: "b1-p1-study-visit",
    level: ExamLevel.b1,
    part: 1,
    kind: TextType.email,
    title: "Planning a study visit",
    instructions:
        "Your English friend Sam writes: “I can visit your town next Friday. Could we study "
        "English together? Where should we meet? What should I bring? Shall we go out for dinner "
        "afterwards?”",
    question: "Write an email to Sam using all the notes.",
    notes: [
      "Agree to study together.",
      "Suggest a meeting place and explain why.",
      "Say what Sam should bring.",
      "Explain why you cannot have dinner together.",
    ],
    register: "Friendly and informal.",
    checklist: [
      "Answer all four points.",
      "Explain your choice of meeting place.",
      "Give a reason for declining dinner.",
      "Use a greeting and a friendly ending.",
    ],
  ),
  WritingTask(
    id: "b1-p2-useful-place",
    level: ExamLevel.b1,
    part: 2,
    kind: TextType.article,
    title: "A useful place in my town",
    instructions:
        "An English-language website asks: “Which place in your town is especially useful for "
        "young people? What can you do there? Why would you recommend it?”",
    question: "Write an article about a useful place in your town.",
    notes: [],
    register: "Friendly and informative for other young people.",
    checklist: [
      "Name the place.",
      "Describe what young people can do there.",
      "Explain why you recommend it.",
      "Add a title and write about 100 words.",
    ],
  ),
  WritingTask(
    id: "b2-p1-volunteering",
    level: ExamLevel.b2,
    part: 1,
    kind: TextType.essay,
    title: "Should students volunteer?",
    instructions:
        "In your English class you have discussed whether schools should encourage students to "
        "volunteer in their local communities. Write an essay using all the notes and giving "
        "reasons for your view.",
    question: "Should schools encourage every student to do voluntary work?",
    notes: [
      "learning practical skills",
      "time for schoolwork",
      "(your own idea)",
    ],
    register: "Formal or neutral.",
    checklist: [
      "Discuss both supplied notes.",
      "Add a distinct third idea.",
      "Give a clear, balanced opinion.",
      "Write 140–190 words.",
    ],
  ),
  WritingTask(
    id: "b2-p1-public-transport",
    level: ExamLevel.b2,
    part: 1,
    kind: TextType.essay,
    title: "Improving travel in towns",
    instructions:
        "Your class has discussed ways to improve life in towns. Your teacher asks you to write "
        "an essay using all the notes and explaining your opinion.",
    question: "Is improving public transport the best way to make a town a better place to live?",
    notes: ["traffic", "cost", "(your own idea)"],
    register: "Formal or neutral.",
    checklist: [
      "Discuss traffic and cost.",
      "Include your own additional idea.",
      "Compare benefits with practical limits.",
      "Write 140–190 words.",
    ],
  ),
  WritingTask(
    id: "b2-p2-learning-app",
    level: ExamLevel.b2,
    part: 2,
    kind: TextType.review,
    title: "Review a learning app",
    instructions:
        "A student magazine wants reviews of apps used to learn a skill. Describe an app, "
        "evaluate its most useful feature and one limitation, and explain which learners would "
        "benefit from it. You may invent the app.",
    question: "Write a review of a learning app for the student magazine.",
    notes: [],
    register: "Engaging and evaluative, with a clear recommendation.",
    checklist: [
      "Describe the app briefly.",
      "Evaluate one strength and one limitation.",
      "Recommend it to a specific type of learner.",
      "Write 140–190 words.",
    ],
  ),
  WritingTask(
    id: "b2-p2-study-spaces",
    level: ExamLevel.b2,
    part: 2,
    kind: TextType.report,
    title: "Improve the school study rooms",
    instructions:
        "Your school wants to improve its study rooms. The head teacher has asked you to describe"
        " what currently works well, identify two problems and recommend practical improvements.",
    question: "Write a report recommending improvements to the study rooms.",
    notes: [],
    register: "Neutral or formal, factual and constructive.",
    checklist: [
      "State the purpose of the report.",
      "Mention a strength and two problems.",
      "Link recommendations to the problems.",
      "Use headings and write 140–190 words.",
    ],
  ),
  WritingTask(
    id: "c1-p1-community-funding",
    level: ExamLevel.c1,
    part: 1,
    kind: TextType.essay,
    title: "Priorities for community funding",
    instructions:
        "Your class has discussed how local authorities should use a limited community budget. "
        "The options were public libraries, sports facilities and public art. Write an essay "
        "discussing two options. Explain which deserves greater priority, giving reasons.",
    question: "Which community facilities should receive priority when funding is limited?",
    notes: ["public libraries", "sports facilities", "public art"],
    register: "Formal, analytical and balanced.",
    checklist: [
      "Select and develop two of the three options.",
      "Evaluate their benefits rather than listing them.",
      "Explain which deserves greater priority.",
      "Write 220–260 words.",
    ],
  ),
  WritingTask(
    id: "c1-p2-repair-workshops",
    level: ExamLevel.c1,
    part: 2,
    kind: TextType.proposal,
    title: "Repair workshops at the community centre",
    instructions:
        "The manager of a community centre wants proposals for a new weekend activity. Propose a "
        "programme of repair workshops. Explain who would benefit, how it could be organised with"
        " a small budget, and how success should be evaluated.",
    question: "Write your proposal for a weekend repair workshop programme.",
    notes: [],
    register: "Formal and persuasive, with realistic recommendations.",
    checklist: [
      "Identify the intended participants and benefits.",
      "Explain staffing, equipment and budget priorities.",
      "Suggest a manageable pilot and a way to evaluate it.",
      "Write 220–260 words.",
    ],
  ),
];
