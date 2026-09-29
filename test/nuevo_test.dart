/// Tests for what was added in 1.1: the exam names, the review deck, the
/// backup, the word bank and the writing models.
///
/// The state tests use SharedPreferences' in-memory mock, so they exercise
/// the real save-and-reload path rather than the fields in isolation — which
/// is where the bugs in this kind of code actually live.
library;

import 'dart:convert';
import 'dart:io';

import 'package:cil/brand.dart';
import 'package:cil/cambridge.dart';
import 'package:cil/cambridge_data.dart';
import 'package:cil/practice.dart';
import 'package:cil/practice_data.dart';
import 'package:cil/state.dart';
import 'package:cil/vocab_data.dart';
import 'package:cil/writing_data.dart';
import 'package:cil/writing_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('exam names', () {
    test('both names are right and both are shown', () {
      expect(ExamLevel.b1.cefr, 'B1');
      expect(ExamLevel.b1.code, 'PET');
      expect(ExamLevel.b2.code, 'FCE');
      expect(ExamLevel.c1.code, 'CAE');

      for (final l in ExamLevel.values) {
        expect(l.chip, contains(l.cefr));
        expect(l.chip, contains(l.code));
        expect(l.full, contains(l.name));
        expect(l.full, contains(l.code));
      }
    });

    test('the saved key is the full name, and it still resolves', () {
      // El objetivo se guarda por `name`. Si alguien reescribe esas cadenas,
      // la meta de todo el mundo se pierde en silencio; esto lo impide.
      expect(ExamLevel.b1.name, 'B1 Preliminary');
      expect(ExamLevel.b2.name, 'B2 First');
      expect(ExamLevel.c1.name, 'C1 Advanced');
    });
  });

  group('version', () {
    test('the number on screen is the number in the APK', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final linea = pubspec
          .split('\n')
          .firstWhere((l) => l.startsWith('version:'));
      final enPubspec = linea.split(':')[1].trim().split('+').first;
      expect(cilVersion, enPubspec);
    });
  });

  group('the review deck', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    test('a wrong answer joins it and a right one leaves it', () async {
      final state = await AppState.open();
      expect(state.mistakes, isEmpty);

      await state.recordPractice('perfect', 'pp-1', false);
      expect(state.mistakes, contains('pp-1'));

      await state.recordPractice('perfect', 'pp-1', true);
      expect(state.mistakes, isEmpty);
    });

    test('it survives a restart', () async {
      final state = await AppState.open();
      await state.recordPractice('modales', 'mo-9', false);

      final otra = await AppState.open();
      expect(otra.mistakes, contains('mo-9'));
    });

    test('an id that no longer exists just drops out', () {
      final mazo = exercisesByIds({'b1-pp-1', 'no-existe'});
      expect(mazo, hasLength(1));
      expect(mazo.single.id, 'b1-pp-1');
    });
  });

  group('backup', () {
    setUp(() => SharedPreferences.setMockInitialValues({}));

    test('a round trip brings everything back', () async {
      final state = await AppState.open();
      await state.setGoal(ExamLevel.c1);
      await state.recordPractice('inversion', 'c1-in-1', false);
      await state.saveAttempt(
        Attempt(
          id: '1',
          paperId: 'cil-1-use-of-english',
          date: DateTime(2026, 9, 20),
          responses: const {1: 'off', 2: 'in'},
          marks: 20,
          maxMarks: 36,
          minutes: 42,
        ),
      );
      await state.saveDraft('b2-p1-tech', 'a draft');

      final copia = state.exportarTodo();
      await state.clearAll();
      expect(state.attempts, isEmpty);
      expect(state.mistakes, isEmpty);

      expect(await state.importarTodo(copia), isTrue);
      expect(state.attempts, hasLength(1));
      expect(state.attempts.single.marks, 20);
      expect(state.attempts.single.responses[1], 'off');
      expect(state.mistakes, contains('c1-in-1'));
      expect(state.scoreFor('inversion'), (0, 1));
      expect(state.goal, ExamLevel.c1);
      expect(state.writingDraft('b2-p1-tech'), 'a draft');
    });

    test('something that is not a backup changes nothing', () async {
      final state = await AppState.open();
      await state.recordPractice('phrasal', 'ph-1', false);

      expect(await state.importarTodo('hello'), isFalse);
      expect(await state.importarTodo(jsonEncode({'x': 1})), isFalse);
      expect(state.mistakes, contains('ph-1'));
    });
  });

  group('writing models', () {
    test('every task has one, and it is the right length', () {
      for (final t in writingTasks) {
        final m = writingModels[t.id];
        expect(m, isNotNull, reason: '${t.id} has no model answer');
        // Cambridge cuenta las palabras de verdad: un modelo fuera de rango
        // enseña justo lo que hace perder marcas.
        final (low, high) = t.wordRange;
        expect(
          m!.words,
          inInclusiveRange(low - 10, high + 25),
          reason: '${t.id}: ${m.words} words, asked for $low-$high',
        );
        expect(m.why, isNotEmpty, reason: '${t.id} explains nothing');
      }
    });

    test('no model belongs to a task that does not exist', () {
      final ids = writingTasks.map((t) => t.id).toSet();
      for (final id in writingModels.keys) {
        expect(ids, contains(id));
      }
    });

    test('the four subscales are all there', () {
      expect(writingCriteria, hasLength(4));
      expect(
        writingCriteria.map((c) => c.name),
        containsAll(<String>[
          'Content',
          'Communicative Achievement',
          'Organisation',
          'Language',
        ]),
      );
    });
  });

  group('word bank', () {
    test('ids are unique and nothing is blank', () {
      final ids = vocabSets.map((s) => s.id).toList();
      expect(ids.toSet(), hasLength(ids.length));

      for (final s in vocabSets) {
        expect(s.entries, isNotEmpty);
        for (final e in s.entries) {
          expect(e.term.trim(), isNotEmpty);
          expect(e.meaning.trim(), isNotEmpty);
          expect(
            e.example.trim(),
            isNotEmpty,
            reason:
                '${e.term} has no '
                'sentence, and a word without one cannot be used',
          );
        }
      }
    });

    test('a B1 candidate is never shown C1 sets', () {
      final b1 = vocabForGoal(ExamLevel.b1);
      expect(b1, isNotEmpty);
      expect(b1.every((s) => s.level == ExamLevel.b1), isTrue);
      expect(vocabForGoal(ExamLevel.c1).length, greaterThan(b1.length));
    });
  });

  group('papers', () {
    test('an attempt finds its paper again by id', () {
      expect(paperById('cil-1-use-of-english')?.name, isNotNull);
      expect(paperById('nada-de-nada'), isNull);
    });

    test('a listening paper either brings the audio or says where it is', () {
      for (final p in cambridgePapers.where((p) => p.name == 'Listening')) {
        expect(
          p.audio.isNotEmpty || p.audioFrom != null,
          isTrue,
          reason: '${p.id} has neither audio nor anywhere to get it',
        );
      }
    });
  });

  group('C1 content', () {
    test('there is enough of it to be worth choosing C1', () {
      final c1 = exercises.where((e) => e.level == ExamLevel.c1);
      expect(c1.length, greaterThanOrEqualTo(40));
    });

    test('every C1 topic has exercises behind it', () {
      for (final t in topics.where((t) => t.level == ExamLevel.c1)) {
        expect(
          exercises.where((e) => e.topic == t.id),
          isNotEmpty,
          reason: 'the topic "${t.name}" is offered but has nothing in it',
        );
      }
    });
  });
}
