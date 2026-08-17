import 'package:flutter/foundation.dart';

import '../domain/models/filters.dart';
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
    int? targetHrModerate,
    int? targetHrVigorous,
    double? arousalWeight,
    double? bpmWeight,
    Filters? filters,
    bool? allowMultiplePlays,
    int? initialBpmModerate,
    int? initialBpmVigorous,
  }) {
    final s = requireSettings;
    return update(
      FMRSettings(
        apiUrl ?? s.apiUrl,
        useBasicExerciseScreen ?? s.useBasicExerciseScreen,
        targetHrModerate ?? s.targetHrModerate,
        targetHrVigorous ?? s.targetHrVigorous,
        arousalWeight ?? s.arousalWeight,
        bpmWeight ?? s.bpmWeight,
        filters ?? s.filters,
        allowMultiplePlays ?? s.allowMultiplePlays,
        initialBpmModerate ?? s.initialBpmModerate,
        initialBpmVigorous ?? s.initialBpmVigorous,
      ),
    );
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
