import 'package:flutter/material.dart';

import '../../core/database/database_helper.dart';

class ReportsProvider extends ChangeNotifier {
  final DatabaseHelper _database =
      DatabaseHelper.instance;

  bool isLoading = false;

  double averageMoisture = 0;

  double maxMoisture = 0;

  double minMoisture = 0;

  int pumpActivations = 0;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> loadReports() async {
    try {
      _setLoading(true);

      averageMoisture =
          await _database
              .getAverageMoisture(1);

      maxMoisture =
          await _database
              .getMaxMoisture(1);

      minMoisture =
          await _database
              .getMinMoisture(1);

      pumpActivations =
          await _database
              .getPumpActivationCount(1);

      notifyListeners();
    } catch (e) {
      debugPrint(
        'Erro ao carregar relatórios: $e',
      );
    } finally {
      _setLoading(false);
    }
  }
}