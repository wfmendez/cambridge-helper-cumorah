/// Model answers, and what the examiner is actually marking.
///
/// Written for Cíl, not taken from a Cambridge paper: their sample answers
/// are theirs. These are deliberately good rather than perfect — an answer
/// that reads as though nobody could write it teaches nothing.
///
/// They are hidden until you ask for them. A model answer read before you
/// write is not a model, it is the answer.
library;

part 'writing_extra_models.dart';

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
  ...extraWritingModels,
  'b1-p1-weekend': WritingModel(
    text:
        'Hi Alex,\n\n'
        'Ten on Saturday is perfect. I will meet you outside the station, '
        'near the ticket office.\n\n'
        'Why don’t we visit the lake? We can hire bikes and ride around it. '
        'You love taking photos, so I think you will enjoy the view. Bring '
        'your camera and a jacket because it sometimes gets cold there. '
        'We can buy lunch at the little café by the water.\n\n'
        'Unfortunately, you cannot stay overnight because my cousins are '
        'using our spare room. Could you take the evening train instead?\n\n'
        'See you soon!\nChris',
    why: [
      'All four notes receive a clear response.',
      'The suggested activity is supported by a personal reason.',
      'Short paragraphs and a friendly question make the email easy to follow.',
    ],
  ),
  'b1-p2-hobby': WritingModel(
    text:
        'A little garden, a big surprise\n\n'
        'Do you think gardening is only for people with huge gardens? '
        'I grow vegetables on our tiny balcony, and I love it.\n\n'
        'I started last spring when my grandmother gave me some tomato '
        'seeds. At first, I forgot to water them. Now I check my plants '
        'every morning before school. Last week we ate our first tomatoes!\n\n'
        'Gardening helps me relax after studying, and it is exciting to '
        'watch something grow. You do not need expensive equipment. Try '
        'putting a few seeds in an old container near a sunny window. '
        'You might surprise yourself.',
    why: [
      'The opening question includes the reader.',
      'The article covers the hobby, how it began and reasons to try it.',
      'Past and present tenses have clear jobs; vocabulary stays manageable at B1.',
    ],
  ),
  'b1-p2-story': WritingModel(
    text:
        'When I opened the bag, I knew it was not mine. '
        'Instead of my swimming things, I found a pair of dancing shoes.\n\n'
        'I had just left the sports centre, so I ran back. At the door, '
        'a girl was looking worried. She was carrying a blue bag exactly '
        'like mine.\n\n'
        '“Are you missing some shoes?” I asked. She laughed and showed '
        'me my towel. We had picked up the wrong bags in the changing room.\n\n'
        'We swapped them and introduced ourselves. Now we always check '
        'our bags carefully, and sometimes we meet for a drink after training.',
    why: [
      'The required opening is used exactly.',
      'The problem is resolved and leads to a simple, satisfying ending.',
      'Past simple, past continuous and direct speech create a short narrative.',
    ],
  ),
  'b2-p2-article': WritingModel(
    text:
        'Dinner without a recipe disaster\n\n'
        'Ever stared into the fridge and wished you could turn its contents '
        'into a proper meal? That was me last summer, just before I decided '
        'to learn to cook.\n\n'
        'My first challenge was timing. I could cook rice and prepare '
        'vegetables, but never finish both together. Following online '
        'videos was frustrating because the presenter always seemed to '
        'move twice as fast as I did.\n\n'
        'The solution was surprisingly simple: I read the whole recipe '
        'first and prepared everything before switching on the cooker. '
        'I also chose one easy dish and repeated it until I understood '
        'what each step was doing. A vegetable curry became my speciality.\n\n'
        'If you want to try cooking, forget impressive dinner parties. '
        'Start with something you actually like eating, ask someone to '
        'taste it, and change one thing next time. Keep a notebook of '
        'what worked. You will make mistakes, but at least most of them '
        'will be edible!',
    why: [
      'An inviting title and direct questions suit a student magazine.',
      'A concrete difficulty leads to a practical solution.',
      'The ending gives advice the reader can act on, covering the last task point.',
    ],
  ),
  'c1-p2-review': WritingModel(
    text:
        'The Truman Show: looking beyond the screen\n\n'
        'Imagine discovering that your neighbours, your job and even your '
        'marriage exist primarily to entertain strangers. That is the '
        'disturbing premise of The Truman Show, a film whose cheerful '
        'surface conceals a remarkably sharp examination of control.\n\n'
        'Jim Carrey plays Truman with a warmth that makes the central '
        'deception feel personal rather than merely clever. Small '
        'disruptions in his apparently perfect town gradually expose '
        'the machinery behind it. The film wisely lets us notice these '
        'cracks before explaining them, making us participants in '
        'Truman’s growing uncertainty.\n\n'
        'Its greatest strength is the contrast between bright, reassuring '
        'images and the troubling choices they conceal. The television '
        'audience claims to love Truman while accepting the restrictions '
        'placed on his life. This contradiction raises questions about '
        'our own viewing habits without turning the dialogue into a '
        'lecture. Occasionally, the supporting characters seem too '
        'obviously artificial, although that weakness partly serves '
        'the film’s purpose.\n\n'
        'I would particularly recommend it to readers interested in '
        'social media and the boundaries between public performance '
        'and private experience. It was made before today’s platforms '
        'became familiar, yet its concerns feel immediately recognisable. '
        'Younger viewers may enjoy the escape story first and discover '
        'its ethical questions afterwards.\n\n'
        'This is an accessible, unsettling film that rewards discussion. '
        'Watch it with someone who disagrees with you about whether '
        'being constantly watched could ever be worth the comfort '
        'it appears to offer.',
    why: [
      'The review evaluates acting and visual choices instead of summarising the plot.',
      'A limitation makes the judgement balanced.',
      'The recommendation identifies an audience and explains its relevance.',
    ],
  ),
  'c1-p2-report': WritingModel(
    text:
        'Language exchange: first-month review\n\n'
        'Purpose\n'
        'This report evaluates the first four language-exchange sessions '
        'at the community centre and recommends changes intended to '
        'improve participation next month. It draws on attendance records '
        'and informal comments collected after each meeting.\n\n'
        'Successful features\n'
        'Participants particularly valued the welcoming atmosphere and '
        'the opportunity to practise with different partners. Short '
        'conversation cards helped newcomers begin speaking without '
        'extensive preparation. Several people returned with friends, '
        'suggesting that the format has the potential to attract '
        'a wider audience.\n\n'
        'Barriers to participation\n'
        'Attendance was less consistent among people finishing work '
        'late. Two participants explicitly mentioned the starting time; '
        'however, further feedback would be needed before attributing '
        'all absences to scheduling. Uneven language levels presented '
        'another difficulty. Confident speakers sometimes dominated '
        'the discussion, leaving beginners with limited opportunities '
        'to contribute. The room also became noticeably noisy when '
        'all groups were speaking at once.\n\n'
        'Recommendations\n'
        'The centre should trial a later start for two sessions and '
        'compare attendance before making a permanent change. A short '
        'registration question about confidence would help volunteers '
        'form suitable groups, while timed turns could make discussions '
        'more balanced. Dividing the room into smaller conversation '
        'areas would reduce competing noise without requiring '
        'additional equipment.\n\n'
        'Conclusion\n'
        'The exchange is worth continuing, provided its accessibility '
        'improves. These modest adjustments should be reviewed after '
        'another month, using both attendance figures and a brief '
        'anonymous questionnaire to assess their effect.',
    why: [
      'Headings make the purpose, findings and recommendations easy to locate.',
      'The writer distinguishes observed facts from a tentative explanation.',
      'Each practical recommendation responds to an identified problem.',
    ],
  ),
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
