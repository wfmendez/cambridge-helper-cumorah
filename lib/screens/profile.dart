import 'package:flutter/material.dart';

import '../brand.dart';
import '../cambridge.dart';
import '../disposicion.dart';
import '../encouragement.dart';
import '../learner_profile.dart';
import '../state.dart';
import '../widgets.dart';
import '../reminders.dart';
import '../calendar_reminder.dart';

void openProfile(BuildContext context) =>
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const ProfileScreen()));

class GoalCard extends StatelessWidget {
  const GoalCard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final profile = state.profile;
    final theme = Theme.of(context);
    final date = profile.targetDate;
    final remaining = date == null ? null : daysUntil(date, DateTime.now());
    final done = state.dailyGoalReached;
    return ContentCard(
      color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.45),
      border: theme.colorScheme.secondary.withValues(alpha: 0.45),
      child: Semantics(
        explicitChildNodes: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MarcaCil(size: 38, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    profile.configured
                        ? addressed(
                            done
                                ? 'You showed up today'
                                : 'A little closer today',
                            profile.name,
                          )
                        : 'Make this goal yours',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Working towards ${state.goal.name}',
              style: theme.textTheme.titleSmall,
            ),
            if (profile.reason.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(profile.reason, style: theme.textTheme.bodyMedium),
            ],
            if (remaining != null) ...[
              const SizedBox(height: 6),
              Text(
                remaining > 0
                    ? '$remaining days to your target · ${_dateLabel(context, date!)}'
                    : remaining == 0
                    ? 'Your target day is today. Take it one step at a time.'
                    : 'Your target date has passed. You can set a fresh date whenever you are ready.',
                style: theme.textTheme.bodySmall,
              ),
            ],
            if (profile.configured) ...[
              const SizedBox(height: 16),
              ProgressBar(
                value: (state.todayQuestions / profile.dailyQuestions).clamp(
                  0,
                  1,
                ),
                color: theme.colorScheme.primary,
                label:
                    '${state.todayQuestions} / ${profile.dailyQuestions} practice questions today',
              ),
              const SizedBox(height: 8),
              Text(
                done
                    ? 'Daily goal complete. Well done — take a break or keep exploring.'
                    : 'Every answer counts, including the ones you learn from.',
                style: theme.textTheme.bodySmall,
              ),
            ] else ...[
              const SizedBox(height: 6),
              const Text(
                'Add your name, your reason for learning and a small daily target.',
              ),
            ],
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: () => openProfile(context),
              icon: Icon(
                profile.configured
                    ? Icons.tune_rounded
                    : Icons.person_add_alt_1_rounded,
                size: 18,
              ),
              label: Text(
                profile.configured
                    ? 'Edit my goal & reminders'
                    : 'Set up my goal',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _dateLabel(BuildContext context, DateTime date) =>
    MaterialLocalizations.of(context).formatMediumDate(date);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _name = TextEditingController();
  final _reason = TextEditingController();
  final _soundsPlayer = FeedbackSounds();
  ExamLevel _level = ExamLevel.b2;
  DateTime? _date;
  int _daily = 5;
  bool _sounds = false;
  bool _effects = true;
  bool _loaded = false;
  bool _saving = false;
  bool _reminderEnabled = false;
  bool _reminderLoaded = false;
  bool _exporting = false;
  String? _reminderMessage;
  TimeOfDay _reminder = const TimeOfDay(hour: 18, minute: 0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_loaded) return;
    _loaded = true;
    final state = AppScope.of(context);
    final profile = state.profile;
    _name.text = profile.name;
    _reason.text = profile.reason;
    _level = state.goal;
    _date = profile.targetDate;
    _daily = profile.dailyQuestions;
    _sounds = profile.sounds;
    _effects = profile.effects;
    _reminder = TimeOfDay(
      hour: profile.reminderHour,
      minute: profile.reminderMinute,
    );
    localReminderEnabled().then((enabled) {
      if (mounted) {
        setState(() {
          _reminderEnabled = enabled;
          _reminderLoaded = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _reason.dispose();
    _soundsPlayer.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);
    final state = AppScope.of(context);
    try {
      await state.setGoal(_level);
      await state.saveProfile(_currentProfile);
      if (supportsLocalReminders) {
        try {
          await setLocalReminder(_reminderEnabled, state.profile, _level.cefr);
        } catch (_) {
          if (!mounted) return;
          setState(() {
            _saving = false;
            _reminderMessage = 'Your goal was saved, but the reminder could not be scheduled. Check notification permission in Android settings, then save again.';
          });
          return;
        }
      }
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      Navigator.pop(context);
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Your goal is saved. One small step at a time.'),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your changes could not be saved. Please try again.'),
        ),
      );
    }
  }

  LearnerProfile get _currentProfile => LearnerProfile(
    name: _name.text,
    reason: _reason.text,
    targetDate: _date,
    dailyQuestions: _daily,
    sounds: _sounds,
    effects: _effects,
    reminderHour: _reminder.hour,
    reminderMinute: _reminder.minute,
    configured: true,
  );

  Future<void> _exportReminder() async {
    if (_exporting) return;
    setState(() => _exporting = true);
    try {
      final result = await saveCalendarReminder(
        createCalendarReminder(
          _currentProfile,
          _level.cefr,
          now: DateTime.now(),
          id: 'cil-daily-study',
        ),
      );
      if (mounted) setState(() => _reminderMessage = result);
    } catch (_) {
      if (mounted) {
        setState(
          () => _reminderMessage =
              'The reminder file could not be saved. Please try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Your name & goal')),
      body: Pagina(
        ancho: anchoLectura,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Text(
            'A goal with a reason behind it.',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text(
            'Make a plan that fits your life. You can change it at any time.',
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _name,
            maxLength: 32,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'What should we call you?',
              helperText: 'A first name or nickname is enough. Optional.',
              border: OutlineInputBorder(),
            ),
          ),
          const SectionTitle('My exam goal'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final level in ExamLevel.values)
                ChoiceChip(
                  label: Text(level.name),
                  selected: level == _level,
                  onSelected: (_) => setState(() => _level = level),
                ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _reason,
            maxLength: 160,
            minLines: 2,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Why does this matter to you?',
              hintText:
                  'For my studies, a new job, or the confidence to speak…',
              helperText:
                  'Your own words will remind you why you started. Optional.',
              helperMaxLines: 2,
              border: OutlineInputBorder(),
            ),
          ),
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.event_outlined),
                label: Text(
                  _date == null
                      ? 'Add a target date'
                      : _dateLabel(context, _date!),
                ),
                onPressed: () async {
                  final now = DateUtils.dateOnly(DateTime.now());
                  final latest = DateTime(now.year + 10, 12, 31);
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _date == null || _date!.isBefore(now)
                        ? now
                        : _date!.isAfter(latest)
                        ? latest
                        : _date,
                    firstDate: now,
                    lastDate: latest,
                    helpText: 'Your target date',
                  );
                  if (date != null && mounted) setState(() => _date = date);
                },
              ),
              if (_date != null)
                TextButton(
                  onPressed: () => setState(() => _date = null),
                  child: const Text('Remove date'),
                ),
            ],
          ),
          const SectionTitle('One small daily step'),
          const Text(
            'Practice questions per day. Mistakes count too — you are still learning.',
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final count in ({5, 10, 15, 20, _daily}.toList()..sort()))
                ChoiceChip(
                  label: Text('$count questions'),
                  selected: _daily == count,
                  onSelected: (_) => setState(() => _daily = count),
                ),
            ],
          ),
          const SectionTitle('Encouragement'),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Celebration effects'),
            subtitle: const Text(
              'Brief animations for your wins. Respects reduced motion.',
            ),
            value: _effects,
            onChanged: (value) => setState(() => _effects = value),
          ),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Practice sounds'),
            subtitle: const Text('Soft sounds after answers and achievements.'),
            value: _sounds,
            onChanged: (value) {
              setState(() => _sounds = value);
              if (value) _soundsPlayer.play(enabled: true);
            },
          ),
          const SectionTitle('Reminders'),
          const Text(
            'Your goal stays visible on the Practice and Progress pages.',
          ),
          if (supportsLocalReminders)
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: const Text('Daily notification'),
              subtitle: const Text(
                'Reminds you even when Cíl is closed. Android may deliver it a little later to save battery.',
              ),
              value: _reminderEnabled,
              onChanged: _reminderLoaded && !_saving
                  ? (value) => setState(() => _reminderEnabled = value)
                  : null,
            ),
          const SizedBox(height: 10),
          OutlinedButton.icon(
            icon: const Icon(Icons.schedule_rounded),
            label: Text('Preferred time · ${_reminder.format(context)}'),
            onPressed: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: _reminder,
              );
              if (time != null && mounted) setState(() => _reminder = time);
            },
          ),
          const SizedBox(height: 24),
          if (!supportsLocalReminders) ...[
            Text(
              'For reminders while Cíl is closed, add a daily alert to your calendar. Your calendar controls the notifications.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: _exporting ? null : _exportReminder,
              icon: const Icon(Icons.event_available_rounded),
              label: Text(
                _exporting ? 'Preparing…' : 'Download calendar reminder',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Open the file in your calendar and confirm the repeat and alert. To change or stop it later, edit that event in your calendar. Remove an old event before importing a changed schedule.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
          ],
          if (_reminderMessage != null) ...[
            Semantics(liveRegion: true, child: Text(_reminderMessage!)),
            const SizedBox(height: 16),
          ],
          FilledButton.icon(
            onPressed: _saving || !_reminderLoaded ? null : _save,
            icon: const Icon(Icons.check_rounded),
            label: Text(_saving ? 'Saving…' : 'Save my goal'),
          ),
          const SizedBox(height: 16),
          Text(
            'Saved on this device. No account needed. Your name and personal goal are not sent for AI Writing reviews.',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
