import 'package:health/health.dart';

class HeartRateAccessException implements Exception {
  String cause;
  HeartRateAccessException(this.cause);
}

/// Reads heart-rate data from the platform's health store (i.e. Health Connect for Android devices)
class HeartRateRepository {
  const HeartRateRepository();

  Future<int> readRestingHeartRate() async {
    final health = Health();
    await health.configure();

    final dataTypes = [HealthDataType.RESTING_HEART_RATE];

    bool requested = await health.requestAuthorization(dataTypes);
    if (!requested) {
      throw HeartRateAccessException(
        'Reading the resting heart rate value was not possible because permissions were not granted.',
      );
    }

    var now = DateTime.now();

    // fetch resting HR values from the last three days
    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
      types: dataTypes,
      startTime: now.subtract(Duration(days: 3)),
      endTime: now,
    );

    if (healthData.isEmpty) {
      throw HeartRateAccessException(
        'No recent resting heart rate value is available.',
      );
    }

    // compare all elements of the array and choose the element with the latest dateFrom value, i.e. the newest resting HR value
    final latest = healthData.reduce(
      (a, b) => a.dateFrom.isAfter(b.dateFrom) ? a : b,
    );

    NumericHealthValue restingHeartRate = latest.value as NumericHealthValue;

    return restingHeartRate.numericValue.toInt();
  }
}
