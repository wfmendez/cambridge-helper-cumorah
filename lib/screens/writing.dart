import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../disposicion.dart';

import 'package:flutter/services.dart';

import '../cambridge.dart';
import '../brand.dart';
import '../cambridge_theme.dart';
import '../state.dart';
import '../widgets.dart';
import '../writing_data.dart';
import '../writing_models.dart';
import '../writing_review.dart';
import '../encouragement.dart';
import 'writing_feedback.dart';

/// Pick a task first. An empty editor teaches nothing — the exam is a response
/// to a prompt, and half the marks live in whether you answered the prompt.
///
/// A screen with its own bar, for when this is opened from a mock test. The
/// same list without the bar is [WritingBody], which is what the Writing tab
/// shows — there the app's own header is already on screen and a second one
/// under it would only take room.
class WritingScreen extends StatelessWidget {
  const WritingScreen({super.key, required this.level});

  final ExamLevel level;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text('Writing · ${level.name}')),
    body: WritingBody(level: level),
  );
}

class WritingBody extends StatelessWidget {
  const WritingBody({super.key, required this.level});

  final ExamLevel level;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tasks = writingTasksFor(level);

    return Pagina(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        Centrado(
          ancho: anchoLectura,
          child: ContentCard(
            color: cambridgePurple.withValues(alpha: 0.07),
            border: cambridgePurple.withValues(alpha: 0.3),
            child: Text(
              level == ExamLevel.b1
                  ? 'Two tasks of about 100 words in 45 minutes. Part 1 is '
                        'an email; in Part 2 choose an article or a story.'
                  : level == ExamLevel.c1
                  ? 'Two tasks of 220–260 words in 90 minutes. Part 1 is '
                        'compulsory; Part 2 you choose.'
                  : 'Two tasks of 140–190 words in 80 minutes. Part 1 is '
                        'compulsory; Part 2 you choose.',
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
          ),
        ),
        Seccion(
          titulo: TituloMarcado(
            'Part 1 · compulsory',
            color: cambridgeReadable(cambridgePurple, theme.colorScheme),
          ),
          children: [
            for (final t in tasks.where((t) => t.isCompulsory))
              _TaskRow(task: t),
          ],
        ),
        Seccion(
          titulo: TituloMarcado(
            'Part 2 · choose one',
            color: cambridgeReadable(cambridgePurple, theme.colorScheme),
          ),
          children: [
            for (final t in tasks.where((t) => !t.isCompulsory))
              _TaskRow(task: t),
          ],
        ),
      ],
    );
  }
}

class _TaskRow extends StatelessWidget {
  const _TaskRow({required this.task});

  final WritingTask task;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colour = cambridgeReadable(cambridgePurple, theme.colorScheme);

    return ContentCard(
      border: colour.withValues(alpha: 0.35),
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => WritingEditor(task: task))),
      child: Row(
        children: [
          Container(width: 4, height: 34, color: colour),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.kind.label, style: theme.textTheme.titleSmall),
                const SizedBox(height: 3),
                Text(
                  task.question,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

/// The editor: the task on top, a live word count, and a clock.
///
/// The word count is the point. At B2 you need 140–190 words and at C1
/// 220–260, and almost nobody can judge that by eye — people write 110 words
/// and think they are finished. The draft saves as you type.
class WritingEditor extends StatefulWidget {
  const WritingEditor({super.key, required this.task, this.reviewClient});

  final WritingTask task;
  final WritingReviewClient? reviewClient;

  @override
  State<WritingEditor> createState() => _WritingEditorState();
}

class _WritingEditorState extends State<WritingEditor> {
  final _text = TextEditingController();
  Timer? _tick;
  Timer? _save;
  int _seconds = 0;
  bool _running = false;
  bool _taskOpen = true;
  final _hojaKey = GlobalKey();
  final _editorKey = GlobalKey();
  late final WritingReviewClient _reviewClient;
  late AppState _state;
  bool _loaded = false;
  bool _reviewing = false;
  String? _reviewError;
  WritingFeedback? _feedback;
  String? _reviewedText;
  final _feedbackSounds = FeedbackSounds();

  (int, int) get _limits => widget.task.wordRange;

  int get _minutes => widget.task.minutes;

  @override
  void initState() {
    super.initState();
    _reviewClient = widget.reviewClient ?? WritingReviewClient();
    _text.addListener(_onType);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loaded = true;
      final saved = _state.writingDraft(widget.task.id);
      if (saved != null && saved.isNotEmpty) {
        _text.text = saved;
        setState(() => _taskOpen = false);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = AppScope.of(context);
  }

  @override
  void dispose() {
    _tick?.cancel();
    _save?.cancel();
    // Al volver atrás no perder los últimos dos segundos del borrador.
    if (_loaded) unawaited(_state.saveDraft(widget.task.id, _text.text));
    _reviewClient.close();
    _feedbackSounds.dispose();
    _text.dispose();
    super.dispose();
  }

  Future<void> _review() async {
    if (_reviewing) return;
    final submitted = _text.text.trim();
    if (_feedback != null && _reviewedText == submitted) {
      _showFeedback(_feedback!, submitted);
      return;
    }
    setState(() {
      _reviewing = true;
      _reviewError = null;
    });
    _save?.cancel();
    try {
      await _state.saveDraft(widget.task.id, _text.text);
      final feedback = await _reviewClient.review(widget.task.id, submitted);
      if (!mounted) return;
      setState(() {
        _feedback = feedback;
        _reviewedText = submitted;
      });
      unawaited(
        _feedbackSounds.play(enabled: _state.profile.sounds, milestone: true),
      );
      _showFeedback(feedback, submitted);
    } on WritingReviewException catch (error) {
      if (mounted) setState(() => _reviewError = error.message);
    } catch (_) {
      if (mounted) {
        setState(
          () => _reviewError = 'Could not start the review. Please try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _reviewing = false);
    }
  }

  void _showFeedback(WritingFeedback feedback, String submitted) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            WritingFeedbackScreen(feedback: feedback, original: submitted),
      ),
    );
  }

  /// Saved with a two-second breather: typing should not trigger a disk write
  /// per keystroke.
  void _onType() {
    setState(() {});
    _save?.cancel();
    _save = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        AppScope.of(context).saveDraft(widget.task.id, _text.text);
      }
    });
  }

  int get _words {
    final clean = _text.text.trim();
    if (clean.isEmpty) return 0;
    return clean.split(RegExp(r'\s+')).length;
  }

  void _toggleClock() {
    if (_running) {
      _tick?.cancel();
      setState(() => _running = false);
      return;
    }
    setState(() => _running = true);
    _tick = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _seconds++);
    });
  }

  @override
  Widget build(BuildContext context) {
    final (low, high) = _limits;
    final n = _words;
    final inRange = n >= low && n <= high;
    final colour = n == 0
        ? paperGrey
        : (inRange
              ? cambridgeGreen
              : (n < low ? cambridgeOrange : cambridgeRed));
    final over = _seconds >= _minutes * 60;
    final t = widget.task;

    return Theme(
      // Black and white, like the rest of the mock: this imitates paper.
      data: paperTheme(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${t.kind.label} · ${t.level.cefr}'),
          actions: [
            Center(
              child: Text(
                '${_seconds ~/ 60}:'
                '${(_seconds % 60).toString().padLeft(2, '0')}'
                ' / $_minutes:00',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: over ? cambridgeRed : paperGrey,
                ),
              ),
            ),
            IconButton(
              onPressed: _toggleClock,
              icon: Icon(
                _running ? Icons.pause_rounded : Icons.play_arrow_rounded,
              ),
              tooltip: _running ? 'Pause' : 'Start the clock',
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final amplio = constraints.maxWidth >= corteAmplio;
            final hoja = _TaskSheet(
              key: _hojaKey,
              task: t,
              open: amplio || _taskOpen,
              onToggle: amplio
                  ? null
                  : () => setState(() => _taskOpen = !_taskOpen),
            );
            final contenidoEditor = Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: paperRule),
                      bottom: BorderSide(color: paperRule),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '$n',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: colour,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          n == 0
                              ? 'words · aim for ${t.wordTarget}'
                              : t.level == ExamLevel.b1
                              ? 'words · aim for about 100'
                              : (inRange
                                    ? 'words · within range'
                                    : (n < low
                                          ? 'words · ${low - n} short of $low'
                                          : 'words · ${n - high} over $high')),
                          style: const TextStyle(color: paperGrey),
                        ),
                      ),
                      IconButton(
                        onPressed: _text.text.trim().isEmpty
                            ? null
                            : () {
                                Clipboard.setData(
                                  ClipboardData(text: _text.text),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Copied'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                        icon: const Icon(Icons.copy_rounded),
                        tooltip: 'Copy the text',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: TextField(
                      controller: _text,
                      readOnly: _reviewing,
                      expands: true,
                      maxLines: null,
                      minLines: null,
                      textAlignVertical: TextAlignVertical.top,
                      style: const TextStyle(
                        color: paperInk,
                        height: 1.6,
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write your answer here…',
                        hintStyle: TextStyle(color: paperGrey),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: paperRule)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_reviewError != null) ...[
                        Text(
                          _reviewError!,
                          style: const TextStyle(
                            color: cambridgeRed,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      FilledButton.icon(
                        onPressed:
                            _reviewing ||
                                n < 30 ||
                                n > 800 ||
                                _text.text.length > 8000
                            ? null
                            : _review,
                        icon: _reviewing
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.fact_check_outlined),
                        label: Text(
                          _reviewing
                              ? 'Reviewing your writing…'
                              : _feedback != null &&
                                    _reviewedText == _text.text.trim()
                              ? 'View my review'
                              : 'Review my writing',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        n > 800 || _text.text.length > 8000
                            ? 'For a review, use up to 800 words and 8,000 characters.'
                            : 'Sends this answer and task to Groq or Anthropic. Internet required. At least 30 words.',
                        style: const TextStyle(
                          color: paperGrey,
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
            // Con teclado o texto ampliado, el formulario puede desplazarse
            // antes de sacrificar el espacio para escribir.
            final editor = LayoutBuilder(
              key: _editorKey,
              builder: (context, area) => SingleChildScrollView(
                primary: false,
                child: SizedBox(
                  height: math.max(
                    area.maxHeight,
                    MediaQuery.textScalerOf(context).scale(440),
                  ),
                  child: contenidoEditor,
                ),
              ),
            );
            if (amplio) {
              return Centrado(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          primary: true,
                          child: hoja,
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 24, color: paperRule),
                    Expanded(flex: 3, child: editor),
                  ],
                ),
              );
            }
            return Centrado(
              ancho: anchoLectura,
              child: Column(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight * 0.48,
                    ),
                    child: SingleChildScrollView(primary: true, child: hoja),
                  ),
                  Expanded(child: editor),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// The task itself, laid out like the question paper. Collapsible, because
/// once you have read it you want the screen back for writing.
class _TaskSheet extends StatelessWidget {
  const _TaskSheet({
    super.key,
    required this.task,
    required this.open,
    required this.onToggle,
  });

  final WritingTask task;
  final bool open;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF4F4F0),
      padding: const EdgeInsets.fromLTRB(16, 10, 8, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  open ? 'THE TASK' : 'THE TASK · tap to read again',
                  style: const TextStyle(
                    color: paperGrey,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              if (onToggle != null)
                IconButton(
                  onPressed: onToggle,
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    open
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: paperGrey,
                  ),
                ),
            ],
          ),
          if (open) ...[
            Text(
              task.instructions,
              style: const TextStyle(color: paperInk, height: 1.5),
            ),
            const SizedBox(height: 10),
            Text(
              task.question,
              style: const TextStyle(
                color: paperInk,
                height: 1.5,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (task.notes.isNotEmpty) ...[
              const SizedBox(height: 10),
              const Text(
                'Notes — follow the task instructions:',
                style: TextStyle(color: paperGrey, fontSize: 13),
              ),
              const SizedBox(height: 4),
              for (final n in task.notes)
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: Text(
                    '·  $n',
                    style: const TextStyle(color: paperInk, height: 1.5),
                  ),
                ),
            ],
            if (task.register != null) ...[
              const SizedBox(height: 10),
              Text(
                'Register: ${task.register}',
                style: const TextStyle(
                  color: paperGrey,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
            const SizedBox(height: 12),
            const Text(
              'BEFORE YOU FINISH',
              style: TextStyle(
                color: paperGrey,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            for (final c in task.checklist)
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 2),
                child: Text(
                  '·  $c',
                  style: const TextStyle(
                    color: paperGrey,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ),
            const SizedBox(height: 14),
            const _ComoSeCorrige(),
            if (writingModels[task.id] != null) ...[
              const SizedBox(height: 8),
              _Modelo(model: writingModels[task.id]!),
            ],
          ],
        ],
      ),
    );
  }
}

/// A fold-out section on the question sheet, in the same paper black and
/// white as the rest of it.
class _Plegable extends StatefulWidget {
  const _Plegable({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  State<_Plegable> createState() => _PlegableState();
}

class _PlegableState extends State<_Plegable> {
  bool _abierto = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: paperGrey.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _abierto = !_abierto),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: paperInk,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(
                            color: paperGrey,
                            fontSize: 12,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _abierto
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    color: paperGrey,
                  ),
                ],
              ),
            ),
          ),
          if (_abierto)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: widget.child,
            ),
        ],
      ),
    );
  }
}

class _ComoSeCorrige extends StatelessWidget {
  const _ComoSeCorrige();

  @override
  Widget build(BuildContext context) {
    return _Plegable(
      title: 'How this is marked',
      subtitle:
          'Four subscales, five marks each. Knowing them is worth more than '
          'another hour of writing.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final c in writingCriteria) ...[
            Text(
              c.name,
              style: const TextStyle(
                color: paperInk,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              c.rewards,
              style: const TextStyle(
                color: paperInk,
                fontSize: 13,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Usually lost: ${c.lost}',
              style: const TextStyle(
                color: paperGrey,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

/// El modelo va cerrado y avisando. Leerlo antes de escribir no es un modelo,
/// es la respuesta, y entonces el ejercicio ya no ha ocurrido.
class _Modelo extends StatelessWidget {
  const _Modelo({required this.model});

  final WritingModel model;

  @override
  Widget build(BuildContext context) {
    return _Plegable(
      title: 'A model answer',
      subtitle:
          'Write yours first. ${model.words} words, and what makes it work '
          'is listed underneath.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBF8),
              border: Border.all(color: paperGrey.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: SelectableText(
              model.text,
              style: const TextStyle(
                color: paperInk,
                fontSize: 14,
                height: 1.65,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'WHY IT SCORES',
            style: TextStyle(
              color: paperGrey,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          for (final w in model.why)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                '·  $w',
                style: const TextStyle(
                  color: paperInk,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
