import 'package:flutter/material.dart';

import '../../core/database/database_helper.dart';
class HistoryProvider extends ChangeNotifier {
  final DatabaseHelper _database =
      DatabaseHelper.instance;

  bool isLoading = false;

  List<Map<String, dynamic>>
      sensorReadings = [];

  List<Map<String, dynamic>>
      pumpActivations = [];

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> loadHistory() async {
    try {
      _setLoading(true);

      sensorReadings =
          await _database
              .getSensorReadings(1);

      pumpActivations =
          await _database
              .getPumpActivations(1);

      notifyListeners();
    } catch (e) {
      debugPrint(
        'Erro ao carregar histórico: $e',
      );
    } finally {
      _setLoading(false);
    }
  }
}