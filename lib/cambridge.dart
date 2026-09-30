/// The exam model.
///
/// The goal is **C1 (CAE)**, but the mock on campus and the material at hand
/// are **B2 First (FCE)**. That is not a mistake: B2 is the step below and it
/// measures where you actually are. Sitting C1 needs CAE material, which is a
/// different exam at a different difficulty.
///
/// What lives here is the **structure** of the exam, the **answer key** and
/// your attempts. Not the text of the papers: that is Cambridge's copyrighted
/// material, and real practice happens on paper anyway. The app does what
/// paper cannot — time you, mark instantly, and keep track of where the marks
/// go.
library;

/// Where a paper comes from.
///
/// This matters for what the app is allowed to show. Cambridge's own papers
/// are copyrighted, so only the answer key lives here and you work from the
/// PDF. Papers written for Cíl carry their own text, so they can be sat
/// entirely on the phone.
enum PaperSource {
  official('Official Cambridge paper'),
  cil('Written for Cíl');

  const PaperSource(this.label);
  final String label;
}

/// One question as it appears on the page. Only Cíl's own papers carry these:
/// for official papers the text stays in the PDF.
class ExamItem {
  const ExamItem({
    required this.number,
    this.stem,
    this.options = const [],
    this.explanation,
  });

  final int number;

  /// The sentence or question, with `___` where the gap is.
  final String? stem;

  final List<String> options;

  /// Shown only after marking, with the evidence or language rule to review.
  final String? explanation;
}

/// The three exams in play, in the order you climb them. The order matters:
/// the app shows you everything at or below your goal, so aiming higher adds
/// material rather than replacing it.
/// The three exams, under both of their names.
///
/// Cambridge renamed these in 2019: PET, FCE and CAE became B1 Preliminary,
/// B2 First and C1 Advanced. Everybody still says the old names, and the new
/// ones are the ones a university or an employer asks for — so the app shows
/// both rather than picking a side and leaving the reader to guess.
enum ExamLevel {
  b1('B1', 'B1 Preliminary', 'PET'),
  b2('B2', 'B2 First', 'FCE'),
  c1('C1', 'C1 Advanced', 'CAE');

  const ExamLevel(this.cefr, this.name, this.code);

  /// 'B1' — the Council of Europe level. What the certificate is worth.
  final String cefr;

  /// 'B1 Preliminary' — what Cambridge calls the exam today.
  ///
  /// Also the key the chosen goal is saved under, so it cannot be reworded
  /// without resetting everyone's goal.
  final String name;

  /// 'PET' — the name until 2019, and still the one people say out loud.
  final String code;

  /// 'B1 · PET' — both, for a chip or a badge with no room for the rest.
  String get chip => '$cefr · $code';

  /// 'B1 Preliminary (PET)' — the full introduction.
  String get full => '$name ($code)';
}

enum AnswerType {
  /// A single letter: A, B, C, D…
  choice,

  /// One or more words you have to write yourself.
  word,

  /// Transformations: two halves, one mark each.
  transformation,
}

class ExamPart {
  const ExamPart({
    required this.number,
    required this.name,
    required this.from,
    required this.to,
    required this.type,
    required this.marksPerQuestion,
    required this.answers,
    this.blurb,
    this.howToAnswer,
    this.passage,
    this.items = const [],
  });

  final int number;
  final String name;

  /// Question range, numbered as in the exam itself.
  final int from;
  final int to;

  final AnswerType type;

  /// What each question in this part is worth.
  final int marksPerQuestion;

  /// Correct answers, keyed by question number.
  ///
  /// Where several forms are valid they are separated by `/` or by ` OR `,
  /// exactly as Cambridge publishes them.
  final Map<int, String> answers;

  final String? blurb;

  /// What a valid answer looks like here: one word, a letter A-C, up to three
  /// words. Without it the sheet is a column of numbers with no rules.
  final String? howToAnswer;

  /// The text to read. Only on Cíl's own papers.
  final String? passage;

  /// The questions themselves. Only on Cíl's own papers.
  final List<ExamItem> items;

  ExamItem? itemFor(int question) {
    for (final i in items) {
      if (i.number == question) return i;
    }
    return null;
  }

  int get questions => to - from + 1;
  int get maxMarks => questions * marksPerQuestion;
}

class ExamPaper {
  const ExamPaper({
    required this.id,
    required this.name,
    this.level = ExamLevel.b2,
    required this.minutes,
    required this.parts,
    this.file,
    this.audio = const [],
    this.selfMarked = true,
    this.note,
    this.source = PaperSource.official,
    this.whereToFind,
    this.audioFrom,
  });

  final String id;
  final String name;
  final ExamLevel level;
  final int minutes;
  final List<ExamPart> parts;

  /// Name of the PDF that holds this paper.
  final String? file;
  final List<String> audio;

  /// `false` for Writing and Speaking: no key, an examiner judges them.
  final bool selfMarked;

  final String? note;

  final PaperSource source;

  /// Where the text lives, for official papers. Nothing to hide: the app marks
  /// you, the booklet is what you read from.
  final String? whereToFind;

  /// Where the recording can be downloaded, for a Listening paper whose audio
  /// is not in the app.
  ///
  /// Cambridge gives the sample recordings away on its own site; what it does
  /// not do is let anyone else redistribute them. So the app sends you there
  /// rather than shipping the file.
  final String? audioFrom;

  /// A Listening paper with no recording bundled.
  bool get faltaAudio => audio.isEmpty && audioFrom != null;

  bool get traeTexto => source == PaperSource.cil;

  int get maxMarks => parts.fold<int>(0, (n, p) => n + p.maxMarks);
  int get questions => parts.fold<int>(0, (n, p) => n + p.questions);

  ExamPart? partFor(int pregunta) {
    for (final p in parts) {
      if (pregunta >= p.from && pregunta <= p.to) return p;
    }
    return null;
  }
}

/// Compares an answer against the Cambridge key.
///
/// A key can hold variants (`off/out/sail`) and whole alternatives
/// (`see the point | in/of buying OR see any point | (in) buying`). Anything
/// in brackets is optional: `sun(-)rise` accepts *sunrise* and *sun-rise*.
bool isCorrect(String respuesta, String clave) {
  final dada = _normalizar(respuesta);
  if (dada.isEmpty) return false;

  for (final alternativa in clave.split(' OR ')) {
    for (final variante in _variantes(alternativa)) {
      if (dada == variante) return true;
    }
  }
  return false;
}

/// Every form a key accepts, expanding `/` and the brackets.
Set<String> _variantes(String clave) {
  final expandidas = <String>{};
  for (final f in _sinBarras(clave.trim())) {
    expandidas.addAll(_sinParentesis(f));
  }
  return expandidas.map(_normalizar).where((f) => f.isNotEmpty).toSet();
}

/// Expands slashes word by word, not over the whole string.
///
/// This matters: `in/of buying` has to yield "in buying" and "of buying". Look
/// at the string as a whole and the slash stays glued on, matching nothing.
Set<String> _sinBarras(String text) {
  var salidas = <String>[''];
  for (final token in text.trim().split(RegExp(r'\s+'))) {
    final options = token.contains('/') ? token.split('/') : [token];
    final nuevas = <String>[];
    for (final s in salidas) {
      for (final o in options) {
        nuevas.add(s.isEmpty ? o : '$s $o');
      }
    }
    salidas = nuevas;
  }
  return salidas.toSet();
}

Set<String> _sinParentesis(String text) {
  final i = text.indexOf('(');
  if (i < 0) return {text};
  final j = text.indexOf(')', i);
  if (j < 0) return {text.replaceAll('(', '')};

  final antes = text.substring(0, i);
  final dentro = text.substring(i + 1, j);
  final despues = text.substring(j + 1);

  return {
    ..._sinParentesis('$antes$dentro$despues'),
    ..._sinParentesis('$antes$despues'),
  };
}

String _normalizar(String s) => s
    .toLowerCase()
    .replaceAll('’', "'")
    .replaceAll(RegExp(r'[^a-z0-9\s\-]'), '')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

/// One attempt at a paper: what you answered and what you scored.
///
/// The raw answers are stored alongside the score so you can go back to the
/// specific mistakes, not just the number.
class Attempt {
  const Attempt({
    required this.id,
    required this.paperId,
    required this.date,
    required this.responses,
    required this.marks,
    required this.maxMarks,
    this.minutes,
  });

  final String id;
  final String paperId;
  final DateTime date;

  /// Question number → what you wrote.
  final Map<int, String> responses;

  final int marks;
  final int maxMarks;

  /// How long you took, if you used the clock.
  final int? minutes;

  double get fraction => maxMarks == 0 ? 0 : marks / maxMarks;

  /// Cambridge passes B2 at around 60%. This is not the official scale —
  /// that converts to the *Cambridge English Scale* — but it is a fair guide.
  bool get passing => fraction >= 0.6;

  Map<String, dynamic> toJson() => {
    'id': id,
    'paper': paperId,
    'date': date.toIso8601String(),
    'responses': responses.map((k, v) => MapEntry(k.toString(), v)),
    'marks': marks,
    'maxMarks': maxMarks,
    'minutes': minutes,
  };

  static Attempt fromJson(Map<String, dynamic> j) => Attempt(
    id: j['id'] as String,
    paperId: j['paper'] as String,
    date: DateTime.parse(j['date'] as String),
    responses: ((j['responses'] as Map?) ?? {}).map(
      (k, v) => MapEntry(int.parse(k.toString()), v.toString()),
    ),
    marks: (j['marks'] as num).toInt(),
    maxMarks: (j['maxMarks'] as num).toInt(),
    minutes: (j['minutes'] as num?)?.toInt(),
  );
}

/// The result of marking one part.
class PartResult {
  const PartResult({
    required this.part,
    required this.marks,
    required this.wrong,
  });

  final ExamPart part;
  final int marks;

  /// Questions that did not come out right, in order.
  final List<int> wrong;

  double get fraction => part.maxMarks == 0 ? 0 : marks / part.maxMarks;
}

/// Marks a whole paper against its key.
///
/// Transformations score by halves, which is how Cambridge does it: getting
/// half the sentence right earns one of the two marks.
List<PartResult> markPaper(ExamPaper paper, Map<int, String> responses) {
  final out = <PartResult>[];

  for (final part in paper.parts) {
    var marks = 0;
    final wrong = <int>[];

    for (var q = part.from; q <= part.to; q++) {
      final earned = marksForAnswer(part, q, responses[q] ?? '');
      if (earned == null) continue;
      marks += earned;
      if (earned < part.marksPerQuestion) wrong.add(q);
    }
    out.add(PartResult(part: part, marks: marks, wrong: wrong));
  }
  return out;
}

/// Shared by the total score and the feedback beside each answer.
/// A missing key cannot be graded; it must not appear as a correct answer.
int? marksForAnswer(ExamPart part, int question, String response) {
  final key = part.answers[question];
  if (key == null) return null;
  if (part.type == AnswerType.transformation) {
    return _puntosTransformacion(response, key);
  }
  return isCorrect(response, key) ? part.marksPerQuestion : 0;
}

/// A transformation is two halves split by `|`, one mark each.
int _puntosTransformacion(String respuesta, String clave) {
  if (_normalizar(respuesta).isEmpty) return 0;

  var best = 0;
  for (final alternativa in clave.split(' OR ')) {
    final mitades = alternativa.split('|');
    if (mitades.length != 2) {
      if (isCorrect(respuesta, alternativa)) return 2;
      continue;
    }
    final dada = _normalizar(respuesta);
    var ganados = 0;
    for (final mitad in mitades) {
      if (_variantes(mitad).any((v) => ' $dada '.contains(' $v '))) {
        ganados++;
      }
    }
    if (ganados == 2) return 2;
    if (ganados > best) best = ganados;
  }
  return best;
}
