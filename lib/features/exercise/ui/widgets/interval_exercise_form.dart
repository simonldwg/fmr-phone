import 'package:fitness_music_recommender/features/exercise/domain/models/exercise_intensity.dart';
import 'package:fitness_music_recommender/features/exercise/domain/models/interval.dart';
import 'package:fitness_music_recommender/features/exercise/exercise_providers.dart';
import 'package:flutter/material.dart' hide Interval;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../common/ui/widgets/small_description_text.dart';
import '../../../common/utils/duration_formatting.dart';
import '../../domain/controllers/exercise_exception.dart';

/// Holds an immutable Interval object
class _IntervalDraft {
  _IntervalDraft(this.value);
  Interval value;
}

class IntervalExerciseForm extends ConsumerStatefulWidget {
  const IntervalExerciseForm({super.key});

  @override
  ConsumerState<IntervalExerciseForm> createState() =>
      _IntervalExerciseFormState();
}

class _IntervalExerciseFormState extends ConsumerState<IntervalExerciseForm> {
  static const _minTotalDuration = Duration(minutes: 5);
  static const _minIntervalDuration = Duration(seconds: 30);
  static const _durationStep = Duration(seconds: 30);

  final List<_IntervalDraft> _intervals = [
    _IntervalDraft(
      const Interval(ExerciseIntensity.moderate, Duration(minutes: 1)),
    ),
  ];

  Duration get _totalDuration =>
      _intervals.fold(Duration.zero, (sum, i) => sum + i.value.duration);

  bool get _isTooShort => _totalDuration < _minTotalDuration;

  void _addInterval() {
    setState(() {
      _intervals.add(
        _IntervalDraft(
          Interval(ExerciseIntensity.moderate, _minIntervalDuration),
        ),
      );
    });
  }

  void _removeInterval(_IntervalDraft draft) {
    // list of Intervals can never become empty
    if (_intervals.length <= 1) return;
    setState(() => _intervals.remove(draft));
  }

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      final draft = _intervals.removeAt(oldIndex);
      _intervals.insert(newIndex, draft);
    });
  }

  Future<void> _startIntervalTraining() async {
    if (_isTooShort) return;

    final intervals = [for (final draft in _intervals) draft.value];

    try {
      await ref
          .read(exerciseControllerProvider.notifier)
          .startInterval(intervals);
      if (mounted) context.go('/exercise/active');
    } on ExerciseException catch (e) {
      if (mounted) {
        showFToast(
          context: context,
          variant: .destructive,
          icon: const Icon(FLucideIcons.circleX),
          title: const Text('Fehler beim Starten des Trainings'),
          description: Text(e.cause),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          itemCount: _intervals.length,
          onReorderItem: _reorder,
          itemBuilder: (context, index) {
            final draft = _intervals[index];
            return _IntervalTile(
              key: ObjectKey(draft),
              index: index,
              interval: draft.value,
              canRemove: _intervals.length > 1,
              onIntensityChanged: (intensity) => setState(
                () => draft.value = draft.value.copyWith.intensity(intensity),
              ),
              onDurationChanged: (duration) => setState(
                () => draft.value = draft.value.copyWith.duration(duration),
              ),
              onRemove: () => _removeInterval(draft),
            );
          },
        ),
        const SizedBox(height: 8),
        FButton(
          size: .sm,
          variant: .outline,
          onPress: _addInterval,
          prefix: const Icon(FLucideIcons.plus, size: 18),
          child: const Text('Intervall hinzufügen'),
        ),
        const SizedBox(height: 8),
        FDivider(),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Gesamtdauer'),
            Text(
              formatDuration(_totalDuration),
              style: TextStyle(
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
        if (_isTooShort)
          SmallDescriptionText(
            'Mindestens ${_minTotalDuration.inMinutes} Minuten erforderlich',
          ),
        const SizedBox(height: 16),
        FButton(
          onPress: _isTooShort ? null : _startIntervalTraining,
          child: const Text('Training starten'),
        ),
      ],
    );
  }
}

class _IntervalTile extends StatelessWidget {
  const _IntervalTile({
    required super.key,
    required this.index,
    required this.interval,
    required this.canRemove,
    required this.onIntensityChanged,
    required this.onDurationChanged,
    required this.onRemove,
  });

  final int index;
  final Interval interval;
  final bool canRemove;
  final ValueChanged<ExerciseIntensity> onIntensityChanged;
  final ValueChanged<Duration> onDurationChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return Column(
      children: [
        Row(
          crossAxisAlignment: .center,
          mainAxisAlignment: .spaceBetween,
          children: [
            Row(
              children: [
                ReorderableDragStartListener(
                  index: index,
                  child: Icon(
                    FLucideIcons.gripVertical,
                    color: colors.mutedForeground,
                  ),
                ),
                const SizedBox(width: 12),
                Text('${index + 1}.', style: typography.body.sm),
              ],
            ),
            Column(
              children: [
                _IntensityToggle(
                  value: interval.intensity,
                  onChanged: onIntensityChanged,
                ),
                const SizedBox(height: 8),
                _DurationStepper(
                  value: interval.duration,
                  minDuration: _IntervalExerciseFormState._minIntervalDuration,
                  step: _IntervalExerciseFormState._durationStep,
                  onChanged: onDurationChanged,
                ),
              ],
            ),

            FButton.icon(
              onPress: canRemove ? onRemove : null,
              variant: .ghost,
              child: Icon(FLucideIcons.trash2, size: 18),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const FDivider(),
      ],
    );
  }
}

class _IntensityToggle extends StatelessWidget {
  const _IntensityToggle({required this.value, required this.onChanged});

  final ExerciseIntensity value;
  final ValueChanged<ExerciseIntensity> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final intensity in ExerciseIntensity.values)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: FButton(
              size: .xs,
              variant: intensity == value ? .primary : .outline,
              onPress: () => onChanged(intensity),
              child: Text(intensity.label),
            ),
          ),
      ],
    );
  }
}

class _DurationStepper extends StatelessWidget {
  const _DurationStepper({
    required this.value,
    required this.minDuration,
    required this.step,
    required this.onChanged,
  });

  final Duration value;
  final Duration minDuration;
  final Duration step;
  final ValueChanged<Duration> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: value > minDuration ? () => onChanged(value - step) : null,
          icon: const Icon(FLucideIcons.minus, size: 16),
        ),
        Text(
          formatDuration(value),
          textAlign: TextAlign.center,
          style: const TextStyle(fontFeatures: [FontFeature.tabularFigures()]),
        ),
        IconButton(
          onPressed: () => onChanged(value + step),
          icon: const Icon(FLucideIcons.plus, size: 16),
        ),
      ],
    );
  }
}
