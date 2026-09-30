/// English practice with an explanation attached to every item.
///
/// The exercises are written here, not copied from a workbook: that way they
/// can be repeated endlessly without using up the paper, and each one explains
/// *why* the answer is the answer — which is exactly what a workbook does not
/// give you when you get it wrong.
///
/// Paper and this are not competing. On paper you sit the whole thing, timed,
/// like the real day. Here you drill the one point that keeps catching you.
library;

import 'cambridge.dart';
import 'practice_data.dart';

enum ExerciseType {
  /// Several options, one correct.
  choice,

  /// Write the missing word or words.
  write,

  /// Cambridge Part 4 style: rewrite using the word given.
  transformation,
}

class Topic {
  const Topic(this.id, this.name, this.blurb, {this.level = ExamLevel.b2});
  final String id;
  final String name;
  final String blurb;

  /// Topics above your goal stay hidden: they are not wrong, just a waste of
  /// your time until you get there.
  final ExamLevel level;
}

const List<Topic> topics = [
  Topic(
    'perfect',
    'Present perfect',
    'Simple versus continuous.',
    level: ExamLevel.b1,
  ),
  Topic(
    'pasado',
    'Past simple and continuous',
    'What was happening, and what happened.',
    level: ExamLevel.b1,
  ),
  Topic(
    'futuro',
    'Future forms',
    'will, going to and the present for plans.',
    level: ExamLevel.b1,
  ),
  Topic(
    'passive',
    'Passive voice',
    'When and how to turn the sentence round.',
    level: ExamLevel.b1,
  ),
  Topic(
    'comparativos',
    'Comparatives and superlatives',
    'More than, the most, as… as.',
    level: ExamLevel.b1,
  ),
  Topic(
    'cuantificadores',
    'Quantifiers',
    'some, any, much, many, a few, a little.',
    level: ExamLevel.b1,
  ),
  Topic(
    'gerundios',
    'Gerunds and infinitives',
    'Which verbs take -ing and which take to.',
    level: ExamLevel.b1,
  ),
  Topic(
    'usedto',
    'used to · be used to · get used to',
    'Three lookalike structures that mean different things.',
  ),
  Topic(
    'especular',
    'Speculating',
    'must be, might be, can\'t be: deduction with modals.',
  ),
  Topic(
    'contrastar',
    'Comparing and contrasting',
    'The linkers you need for Speaking Part 2.',
  ),
  Topic(
    'transformar',
    'Key word transformations',
    'Use of English Part 4, where the easiest marks are.',
  ),
  Topic(
    'formacion',
    'Word formation',
    'Prefixes and suffixes: Use of English Part 3.',
  ),
  Topic(
    'condicionales',
    'Conditionals and wishes',
    'The three types, plus mixed ones and I wish / if only.',
    level: ExamLevel.b1,
  ),
  Topic(
    'reportado',
    'Reported speech',
    'Backshift, and the verbs that report without say or tell.',
  ),
  Topic(
    'relativas',
    'Relative clauses',
    'Which, that, whose, and when the comma changes the meaning.',
    level: ExamLevel.b1,
  ),
  Topic(
    'modales',
    'Modals',
    'Obligation, permission and regret about the past.',
    level: ExamLevel.b1,
  ),
  Topic(
    'preposiciones',
    'Prepositions and articles',
    'The small words that Part 2 of Use of English lives on.',
    level: ExamLevel.b1,
  ),
  Topic(
    'phrasal',
    'Phrasal verbs',
    'The ones Cambridge keeps coming back to.',
    level: ExamLevel.b1,
  ),
  Topic(
    'colocaciones',
    'Collocations',
    'Which words keep company: make, do, take, have.',
    level: ExamLevel.b1,
  ),
  Topic(
    'conectores',
    'Linking and cohesion',
    'The glue that Part 6 and the Writing paper are marked on.',
  ),
  Topic(
    'inversion',
    'Inversion and emphasis',
    'Never have I…, Not only…, No sooner… — C1 territory.',
    level: ExamLevel.c1,
  ),
  Topic(
    'matiz',
    'Nuance and hedging',
    'Saying something is probably true without saying it plainly.',
    level: ExamLevel.c1,
  ),
  Topic(
    'participio',
    'Participle clauses',
    'Having finished…, Given that…: two clauses in the space of one.',
    level: ExamLevel.c1,
  ),
  Topic(
    'idioms',
    'Idioms and fixed expressions',
    'Word for word, or wrong: what Part 1 of the Advanced paper is made of.',
    level: ExamLevel.c1,
  ),
  Topic(
    'registro',
    'Register and formality',
    'The same thing said to a friend, to a manager and in a report.',
    level: ExamLevel.c1,
  ),
];

class Exercise {
  const Exercise({
    required this.id,
    required this.topic,
    this.level = ExamLevel.b2,
    required this.prompt,
    required this.correct,
    required this.explanation,
    this.type = ExerciseType.choice,
    this.options = const [],
    this.hint,
    this.alternatives = const [],
  });

  final String id;
  final String topic;

  /// The level this item belongs to. You see everything at or below your
  /// goal, so a C1 candidate still drills the B1 and B2 material.
  final ExamLevel level;

  /// The sentence, with `___` marking the gap.
  final String prompt;

  final ExerciseType type;
  final List<String> options;

  final String correct;

  /// Other forms that are also accepted.
  final List<String> alternatives;

  /// Why that one and not another. This is the whole point of the app.
  final String explanation;

  /// A nudge before giving up and looking.
  final String? hint;

  bool accepts(String respuesta) {
    final dada = _limpia(respuesta);
    if (dada.isEmpty) return false;
    return dada == _limpia(correct) ||
        alternatives.any((a) => _limpia(a) == dada);
  }
}

String _limpia(String s) => s
    .toLowerCase()
    .replaceAll('’', "'")
    .replaceAll(RegExp(r"[^a-z0-9\s'\-]"), '')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

/// The exercises of a topic, filtered by what you are aiming at.
List<Exercise> exercisesFor(String topic, {ExamLevel? goal}) => exercises
    .where((e) => e.topic == topic)
    .where((e) => goal == null || e.level.index <= goal.index)
    .toList();

int countFor(String topic, {ExamLevel? goal}) =>
    exercisesFor(topic, goal: goal).length;

/// Every exercise that counts towards a given goal.
List<Exercise> exercisesForGoal(ExamLevel goal) =>
    exercises.where((e) => e.level.index <= goal.index).toList();

/// The topics worth showing for a goal.
/// The exercises behind a set of ids, in the order the deck is drilled.
///
/// Ids that no longer match anything are skipped: an exercise removed in an
/// update should not leave a hole in someone's review deck.
List<Exercise> exercisesByIds(Set<String> ids) =>
    exercises.where((e) => ids.contains(e.id)).toList();

List<Topic> topicsForGoal(ExamLevel goal) =>
    topics.where((t) => t.level.index <= goal.index).toList();
