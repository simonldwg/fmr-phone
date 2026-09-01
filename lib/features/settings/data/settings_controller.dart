import 'package:fitness_music_recommender/features/recommendation/domain/models/song_selection_strategy.dart';
import 'package:flutter/foundation.dart';

import '../../exercise/domain/models/exercise_intensity.dart';
import '../../recommendation/domain/models/filters.dart';
import '../domain/models/fmr_settings.dart';
import 'settings_repository.dart';

enum SettingsStatus { loading, needsOnboarding, ready }

class SettingsController extends ChangeNotifier {
  SettingsController({SettingsRepository? repository})
    : _repository = repository ?? SettingsRepository();

  final SettingsRepository _repository;

  FMRSettings? _settings;
  SettingsStatus _status = SettingsStatus.loading;

  FMRSettings? get settings => _settings;

  FMRSettings get requireSettings {
    final s = _settings;
    if (s == null) {
      throw StateError(
        'SettingsController.requireSettings was called before onboarding was completed.',
      );
    }
    return s;
  }

  SettingsStatus get status => _status;
  bool get isLoading => _status == SettingsStatus.loading;
  bool get needsOnboarding => _status == SettingsStatus.needsOnboarding;

  Future<void> initialize() async {
    final storedSettings = await _repository.load();
    final onboardingDone = await _repository.isOnboardingComplete();

    if (storedSettings != null && onboardingDone) {
      _settings = storedSettings;
      _status = SettingsStatus.ready;
    } else {
      // Invalid settings state -> needs onboarding
      _settings = null;
      _status = SettingsStatus.needsOnboarding;
    }
    notifyListeners();
  }

  Future<void> update(FMRSettings newSettings) async {
    _settings = newSettings;
    await _repository.save(newSettings);
    notifyListeners();
  }

  Future<void> updateWith({
    String? apiUrl,
    bool? useBasicExerciseScreen,
    bool? disablePowerOptimization,
    Map<ExerciseIntensity, int>? targetHeartRates,
    double? arousalWeight,
    double? bpmWeight,
    Filters? filters,
    bool? allowMultiplePlays,
    SongSelectionStrategy? selectionStrategy,
    Map<ExerciseIntensity, int>? initialBpms,
  }) {
    final s = requireSettings;
    return update(
      FMRSettings(
        apiUrl ?? s.apiUrl,
        useBasicExerciseScreen ?? s.useBasicExerciseScreen,
        disablePowerOptimization ?? s.disablePowerOptimization,
        targetHeartRates ?? s.targetHeartRates,
        arousalWeight ?? s.arousalWeight,
        bpmWeight ?? s.bpmWeight,
        filters ?? s.filters,
        allowMultiplePlays ?? s.allowMultiplePlays,
        selectionStrategy ?? s.selectionStrategy,
        initialBpms ?? s.initialBpms,
      ),
    );
  }

  Future<void> updateTargetHeartRate(ExerciseIntensity intensity, int bpm) {
    final s = requireSettings;
    final updatedMap = Map<ExerciseIntensity, int>.from(s.targetHeartRates)
      ..[intensity] = bpm;
    return updateWith(targetHeartRates: updatedMap);
  }

  Future<void> updateInitialBpm(ExerciseIntensity intensity, int bpm) {
    final s = requireSettings;
    final updatedMap = Map<ExerciseIntensity, int>.from(s.initialBpms)
      ..[intensity] = bpm;
    return updateWith(initialBpms: updatedMap);
  }

  Future<void> completeOnboarding(FMRSettings finalSettings) async {
    _settings = finalSettings;
    await _repository.save(finalSettings);
    await _repository.setOnboardingComplete(true);
    _status = SettingsStatus.ready;
    notifyListeners();
  }

  Future<void> resetToFactoryDefaults() async {
    await _repository.clear();
    _settings = null;
    _status = SettingsStatus.needsOnboarding;
    notifyListeners();
  }
}
