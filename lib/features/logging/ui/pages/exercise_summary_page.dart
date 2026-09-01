import 'package:checkmark/checkmark.dart';
import 'package:fitness_music_recommender/features/logging/data/exercise_log_exporter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

import '../../../common/utils/duration_formatting.dart';
import '../../domain/models/exercise_log.dart';
import '../../domain/models/exercise_log_summary.dart';
import '../../logging_providers.dart';

class ExerciseSummaryPage extends ConsumerStatefulWidget {
  const ExerciseSummaryPage({super.key});

  @override
  ConsumerState<ExerciseSummaryPage> createState() =>
      _ExerciseSummaryPageState();
}

class _ExerciseSummaryPageState extends ConsumerState<ExerciseSummaryPage> {
  bool _exporting = false;

  Future<void> _export(ExerciseLog log) async {
    setState(() => _exporting = true);
    try {
      await ExerciseLogExporter.export(log);
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final log = ref.read(exerciseLoggerProvider).lastCompletedLog;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.go('/exercise/overview');
      },
      child: FScaffold(
        header: FHeader(title: const Text('Gut gemacht!')),
        child: log == null
            ? const _NoDataView()
            : _SummaryContent(
                log: log,
                exporting: _exporting,
                onExport: () => _export(log),
              ),
      ),
    );
  }
}

class _NoDataView extends StatelessWidget {
  const _NoDataView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Für dieses Training liegen keine Daten vor.',
              style: context.theme.typography.body.md,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FButton(
              onPress: () => context.go('/exercise/overview'),
              child: const Text('Zurück zur Übersicht'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryContent extends StatelessWidget {
  const _SummaryContent({
    required this.log,
    required this.exporting,
    required this.onExport,
  });

  final ExerciseLog log;
  final bool exporting;
  final VoidCallback onExport;

  @override
  Widget build(BuildContext context) {
    final summary = ExerciseLogSummary.from(log);
    final colors = context.theme.colors;

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 32, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: _AnimatedCheckIcon()),
          const SizedBox(height: 32),
          FCard(
            builder: (context, style, _) => Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Übersicht', style: style.titleTextStyle),
                  const SizedBox(height: 8),
                  _LogStatRow(
                    label: 'Trainingstyp',
                    value: switch (summary.type) {
                      ExerciseLogType.continuous => 'Kontinuierliches Training',
                      ExerciseLogType.interval => 'Intervalltraining',
                    },
                  ),
                  _LogStatRow(
                    label: 'Gesamtdauer',
                    value: formatDuration(
                      summary.duration,
                      alwaysIncludeHours: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FCard(
            builder: (context, style, _) => Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Herzfrequenz', style: style.titleTextStyle),
                  const SizedBox(height: 8),
                  _LogStatRow(
                    label: 'Durchschnitt',
                    value: _formatBpm(summary.avgHeartRate),
                  ),
                  _LogStatRow(
                    label: 'Maximum',
                    value: _formatBpm(summary.maxHeartRate),
                  ),
                  _LogStatRow(
                    label: 'Minimum',
                    value: _formatBpm(summary.minHeartRate),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FCard(
            builder: (context, style, _) => Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Schritte', style: style.titleTextStyle),
                  const SizedBox(height: 8),
                  _LogStatRow(
                    label: 'Gesamtanzahl',
                    value: summary.totalSteps == null
                        ? '–'
                        : '${summary.totalSteps} Schritte',
                  ),
                  _LogStatRow(
                    label: 'Durchschnitt',
                    value: _formatStepsPerMinute(summary.avgStepsPerMinute),
                  ),
                  _LogStatRow(
                    label: 'Maximum',
                    value: _formatStepsPerMinute(summary.maxStepsPerMinute),
                  ),
                  _LogStatRow(
                    label: 'Minimum',
                    value: _formatStepsPerMinute(summary.minStepsPerMinute),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          FButton(
            onPress: exporting ? null : onExport,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (exporting)
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: FCircularProgress(
                      style: .delta(iconStyle: .delta(color: colors.secondary)),
                    ),
                  )
                else
                  const Icon(FLucideIcons.download, size: 18),
                const SizedBox(width: 8),
                const Text('Als JSON exportieren'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          FButton(
            variant: .secondary,
            onPress: () => context.go('/exercise/overview'),
            child: const Text('Zurück zur Übersicht'),
          ),
        ],
      ),
    );
  }

  static String _formatBpm(int? value) => value == null ? '–' : '$value bpm';

  static String _formatStepsPerMinute(int? value) =>
      value == null ? '–' : '$value Schritte/min';
}

class _LogStatRow extends StatelessWidget {
  const _LogStatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: typography.body.xs.copyWith(color: colors.mutedForeground),
          ),
          Text(
            value,
            style: typography.body.xs.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _AnimatedCheckIcon extends StatefulWidget {
  const _AnimatedCheckIcon();

  @override
  State<_AnimatedCheckIcon> createState() => _AnimatedCheckIconState();
}

class _AnimatedCheckIconState extends State<_AnimatedCheckIcon> {
  bool _active = false;

  @override
  void initState() {
    super.initState();
    // after the first frame, change active value so the widget actually
    // animates
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _active = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: CheckMark(
        active: _active,
        curve: Curves.easeInQuart,
        inactiveColor: context.theme.colors.primary,
        activeColor: Colors.green,
        strokeWidth: 7,
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
