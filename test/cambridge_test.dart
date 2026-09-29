import 'package:cil/cambridge.dart';
import 'package:cil/cambridge_guide.dart';
import 'package:cil/cambridge_tasks.dart';
import 'package:cil/cambridge_data.dart';
import 'package:cil/practice.dart';
import 'package:cil/practice_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cambridge answer keys', () {
    test('accepts slash-separated variants', () {
      expect(isCorrect('off', 'off/out/sail'), isTrue);
      expect(isCorrect('sail', 'off/out/sail'), isTrue);
      expect(isCorrect('on', 'off/out/sail'), isFalse);
    });

    test('anything in brackets is optional', () {
      expect(isCorrect('sunrise', 'sun(-)rise'), isTrue);
      expect(isCorrect('sun-rise', 'sun(-)rise'), isTrue);
    });

    test('ignores case and stray whitespace', () {
      expect(isCorrect('  January ', 'January'), isTrue);
      expect(isCorrect('INTERNET', 'internet'), isTrue);
    });

    test('an empty answer never scores', () {
      expect(isCorrect('', 'took'), isFalse);
      expect(isCorrect('   ', 'took'), isFalse);
    });
  });

  group('marking a paper', () {
    final reading = cambridgePapers.firstWhere((p) => p.id == 'b2-sp2-reading');

    test('the maximum equals the real exam', () {
      // Parts 1-3: 24 x 1. Part 4: 6 x 2. Parts 5-6: 12 x 2. Part 7: 10 x 1.
      expect(reading.maxMarks, 24 + 12 + 24 + 10);
      expect(reading.questions, 52);
    });

    test('answering with the key gives full marks on ordinary parts', () {
      final todas = <int, String>{};
      for (final part in reading.parts) {
        if (part.type == AnswerType.transformation) continue;
        for (var q = part.from; q <= part.to; q++) {
          todas[q] = part.answers[q]!.split('/').first;
        }
      }
      for (final r in markPaper(reading, todas)) {
        if (r.part.type == AnswerType.transformation) continue;
        expect(
          r.marks,
          r.part.maxMarks,
          reason:
              'part ${r.part.number} does not reach full marks with its key',
        );
      }
    });

    test('transformations score with a realistic answer', () {
      // Written the way a candidate would write them, not copied from the key:
      // the only way to check the comparer actually works.
      final res = markPaper(reading, {
        25: 'am looking forward to hearing',
        26: 'see the point in buying',
        27: 'was not as expensive',
        28: 'wish that I could come',
        29: 'completely sold out of the',
        30: 'did not mean to delete',
      });
      final part4 = res.firstWhere(
        (r) => r.part.type == AnswerType.transformation,
      );
      expect(part4.marks, part4.part.maxMarks, reason: 'wrong: ${part4.wrong}');
    });

    test('a blank sheet scores zero and flags everything wrong', () {
      final res = markPaper(reading, {});
      expect(res.fold<int>(0, (n, r) => n + r.marks), 0);
      expect(res.fold<int>(0, (n, r) => n + r.wrong.length), reading.questions);
    });

    test('half a transformation earns one of the two marks', () {
      final parte4 = reading.parts.firstWhere((p) => p.number == 4);
      // The key is "looking forward | to hearing": only the first half here.
      final res = markPaper(reading, {25: 'looking forward'});
      final r4 = res.firstWhere((r) => r.part == parte4);
      expect(r4.marks, 1, reason: 'half a sentence has to score');
    });
  });

  group('practice exercises', () {
    test('identifiers are unique', () {
      final ids = exercises.map((e) => e.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('every multiple choice includes its correct answer', () {
      for (final e in exercises.where((e) => e.type == ExerciseType.choice)) {
        expect(
          e.options,
          contains(e.correct),
          reason: '"${e.id}" does not offer the right answer among the options',
        );
        expect(e.options.length, greaterThanOrEqualTo(3));
      }
    });

    test('every exercise has a known topic and explains why', () {
      final ids = topics.map((t) => t.id).toSet();
      for (final e in exercises) {
        expect(ids, contains(e.topic), reason: '"${e.id}" has an orphan topic');
        expect(
          e.explanation.length,
          greaterThan(40),
          reason: '"${e.id}" no explica lo suficiente',
        );
      }
    });

    test('the gap is marked in the prompt', () {
      for (final e in exercises) {
        expect(e.prompt, contains('___'), reason: e.id);
      }
    });

    test('cada ejercicio se accepts con su propia respuesta', () {
      for (final e in exercises) {
        expect(e.accepts(e.correct), isTrue, reason: e.id);
      }
    });
  });

  group('guide and glossary', () {
    test('every task type explains, illustrates and justifies', () {
      for (final t in taskTypes) {
        expect(t.whatItIs.length, greaterThan(60), reason: t.id);
        expect(t.whatItTests.length, greaterThan(40), reason: t.id);
        expect(t.example.trim(), isNotEmpty, reason: t.id);
        expect(t.why.length, greaterThan(40), reason: t.id);
      }
    });

    test('glossary identifiers are unique', () {
      final ids = taskTypes.map((t) => t.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('the guide covers the four papers and C1', () {
      final titulos = cambridgeGuide.map((b) => b.title).join(' · ');
      for (final esperado in [
        'Reading and Use of English',
        'Writing',
        'Listening',
        'Speaking',
        'C1 Advanced',
      ]) {
        expect(titulos, contains(esperado));
      }
    });

    test('no guide section is left empty', () {
      for (final b in cambridgeGuide) {
        expect(b.sections, isNotEmpty, reason: b.title);
        for (final s in b.sections) {
          expect(s.body.length, greaterThan(50), reason: s.title);
        }
      }
    });
  });

  group('C1 Advanced', () {
    final c1 = papersFor(ExamLevel.c1)
        .firstWhere((p) => p.id.contains('reading'));

    test('the structure matches the handbook: 8 parts, 56 questions', () {
      expect(c1.parts.length, 8);
      expect(c1.questions, 56);
      expect(c1.minutes, 90);
      // Parts 1-3: 24x1. Part 4: 6x2. Parts 5 and 7: 12x2. Part 6: 4x2.
      // Part 8: 10x1.
      expect(c1.maxMarks, 24 + 12 + 24 + 8 + 10);
    });

    test('Part 6 is the one that does not exist at B2', () {
      final p6 = c1.parts.firstWhere((p) => p.number == 6);
      expect(p6.name, contains('Cross-text'));
      expect(p6.questions, 4);

      final b2 = papersFor(ExamLevel.b2)
          .firstWhere((p) => p.id.contains('reading'));
      expect(
        b2.parts.any((p) => p.name.contains('Cross-text')),
        isFalse,
        reason: 'that task should not appear at B2',
      );
    });

    test('toda pregunta tiene clave en los dos niveles', () {
      for (final paper in cambridgePapers.where((p) => p.selfMarked)) {
        for (final part in paper.parts) {
          for (var q = part.from; q <= part.to; q++) {
            expect(
              part.answers[q],
              isNotNull,
              reason: '${paper.id} part ${part.number}: question $q has no key',
            );
          }
        }
      }
    });

    test('C1 transformations score with realistic answers', () {
      final res = markPaper(c1, {
        25: 'you give a clear explanation of',
        26: 'is alleged to have damaged',
        27: 'makes no difference to me',
        28: "had not been for Joe's",
        29: 'do whatever it takes',
        30: 'was withdrawn in the light of',
      });
      final p4 = res.firstWhere((r) => r.part.number == 4);
      expect(p4.marks, p4.part.maxMarks, reason: 'wrong: ${p4.wrong}');
    });

    test('C1 Listening splits 30 questions across four parts', () {
      final oido = papersFor(ExamLevel.c1)
          .firstWhere((p) => p.id.contains('listening'));
      expect(oido.questions, 30);
      expect(oido.maxMarks, 30);
      // Part 4 is two parallel tasks over the same five speakers.
      expect(oido.parts.last.questions, 10);
    });
  });

  group('practice content', () {
    test('there is enough of it to be worth opening', () {
      expect(exercises.length, greaterThanOrEqualTo(80));
      for (final t in topics) {
        expect(
          exercisesFor(t.id, goal: ExamLevel.c1),
          isNotEmpty,
          reason: 'topic "${t.id}" has no exercises',
        );
      }
    });

    test('a goal never shows material above it', () {
      for (final goal in ExamLevel.values) {
        for (final e in exercisesForGoal(goal)) {
          expect(
            e.level.index,
            lessThanOrEqualTo(goal.index),
            reason: '${e.id} is above a $goal goal',
          );
        }
        for (final t in topicsForGoal(goal)) {
          expect(t.level.index, lessThanOrEqualTo(goal.index), reason: t.id);
        }
      }
    });

    test('every level has something to practise', () {
      for (final goal in ExamLevel.values) {
        expect(
          exercisesForGoal(goal).length,
          greaterThanOrEqualTo(15),
          reason: 'a $goal candidate would open an almost empty app',
        );
        expect(topicsForGoal(goal), isNotEmpty, reason: '$goal');
      }
    });

    test('aiming higher adds material rather than replacing it', () {
      expect(
        exercisesForGoal(ExamLevel.b1).length,
        lessThan(exercisesForGoal(ExamLevel.b2).length),
      );
      expect(
        exercisesForGoal(ExamLevel.b2).length,
        lessThan(exercisesForGoal(ExamLevel.c1).length),
      );
    });

    test('a C1 goal shows absolutely everything', () {
      expect(exercisesForGoal(ExamLevel.c1).length, exercises.length);
    });

    test('every C1 topic actually holds C1 items', () {
      for (final t in topics.where((t) => t.level == ExamLevel.c1)) {
        expect(
          exercisesFor(
            t.id,
            goal: ExamLevel.c1,
          ).any((e) => e.level == ExamLevel.c1),
          isTrue,
          reason: '"${t.id}" is flagged C1 but has no C1 exercises',
        );
      }
    });
  });

  group('paper sources', () {
    test('every part says what a valid answer looks like', () {
      for (final paper in cambridgePapers.where((p) => p.selfMarked)) {
        for (final part in paper.parts) {
          expect(
            part.howToAnswer,
            isNotNull,
            reason: '${paper.id} part ${part.number} gives no answering rule',
          );
        }
      }
    });

    test('official papers point at the booklet and carry no text', () {
      final oficiales = cambridgePapers.where(
        (p) => p.source == PaperSource.official && p.selfMarked,
      );
      expect(oficiales, isNotEmpty);
      for (final paper in oficiales) {
        expect(paper.whereToFind, isNotNull, reason: paper.id);
        for (final part in paper.parts) {
          expect(
            part.passage,
            isNull,
            reason: '${paper.id} must not reproduce Cambridge text',
          );
          expect(part.items, isEmpty, reason: paper.id);
        }
      }
    });

    test('our own paper carries its own text and every question', () {
      final propio = cambridgePapers.firstWhere(
        (p) => p.id == 'cil-1-use-of-english',
      );
      expect(propio.whereToFind, isNull);
      expect(propio.questions, 30);
      for (final part in propio.parts) {
        expect(
          part.items.length,
          part.questions,
          reason: 'part ${part.number} is missing questions',
        );
        for (var q = part.from; q <= part.to; q++) {
          expect(part.itemFor(q), isNotNull, reason: 'question $q missing');
        }
        // Las partes de cloze necesitan su texto; las transformaciones no.
        if (part.type != AnswerType.transformation) {
          expect(part.passage, isNotNull, reason: 'part ${part.number}');
        }
      }
    });

    test('our own multiple choice offers as many options as letters used', () {
      final propio = cambridgePapers.firstWhere(
        (p) => p.id == 'cil-1-use-of-english',
      );
      for (final part in propio.parts.where(
        (p) => p.type == AnswerType.choice,
      )) {
        for (final item in part.items) {
          final clave = part.answers[item.number]!;
          final indice = clave.codeUnitAt(0) - 65;
          expect(
            indice,
            lessThan(item.options.length),
            reason: 'question ${item.number}: key $clave has no option',
          );
        }
      }
    });

    test('our own paper marks itself to full marks with its key', () {
      final propio = cambridgePapers.firstWhere(
        (p) => p.id == 'cil-1-use-of-english',
      );
      final todas = <int, String>{};
      for (final part in propio.parts) {
        if (part.type == AnswerType.transformation) continue;
        for (var q = part.from; q <= part.to; q++) {
          todas[q] = part.answers[q]!.split('/').first;
        }
      }
      for (final r in markPaper(propio, todas)) {
        if (r.part.type == AnswerType.transformation) continue;
        expect(r.marks, r.part.maxMarks, reason: 'part ${r.part.number}');
      }
    });
  });
}
