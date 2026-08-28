class ExerciseException implements Exception {
  final String cause;
  ExerciseException(this.cause);

  @override
  String toString() => cause;
}
