class TargetHeartRateCalculator {
  const TargetHeartRateCalculator._();

  static double _calculateHrMax(int age) => 208 - (0.7 * age);
  static double _calculateHrReserve(double hrMax, int restingHr) =>
      hrMax - restingHr;
  static double _calculateHrAverage(double hr1, double hr2) => (hr1 + hr2) / 2;

  static int calculateTargetHrModerate({
    required int age,
    required int restingHr,
  }) {
    double hrMax = _calculateHrMax(age);
    double hrReserve = _calculateHrReserve(hrMax, restingHr);

    // Karvonen formula
    double minHrModerate = (hrReserve * 0.4) + restingHr;
    double maxHrModerate = (hrReserve * 0.59) + restingHr;

    // Average is the target heart rate
    double targetHr = _calculateHrAverage(minHrModerate, maxHrModerate);

    return targetHr.round();
  }

  static int calculateTargetHrVigorous({
    required int age,
    required int restingHr,
  }) {
    double hrMax = _calculateHrMax(age);
    double hrReserve = _calculateHrReserve(hrMax, restingHr);

    // Karvonen formula
    double minHrModerate = (hrReserve * 0.6) + restingHr;
    double maxHrModerate = (hrReserve * 0.84) + restingHr;

    // Average is the target heart rate
    double targetHr = _calculateHrAverage(minHrModerate, maxHrModerate);

    return targetHr.round();
  }
}
