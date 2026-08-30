// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fmr_settings.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FMRSettingsCWProxy {
  FMRSettings apiUrl(String apiUrl);

  FMRSettings useBasicExerciseScreen(bool useBasicExerciseScreen);

  FMRSettings disablePowerOptimization(bool disablePowerOptimization);

  FMRSettings targetHeartRates(Map<ExerciseIntensity, int> targetHeartRates);

  FMRSettings arousalWeight(double arousalWeight);

  FMRSettings bpmWeight(double bpmWeight);

  FMRSettings filters(Filters filters);

  FMRSettings allowMultiplePlays(bool allowMultiplePlays);

  FMRSettings selectionStrategy(SongSelectionStrategy selectionStrategy);

  FMRSettings initialBpms(Map<ExerciseIntensity, int> initialBpms);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FMRSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FMRSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  FMRSettings call({
    String apiUrl,
    bool useBasicExerciseScreen,
    bool disablePowerOptimization,
    Map<ExerciseIntensity, int> targetHeartRates,
    double arousalWeight,
    double bpmWeight,
    Filters filters,
    bool allowMultiplePlays,
    SongSelectionStrategy selectionStrategy,
    Map<ExerciseIntensity, int> initialBpms,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfFMRSettings.copyWith(...)` or call `instanceOfFMRSettings.copyWith.fieldName(value)` for a single field.
class _$FMRSettingsCWProxyImpl implements _$FMRSettingsCWProxy {
  const _$FMRSettingsCWProxyImpl(this._value);

  final FMRSettings _value;

  @override
  FMRSettings apiUrl(String apiUrl) => call(apiUrl: apiUrl);

  @override
  FMRSettings useBasicExerciseScreen(bool useBasicExerciseScreen) =>
      call(useBasicExerciseScreen: useBasicExerciseScreen);

  @override
  FMRSettings disablePowerOptimization(bool disablePowerOptimization) =>
      call(disablePowerOptimization: disablePowerOptimization);

  @override
  FMRSettings targetHeartRates(Map<ExerciseIntensity, int> targetHeartRates) =>
      call(targetHeartRates: targetHeartRates);

  @override
  FMRSettings arousalWeight(double arousalWeight) =>
      call(arousalWeight: arousalWeight);

  @override
  FMRSettings bpmWeight(double bpmWeight) => call(bpmWeight: bpmWeight);

  @override
  FMRSettings filters(Filters filters) => call(filters: filters);

  @override
  FMRSettings allowMultiplePlays(bool allowMultiplePlays) =>
      call(allowMultiplePlays: allowMultiplePlays);

  @override
  FMRSettings selectionStrategy(SongSelectionStrategy selectionStrategy) =>
      call(selectionStrategy: selectionStrategy);

  @override
  FMRSettings initialBpms(Map<ExerciseIntensity, int> initialBpms) =>
      call(initialBpms: initialBpms);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `FMRSettings(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// FMRSettings(...).copyWith(id: 12, name: "My name")
  /// ```
  @override
  FMRSettings call({
    Object? apiUrl = const $CopyWithPlaceholder(),
    Object? useBasicExerciseScreen = const $CopyWithPlaceholder(),
    Object? disablePowerOptimization = const $CopyWithPlaceholder(),
    Object? targetHeartRates = const $CopyWithPlaceholder(),
    Object? arousalWeight = const $CopyWithPlaceholder(),
    Object? bpmWeight = const $CopyWithPlaceholder(),
    Object? filters = const $CopyWithPlaceholder(),
    Object? allowMultiplePlays = const $CopyWithPlaceholder(),
    Object? selectionStrategy = const $CopyWithPlaceholder(),
    Object? initialBpms = const $CopyWithPlaceholder(),
  }) {
    return FMRSettings(
      apiUrl == const $CopyWithPlaceholder() || apiUrl == null
          ? _value.apiUrl
          // ignore: cast_nullable_to_non_nullable
          : apiUrl as String,
      useBasicExerciseScreen == const $CopyWithPlaceholder() ||
              useBasicExerciseScreen == null
          ? _value.useBasicExerciseScreen
          // ignore: cast_nullable_to_non_nullable
          : useBasicExerciseScreen as bool,
      disablePowerOptimization == const $CopyWithPlaceholder() ||
              disablePowerOptimization == null
          ? _value.disablePowerOptimization
          // ignore: cast_nullable_to_non_nullable
          : disablePowerOptimization as bool,
      targetHeartRates == const $CopyWithPlaceholder() ||
              targetHeartRates == null
          ? _value.targetHeartRates
          // ignore: cast_nullable_to_non_nullable
          : targetHeartRates as Map<ExerciseIntensity, int>,
      arousalWeight == const $CopyWithPlaceholder() || arousalWeight == null
          ? _value.arousalWeight
          // ignore: cast_nullable_to_non_nullable
          : arousalWeight as double,
      bpmWeight == const $CopyWithPlaceholder() || bpmWeight == null
          ? _value.bpmWeight
          // ignore: cast_nullable_to_non_nullable
          : bpmWeight as double,
      filters == const $CopyWithPlaceholder() || filters == null
          ? _value.filters
          // ignore: cast_nullable_to_non_nullable
          : filters as Filters,
      allowMultiplePlays == const $CopyWithPlaceholder() ||
              allowMultiplePlays == null
          ? _value.allowMultiplePlays
          // ignore: cast_nullable_to_non_nullable
          : allowMultiplePlays as bool,
      selectionStrategy == const $CopyWithPlaceholder() ||
              selectionStrategy == null
          ? _value.selectionStrategy
          // ignore: cast_nullable_to_non_nullable
          : selectionStrategy as SongSelectionStrategy,
      initialBpms == const $CopyWithPlaceholder() || initialBpms == null
          ? _value.initialBpms
          // ignore: cast_nullable_to_non_nullable
          : initialBpms as Map<ExerciseIntensity, int>,
    );
  }
}

extension $FMRSettingsCopyWith on FMRSettings {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfFMRSettings.copyWith(...)` or `instanceOfFMRSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FMRSettingsCWProxy get copyWith => _$FMRSettingsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FMRSettings _$FMRSettingsFromJson(Map<String, dynamic> json) => FMRSettings(
  json['apiUrl'] as String,
  json['useBasicExerciseScreen'] as bool,
  json['disablePowerOptimization'] as bool,
  (json['targetHeartRates'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      $enumDecode(_$ExerciseIntensityEnumMap, k),
      (e as num).toInt(),
    ),
  ),
  (json['arousalWeight'] as num).toDouble(),
  (json['bpmWeight'] as num).toDouble(),
  Filters.fromJson(json['filters'] as Map<String, dynamic>),
  json['allowMultiplePlays'] as bool,
  $enumDecode(_$SongSelectionStrategyEnumMap, json['selectionStrategy']),
  (json['initialBpms'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      $enumDecode(_$ExerciseIntensityEnumMap, k),
      (e as num).toInt(),
    ),
  ),
);

Map<String, dynamic> _$FMRSettingsToJson(FMRSettings instance) =>
    <String, dynamic>{
      'apiUrl': instance.apiUrl,
      'useBasicExerciseScreen': instance.useBasicExerciseScreen,
      'disablePowerOptimization': instance.disablePowerOptimization,
      'targetHeartRates': instance.targetHeartRates.map(
        (k, e) => MapEntry(_$ExerciseIntensityEnumMap[k]!, e),
      ),
      'arousalWeight': instance.arousalWeight,
      'bpmWeight': instance.bpmWeight,
      'filters': instance.filters,
      'allowMultiplePlays': instance.allowMultiplePlays,
      'selectionStrategy':
          _$SongSelectionStrategyEnumMap[instance.selectionStrategy]!,
      'initialBpms': instance.initialBpms.map(
        (k, e) => MapEntry(_$ExerciseIntensityEnumMap[k]!, e),
      ),
    };

const _$ExerciseIntensityEnumMap = {
  ExerciseIntensity.moderate: 'moderate',
  ExerciseIntensity.vigorous: 'vigorous',
};

const _$SongSelectionStrategyEnumMap = {
  SongSelectionStrategy.shortest: 'shortest',
  SongSelectionStrategy.median: 'median',
  SongSelectionStrategy.bestMatch: 'bestMatch',
};
