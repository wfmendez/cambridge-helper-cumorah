/// Model answers, and what the examiner is actually marking.
///
/// Written for Cíl, not taken from a Cambridge paper: their sample answers
/// are theirs. These are deliberately good rather than perfect — an answer
/// that reads as though nobody could write it teaches nothing.
///
/// They are hidden until you ask for them. A model answer read before you
/// write is not a model, it is the answer.
library;

class WritingModel {
  const WritingModel({required this.text, required this.why});

  final String text;

  /// The moves in it that earn marks, named so they can be copied.
  final List<String> why;

  int get words =>
      text.split(RegExp(r'\s+')).where((w) => w.trim().isNotEmpty).length;
}

/// One of the four subscales. Each is marked out of 5, and they are added:
/// a flawless essay that ignores a bullet point cannot score above about
/// three quarters, however good the English.
class Criterion {
  const Criterion({
    required this.name,
    required this.rewards,
    required this.lost,
  });

  final String name;

  /// What the top band asks for.
  final String rewards;

  /// How candidates usually throw it away.
  final String lost;
}

const List<Criterion> writingCriteria = [
  Criterion(
    name: 'Content',
    rewards:
        'Everything the task asked for is there, and nothing that it did not '
        'ask for. All the bullet points are covered, and where the task says '
        '“your own idea”, there is one.',
    lost:
        'By missing a bullet point, or by writing a good essay about a '
        'slightly different question. This is the easiest subscale to score '
        'full marks on and the most commonly dropped.',
  ),
  Criterion(
    name: 'Communicative Achievement',
    rewards:
        'The conventions of the text type are used and held: a report has '
        'headings, a review has an opinion, an informal email sounds like a '
        'person writing to a friend. The reader is held throughout.',
    lost:
        'By writing every task in the same neutral voice. A proposal that '
        'reads like an essay loses here even when every sentence is correct.',
  ),
  Criterion(
    name: 'Organisation',
    rewards:
        'A shape you could describe in one line: an opening that says what '
        'is coming, one idea per paragraph, and linking that connects '
        'arguments rather than decorating them.',
    lost:
        'By one long paragraph, or by linkers used as ornament — “moreover” '
        'in front of a sentence that adds nothing.',
  ),
  Criterion(
    name: 'Language',
    rewards:
        'Range and control together: a variety of structures and vocabulary, '
        'used accurately. Errors that do not obscure the meaning are '
        'tolerated at this level.',
    lost:
        'Two opposite ways — playing safe with structures you mastered two '
        'years ago, or reaching for a word you are not sure of and using it '
        'wrongly. The band asks for ambitious *and* accurate.',
  ),
];

const Map<String, WritingModel> writingModels = {
  'b2-p1-tech': WritingModel(
    text:
        'It is often said that a classroom teacher is more effective than a '
        'screen. I agree with this view in most cases, although the '
        'difference is smaller than people claim.\n\n'
        'The strongest argument concerns attention. In a classroom, a teacher '
        'notices when a student stops following and can stop and explain '
        'again. Online, that student simply switches to another window, and '
        'nobody sees it happen. Concentration is not only a matter of '
        'willpower; it is easier when someone is watching.\n\n'
        'Cost, however, points the other way. Online courses are considerably '
        'cheaper, and for many people the alternative to a cheap online '
        'course is no course at all. A class you can afford and actually take '
        'is worth more than an excellent one you cannot.\n\n'
        'I would add that the two are not really rivals. The best arrangement '
        'I have seen combines live classes with online material to review '
        'afterwards, so that the teacher’s time goes on what only a teacher '
        'can do.\n\n'
        'On balance, then, a teacher in the room is better — but a screen is '
        'far better than nothing.',
    why: [
      'Both given notes are covered and the third paragraph supplies the '
          '“own idea” the task demands. That is the Content mark, secured '
          'before a single clever sentence.',
      'The position is taken in line two and held to the last line. An essay '
          'that decides at the end reads as though the writer was thinking '
          'aloud.',
      'Each paragraph opens by announcing its job — “The strongest argument '
          'concerns…”, “Cost, however, points the other way” — so the shape '
          'is visible without a single “firstly”.',
      'Range without showing off: a cleft (“what only a teacher can do”), a '
          'semicolon, a concession and a comparative structure.',
    ],
  ),
  'b2-p1-city': WritingModel(
    text:
        'Young people today can choose between the energy of a big city and '
        'the calm of a small town. In my opinion the city is the better '
        'choice at that age, though not for ever.\n\n'
        'Work is the clearest reason. Cities have more employers and, more '
        'importantly, more kinds of employer, so somebody who changes '
        'direction does not have to move house to do it. In a small town, one '
        'factory closing can end a career.\n\n'
        'The cost of living is the obvious objection. Rent in a capital can '
        'swallow half a salary, and what is left does not go far. Still, '
        'salaries are usually higher too, and sharing a flat solves more of '
        'the problem than people admit.\n\n'
        'There is also something harder to measure. A city is where you meet '
        'people unlike yourself, which is uncomfortable, and which is how you '
        'grow up.\n\n'
        'For those reasons I would choose the city first and the town later, '
        'when what you want is quiet rather than opportunity.',
    why: [
      'The objection is not ignored: it gets a paragraph of its own and is '
          'then answered. Acknowledging the other side and dealing with it is '
          'worth more than pretending it is not there.',
      '“More employers and, more importantly, more kinds of employer” — the '
          'distinction is the argument. One precise idea beats three vague '
          'ones.',
      'The last line answers the question rather than repeating the '
          'introduction, and it qualifies the answer instead of shouting it.',
    ],
  ),
  'b2-p2-review': WritingModel(
    text:
        'Small room, long memory\n\n'
        'Havránek is a twelve-table restaurant two streets behind the main '
        'square, and it served me the best meal I have had this year.\n\n'
        'The food is Czech, but lighter than the version tourists are usually '
        'given. I had duck with red cabbage: the skin was crisp, the meat was '
        'not dry, and the dumplings had clearly been made that morning. My '
        'friend’s mushroom soup arrived in a hollowed-out loaf and '
        'disappeared in about four minutes.\n\n'
        'The service is friendly rather than polished. Our waiter talked us '
        'out of the expensive wine and into the one he actually liked, which '
        'tells you something about the place.\n\n'
        'Two warnings. It is small, so book, especially at weekends. And it '
        'is cash only — the card machine has been “arriving next week” for a '
        'year.\n\n'
        'Would I recommend it? Without hesitation. Go early, order the duck, '
        'and leave room for the plum cake.',
    why: [
      'It has a title and an opinion. A review without either is a '
          'description, and descriptions score badly on Communicative '
          'Achievement.',
      'Concrete detail does the persuading — crisp skin, four minutes, cash '
          'only. “The food was very nice” is the same claim with none of the '
          'marks.',
      'The negatives are real but small, which is what makes the praise '
          'believable. A review with no reservation reads as an '
          'advertisement.',
      'A direct question and a short answer near the end lift the rhythm. '
          'This text type is allowed a voice; use it.',
    ],
  ),
  'b2-p2-email': WritingModel(
    text:
        'Hi Sam,\n\n'
        'Great news that you are finally coming over! A week is enough to see '
        'a lot, so here is what I would do.\n\n'
        'Spend the first two days in the capital — the old town and the '
        'castle are worth it, and everything there is walkable. Then take the '
        'train south to the lakes for a couple of days. The trains are cheap, '
        'they run on time, and the views are half the reason to go.\n\n'
        'What to avoid: the restaurants right on the main square. They charge '
        'tourists three times the normal price and the food is worse. Walk '
        'two streets away and you will eat better for half as much.\n\n'
        'On money, about €60 a day is comfortable — that covers a hostel, '
        'food and travelling around. Less if you cook a few times.\n\n'
        'Send me your dates as soon as you have them and I will take a day '
        'off work.\n\n'
        'See you soon!',
    why: [
      'All three questions are answered, in the order they were asked, and '
          'each gets its own paragraph. The examiner can tick them off '
          'without hunting.',
      'It sounds like a person: contractions where they fall naturally, a '
          'direct imperative (“Send me your dates”), an exclamation mark used '
          'once. Informal is a register you have to actually write in, not a '
          'label.',
      'The advice is specific enough to act on — two days, €60, two streets '
          'away. Vague advice is indistinguishable from no advice.',
    ],
  ),
  'b2-p2-report': WritingModel(
    text:
        'Study spaces at the college\n\n'
        'Introduction\n'
        'This report describes the study spaces currently available to '
        'students and recommends one improvement.\n\n'
        'Current provision\n'
        'Three areas are in regular use: the main library, the two small '
        'rooms on the first floor, and the café. The library is quiet and '
        'well equipped, but it has forty seats for over six hundred students '
        'and is full by nine in the morning. The first-floor rooms are almost '
        'never used, as they have no power sockets. The café is open all day '
        'but is too noisy for concentrated work.\n\n'
        'Student opinion\n'
        'Most of the students I spoke to said they would use the first-floor '
        'rooms if they could charge a laptop there. Several said they now '
        'study at home simply because there is nowhere to sit.\n\n'
        'Recommendation\n'
        'I recommend that power sockets be installed in the two first-floor '
        'rooms. This would add around thirty usable seats at a small cost, '
        'and would relieve pressure on the library without any building work.',
    why: [
      'Headings, and headings that say something. “Current provision” and '
          '“Recommendation” are the conventions of the text type, and the '
          'conventions are the Communicative Achievement mark.',
      'Impersonal and factual throughout, with numbers. A report is the one '
          'task where sounding dry is correct.',
      '“I recommend that power sockets be installed” — the subjunctive, '
          'which in English survives almost only in this formal frame. One '
          'structure, placed where it belongs.',
      'One recommendation, as the task asked, with its cost and its effect. '
          'Three vague suggestions would score less.',
    ],
  ),
  'c1-p1-arts': WritingModel(
    text:
        'Public money for culture is always money taken from somewhere else, '
        'so the question is not what is valuable but what would not survive '
        'without support. On that test, public libraries have the strongest '
        'claim.\n\n'
        'Museums are frequently defended on the grounds that they preserve a '
        'shared inheritance, and that is true. But major museums are also the '
        'part of the sector best able to raise money elsewhere: they attract '
        'sponsorship, tourism and international loans precisely because they '
        'are prestigious. A national gallery that lost a tenth of its public '
        'funding would run a smaller exhibition programme; it would not '
        'close.\n\n'
        'Live music presents the opposite problem. It is commercially '
        'fragile, and small venues close constantly. Yet music has a '
        'functioning market, and the venues that fail usually fail for '
        'reasons — rent, licensing, changing habits — that a subsidy would '
        'postpone rather than solve.\n\n'
        'Libraries are different in kind. They are the only cultural '
        'institution that is genuinely free at the point of use, and their '
        'users are disproportionately those with no alternative: children '
        'with no books at home, job-seekers with no computer, older people '
        'with nowhere warm to sit. Nothing replaces them if they go, because '
        'no commercial operator wants that audience.\n\n'
        'I would therefore argue for libraries — not because they matter most '
        'in the abstract, but because public funding is the only funding they '
        'will ever have. Where a market exists, let it work; where none can '
        'exist, the state should.',
    why: [
      'It sets up a criterion in the first paragraph — “what would not '
          'survive without support” — and then judges all three options '
          'against it. At C1 the essay is marked on the quality of the '
          'argument, not on the number of points made.',
      'Both of the other options are treated seriously before being set '
          'aside. Dismissing them would be faster and would score lower.',
      'The range is structural rather than decorative: a semicolon '
          'contrast, a dash for apposition, “Where a market exists, let it '
          'work” as a fronted clause with an imperative.',
      'The conclusion adds a principle instead of repeating the answer. '
          'That is the difference between a good C1 essay and a long B2 one.',
    ],
  ),
  'c1-p2-proposal': WritingModel(
    text:
        'Proposal: increasing participation in evening activities\n\n'
        'Introduction\n'
        'This proposal examines why attendance at evening activities has '
        'remained low and recommends three changes for the coming term.\n\n'
        'The current situation\n'
        'Attendance averages around twelve students per session, out of a '
        'student body of more than two hundred. Informal conversations point '
        'to three causes: activities are announced only on the noticeboard by '
        'the main office; they begin at 19:00, when many students are still '
        'travelling back from work placements; and the programme has been '
        'essentially unchanged for two years.\n\n'
        'Recommendations\n'
        'First, announcements should move to the channel students actually '
        'use. A weekly message in the existing class groups would reach '
        'almost everyone at no cost.\n\n'
        'Second, I would suggest starting at 18:00 on two evenings and 20:00 '
        'on the others. Splitting the timetable in this way accommodates both '
        'those who finish early and those who cannot arrive before eight.\n\n'
        'Third, students should be invited to propose and lead one activity '
        'each term. Attendance rises sharply when the person running the '
        'session is somebody you know, and it costs the centre nothing '
        'beyond the room. Two students have already offered to run a '
        'conversation evening and a film club, which suggests there is no '
        'shortage of willingness — only of anyone having been asked.\n\n'
        'Conclusion\n'
        'Taken together, these measures address visibility, timing and '
        'ownership. I am confident that they would raise attendance '
        'substantially, and none of them requires additional funding.',
    why: [
      'A proposal argues for a future action; a report describes a present '
          'situation. This one diagnoses briefly and then spends most of its '
          'length on what to do — the right balance for the text type.',
      'Every recommendation carries its justification in the same '
          'paragraph, and two of them end by removing the obvious objection '
          '(“at no cost”, “costs the centre nothing”).',
      'Formal but not stiff: “I would suggest”, “I am confident that”. A '
          'proposal has an author who is asking for something.',
      'The conclusion names the three themes in three words. Summarising by '
          'abstraction, rather than by repetition, is a C1 move.',
    ],
  ),
  'c1-p2-letter': WritingModel(
    text:
        'Dear Sir or Madam,\n\n'
        'I am writing with reference to the Advanced Project Management '
        'course held from 3 to 5 October, which I attended and which was '
        'cancelled halfway through the second day.\n\n'
        'I appreciate that the trainer’s illness was outside your control, '
        'and I do not question the decision to stop. My concern is with what '
        'followed. No alternative date has been offered, and the refund '
        'proposed amounts to one third of the fee, although barely half the '
        'course was delivered.\n\n'
        'I should like to make two points. First, your published terms state '
        'that participants are entitled to a full refund where a course is '
        'not completed, and I should be grateful if you would explain how the '
        'figure of one third was arrived at. Second, I travelled from another '
        'city and paid for two nights’ accommodation on the strength of the '
        'published dates. I am not asking you to cover that cost, but it '
        'ought to form part of any judgement about what is reasonable '
        'here. I would add that no course materials were issued for the '
        'sessions that did take place, so I am left with neither the '
        'training nor a record of it.\n\n'
        'I would gladly accept a place on the next available course in place '
        'of a refund, should one be scheduled before the end of the year.\n\n'
        'I look forward to hearing from you within fourteen days.\n\n'
        'Yours faithfully,',
    why: [
      'Firm without being rude, which is the whole difficulty of this task. '
          'Conceding what is genuinely not their fault in paragraph two makes '
          'the complaint in paragraph three much harder to dismiss.',
      'The demands are numbered and each is supported — the published terms, '
          'and the money already spent. A complaint with a reason attached is '
          'an argument; one without is a mood.',
      'Formal register held to the end: “with reference to”, “I should be '
          'grateful if you would”, inversion in “should one be scheduled”, '
          'and “Yours faithfully” to match “Dear Sir or Madam”.',
      'It offers a way out and sets a deadline. Both are what turns a letter '
          'into something that gets answered.',
    ],
  ),
};
