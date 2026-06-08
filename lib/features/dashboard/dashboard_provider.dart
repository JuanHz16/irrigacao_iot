import 'package:flutter/material.dart';

class DashboardProvider extends ChangeNotifier {
  bool pumpOn = false;

  bool sensorActive = true;

  bool continuousMode = false;

  double moistureValue = 42.5;

  List<double> lastReadings = [
    42.5,
    43.0,
    41.8,
    44.1,
    42.9,
  ];

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

