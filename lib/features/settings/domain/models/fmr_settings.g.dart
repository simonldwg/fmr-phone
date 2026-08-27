// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fmr_settings.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FMRSettingsCWProxy {
  FMRSettings apiUrl(String apiUrl);

  FMRSettings useBasicExerciseScreen(bool useBasicExerciseScreen);

  FMRSettings targetHeartRates(Map<ExerciseIntensity, int> targetHeartRates);

  FMRSettings arousalWeight(double arousalWeight);

  FMRSettings bpmWeight(double bpmWeight);

  FMRSettings filters(Filters filters);

  FMRSettings allowMultiplePlays(bool allowMultiplePlays);

  FMRSettings selectionStrategy(SongSelectionStrategy selectionStrategy);

  FMRSettings initialBpmModerate(int initialBpmModerate);

  FMRSettings initialBpmVigorous(int initialBpmVigorous);

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
    Map<ExerciseIntensity, int> targetHeartRates,
    double arousalWeight,
    double bpmWeight,
    Filters filters,
    bool allowMultiplePlays,
    SongSelectionStrategy selectionStrategy,
    int initialBpmModerate,
    int initialBpmVigorous,
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
  FMRSettings initialBpmModerate(int initialBpmModerate) =>
      call(initialBpmModerate: initialBpmModerate);

  @override
  FMRSettings initialBpmVigorous(int initialBpmVigorous) =>
      call(initialBpmVigorous: initialBpmVigorous);

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
    Object? targetHeartRates = const $CopyWithPlaceholder(),
    Object? arousalWeight = const $CopyWithPlaceholder(),
    Object? bpmWeight = const $CopyWithPlaceholder(),
    Object? filters = const $CopyWithPlaceholder(),
    Object? allowMultiplePlays = const $CopyWithPlaceholder(),
    Object? selectionStrategy = const $CopyWithPlaceholder(),
    Object? initialBpmModerate = const $CopyWithPlaceholder(),
    Object? initialBpmVigorous = const $CopyWithPlaceholder(),
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
      initialBpmModerate == const $CopyWithPlaceholder() ||
              initialBpmModerate == null
          ? _value.initialBpmModerate
          // ignore: cast_nullable_to_non_nullable
          : initialBpmModerate as int,
      initialBpmVigorous == const $CopyWithPlaceholder() ||
              initialBpmVigorous == null
          ? _value.initialBpmVigorous
          // ignore: cast_nullable_to_non_nullable
          : initialBpmVigorous as int,
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
  (json['initialBpmModerate'] as num).toInt(),
  (json['initialBpmVigorous'] as num).toInt(),
);

Map<String, dynamic> _$FMRSettingsToJson(FMRSettings instance) =>
    <String, dynamic>{
      'apiUrl': instance.apiUrl,
      'useBasicExerciseScreen': instance.useBasicExerciseScreen,
      'targetHeartRates': instance.targetHeartRates.map(
        (k, e) => MapEntry(_$ExerciseIntensityEnumMap[k]!, e),
      ),
      'arousalWeight': instance.arousalWeight,
      'bpmWeight': instance.bpmWeight,
      'filters': instance.filters,
      'allowMultiplePlays': instance.allowMultiplePlays,
      'selectionStrategy':
          _$SongSelectionStrategyEnumMap[instance.selectionStrategy]!,
      'initialBpmModerate': instance.initialBpmModerate,
      'initialBpmVigorous': instance.initialBpmVigorous,
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
