import 'package:flutter/material.dart';

import '../../core/database/database_helper.dart';

class DashboardProvider extends ChangeNotifier {
  final DatabaseHelper _database =
      DatabaseHelper.instance;

  bool pumpOn = false;

  bool sensorActive = true;

  bool continuousMode = false;

  double moistureValue = 0.0;

  List<double> lastReadings = [];

  Future<void> loadDashboardData() async {
    try {
      final readings =
          await _database
              .getLastFiveReadings(1);

      if (readings.isNotEmpty) {
        lastReadings =
            readings
                .map(
                  (reading) =>
                      (reading['moisture_value']
                              as num)
                          .toDouble(),
                )
                .toList();

        moistureValue =
            lastReadings.first;
      }

      notifyListeners();
    } catch (e) {
      debugPrint(
        'Erro ao carregar dashboard: $e',
      );
    }
  }

  void togglePump() {
    pumpOn = !pumpOn;
    notifyListeners();
  }

  void updateMoisture(
    double value,
  ) {
    moistureValue = value;
    notifyListeners();
  }

  void toggleSensor() {
    sensorActive = !sensorActive;
    notifyListeners();
  }

  void toggleContinuousMode() {
    continuousMode =
        !continuousMode;

    notifyListeners();
  }

  void setPumpStatus(bool value) {
    pumpOn = value;
    notifyListeners();
  }

  void setSensorStatus(bool value) {
    sensorActive = value;
    notifyListeners();
  }

  void addReading(double value) {
    moistureValue = value;

    lastReadings.insert(
      0,
      value,
    );

    if (lastReadings.length > 5) {
      lastReadings.removeLast();
    }

    notifyListeners();
  }
}