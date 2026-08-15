import 'package:flutter/material.dart';

class TargetHeartRateCalculator {
  int _restingHr;
  double _hrReserve;

  TargetHeartRateCalculator._(this._restingHr, this._hrReserve);

  static double _calculateHrMax(int age) => 208 - (0.7 * age);
  static double _calculateHrReserve(double hrMax, int restingHr) =>
      hrMax - restingHr;
  static double _calculateHrAverage(double hr1, double hr2) => (hr1 + hr2) / 2;

  factory TargetHeartRateCalculator.getCalculator(int age, int restingHr) {
    double hrMax = _calculateHrMax(age);
    double hrReserve = _calculateHrReserve(hrMax, restingHr);

    debugPrint(
      'TARGET HR CALCULATOR\n'
      'Initial values: age $age, HRrest $restingHr, HRmax $hrMax, HRreserve $hrReserve',
    );

    return TargetHeartRateCalculator._(restingHr, hrReserve);
  }

  int calculateTargetHrModerate() {
    // Karvonen formula
    double minHrModerate = (_hrReserve * 0.4) + _restingHr;
    double maxHrModerate = (_hrReserve * 0.59) + _restingHr;

    // Average is the target heart rate
    double targetHr = _calculateHrAverage(minHrModerate, maxHrModerate);

    debugPrint(
      'Moderate values: min $minHrModerate, max $maxHrModerate, target $targetHr, target (rounded) ${targetHr.round()}',
    );

    return targetHr.round();
  }

  int calculateTargetHrVigorous() {
    // Karvonen formula
    double minHrVigorous = (_hrReserve * 0.6) + _restingHr;
    double maxHrVigorous = (_hrReserve * 0.84) + _restingHr;

    // Average is the target heart rate
    double targetHr = _calculateHrAverage(minHrVigorous, maxHrVigorous);

    debugPrint(
      'Vigorous values: min $minHrVigorous, max $maxHrVigorous, target $targetHr, target (rounded) ${targetHr.round()}',
    );

    return targetHr.round();
  }
}
