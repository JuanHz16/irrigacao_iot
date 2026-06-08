import 'package:flutter/material.dart';

import '../../core/database/database_helper.dart';

class SetupProvider extends ChangeNotifier {
  final DatabaseHelper _database =
      DatabaseHelper.instance;

  bool isLoading = false;

  String deviceName = '';

  String ipAddress = '';

  bool active = true;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> saveDevice() async {
    try {
      _setLoading(true);

      await _database.insertDevice({
        'name': deviceName,
        'ip_address': ipAddress,
        'active': active ? 1 : 0,
        'created_at':
            DateTime.now()
                .toIso8601String(),
      });
    } catch (e) {
      debugPrint(
        'Erro ao salvar dispositivo: $e',
      );
    } finally {
      _setLoading(false);
    }
  }

  void setDeviceName(String value) {
    deviceName = value;
    notifyListeners();
  }

  void setIpAddress(String value) {
    ipAddress = value;
    notifyListeners();
  }

  void toggleActive(bool value) {
    active = value;
    notifyListeners();
  }
}