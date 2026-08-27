class ExerciseStartException implements Exception {
  final String cause;
  ExerciseStartException(this.cause);

  @override
  String toString() => cause;
}
