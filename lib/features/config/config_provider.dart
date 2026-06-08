import 'package:flutter/material.dart';

import '../../core/database/database_helper.dart';

class ConfigProvider extends ChangeNotifier {
  final DatabaseHelper _database =
      DatabaseHelper.instance;

  bool isLoading = false;

  int intervalHours = 2;

  double moistureThreshold = 40.0;

  bool sensorEnabled = true;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> loadConfig() async {
    try {
      _setLoading(true);

      final config =
          await _database.getSystemConfig(1);

      if (config != null) {
        intervalHours =
            config['interval_hours'];

        moistureThreshold =
            (config['moisture_threshold']
                    as num)
                .toDouble();

        sensorEnabled =
            config['sensor_enabled'] == 1;
      }

      notifyListeners();
    } catch (e) {
      debugPrint(
        'Erro ao carregar configuração: $e',
      );
    } finally {
      _setLoading(false);
    }
  }

  Future<void> saveConfig() async {
    try {
      _setLoading(true);

      final existing =
          await _database
              .getSystemConfig(1);

      final config = {
        'device_id': 1,
        'interval_hours':
            intervalHours,
        'sensor_enabled':
            sensorEnabled ? 1 : 0,
        'moisture_threshold':
            moistureThreshold,
        'updated_at':
            DateTime.now()
                .toIso8601String(),
      };

      if (existing == null) {
        await _database
            .insertSystemConfig(
          config,
        );
      } else {
        await _database
            .updateSystemConfig(
          1,
          config,
        );
      }
    } catch (e) {
      debugPrint(
        'Erro ao salvar configuração: $e',
      );
    } finally {
      _setLoading(false);
    }
  }

  void setInterval(int value) {
    intervalHours = value;
    notifyListeners();
  }

  void setThreshold(double value) {
    moistureThreshold = value;
    notifyListeners();
  }

  void toggleSensor(bool value) {
    sensorEnabled = value;
    notifyListeners();
  }
}