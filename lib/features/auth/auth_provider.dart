import 'package:flutter/material.dart';

import '../../core/database/database_helper.dart';
import '../../core/models/user.dart';

class AuthProvider extends ChangeNotifier {
  final DatabaseHelper _database =
      DatabaseHelper.instance;

  User? _currentUser;

  bool _isLoading = false;

  User? get currentUser => _currentUser;

  bool get isLoading => _isLoading;

  bool get isLoggedIn =>
      _currentUser != null;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      final existingUser =
          await _database.getUserByEmail(
        email,
      );

      if (existingUser != null) {
        return false;
      }

      final user = User(
        name: name,
        email: email,
        password: password,
      );

      await _database.insertUser(
        user.toMap(),
      );

      return true;
    } catch (e) {
      debugPrint(
        'Erro ao cadastrar usuário: $e',
      );

      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      _setLoading(true);

      final result =
          await _database.loginUser(
        email,
        password,
      );

      if (result == null) {
        return false;
      }

      _currentUser =
          User.fromMap(result);

      notifyListeners();

      return true;
    } catch (e) {
      debugPrint(
        'Erro ao realizar login: $e',
      );

      return false;
    } finally {
      _setLoading(false);
    }
  }

  void logout() {
    _currentUser = null;

    notifyListeners();
  }
}