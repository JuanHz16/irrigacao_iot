import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/database/database_helper.dart';

class ControlProvider extends ChangeNotifier {
  final DatabaseHelper _database =
      DatabaseHelper.instance;

  bool pumpOn = false;

  bool sensorEnabled = true;

  bool isLoading = false;

  int? currentActivationId;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> togglePump() async {
    try {
      _setLoading(true);

      pumpOn = !pumpOn;

      notifyListeners();

      if (pumpOn) {
        await _database.insertPumpActivation(
          {
            'device_id': 1,
            'trigger_type': 'manual',
            'started_at':
                DateTime.now()
                    .toIso8601String(),
            'ended_at': null,
            'duration_seconds': null,
          },
        );
      }
    } catch (e) {
      debugPrint(
        'Erro ao alterar bomba: $e',
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<double> quickRead() async {
    try {
      _setLoading(true);

      await Future.delayed(
        const Duration(seconds: 2),
      );

      final random = Random();

      final moisture =
          20 +
          random.nextDouble() * 60;

      await _database.insertSensorReading(
        {
          'device_id': 1,
          'moisture_value': moisture,
          'reading_type': 'quick',
          'pump_triggered': 0,
          'created_at':
              DateTime.now()
                  .toIso8601String(),
        },
      );

      return moisture;
    } catch (e) {
      debugPrint(
        'Erro na leitura rápida: $e',
      );

      return 0;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> disableSystem() async {
    try {
      _setLoading(true);

      sensorEnabled = false;

      pumpOn = false;

      notifyListeners();
    } catch (e) {
      debugPrint(
        'Erro ao desligar sistema: $e',
      );
    } finally {
      _setLoading(false);
    }
  }
}