import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'tables.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(
      await getDatabasesPath(),
      'irrigacao_iot.db',
    );

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute(Tables.users);

    await db.execute(Tables.devices);

    await db.execute(Tables.systemConfig);

    await db.execute(Tables.sensorReadings);

    await db.execute(Tables.pumpActivations);
  }

  // ======================
  // USERS
  // ======================

  Future<int> insertUser(
    Map<String, dynamic> user,
  ) async {
    final db = await database;

    return await db.insert(
      'users',
      user,
    );
  }

  Future<Map<String, dynamic>?> getUserByEmail(
    String email,
  ) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  // ======================
  // DEVICES
  // ======================

  Future<int> insertDevice(
    Map<String, dynamic> device,
  ) async {
    final db = await database;

    return await db.insert(
      'devices',
      device,
    );
  }

  Future<List<Map<String, dynamic>>> getDevices() async {
    final db = await database;

    return await db.query('devices');
  }

  Future<int> updateDevice(
    int id,
    Map<String, dynamic> device,
  ) async {
    final db = await database;

    return await db.update(
      'devices',
      device,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ======================
  // SYSTEM CONFIG
  // ======================

  Future<int> insertSystemConfig(
    Map<String, dynamic> config,
  ) async {
    final db = await database;

    return await db.insert(
      'system_config',
      config,
    );
  }

  Future<Map<String, dynamic>?> getSystemConfig(
    int deviceId,
  ) async {
    final db = await database;

    final result = await db.query(
      'system_config',
      where: 'device_id = ?',
      whereArgs: [deviceId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  Future<int> updateSystemConfig(
    int deviceId,
    Map<String, dynamic> config,
  ) async {
    final db = await database;

    return await db.update(
      'system_config',
      config,
      where: 'device_id = ?',
      whereArgs: [deviceId],
    );
  }

  // ======================
  // SENSOR READINGS
  // ======================

  Future<int> insertSensorReading(
    Map<String, dynamic> reading,
  ) async {
    final db = await database;

    return await db.insert(
      'sensor_readings',
      reading,
    );
  }

  Future<List<Map<String, dynamic>>> getSensorReadings(
    int deviceId,
  ) async {
    final db = await database;

    return await db.query(
      'sensor_readings',
      where: 'device_id = ?',
      whereArgs: [deviceId],
      orderBy: 'created_at DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getLastFiveReadings(
    int deviceId,
  ) async {
    final db = await database;

    return await db.query(
      'sensor_readings',
      where: 'device_id = ?',
      whereArgs: [deviceId],
      orderBy: 'created_at DESC',
      limit: 5,
    );
  }

  // ======================
  // PUMP ACTIVATIONS
  // ======================

  Future<int> insertPumpActivation(
    Map<String, dynamic> activation,
  ) async {
    final db = await database;

    return await db.insert(
      'pump_activations',
      activation,
    );
  }

  Future<List<Map<String, dynamic>>> getPumpActivations(
    int deviceId,
  ) async {
    final db = await database;

    return await db.query(
      'pump_activations',
      where: 'device_id = ?',
      whereArgs: [deviceId],
      orderBy: 'started_at DESC',
    );
  }

  Future<int> updatePumpActivation(
    int id,
    Map<String, dynamic> activation,
  ) async {
    final db = await database;

    return await db.update(
      'pump_activations',
      activation,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ======================
  // RELATÓRIOS
  // ======================

  Future<double> getAverageMoisture(
    int deviceId,
  ) async {
    final db = await database;

    final result = await db.rawQuery(
      '''
      SELECT AVG(moisture_value) as avg
      FROM sensor_readings
      WHERE device_id = ?
      ''',
      [deviceId],
    );

    return (result.first['avg'] as num?)?.toDouble() ?? 0.0;
  }

  Future<double> getMaxMoisture(
    int deviceId,
  ) async {
    final db = await database;

    final result = await db.rawQuery(
      '''
      SELECT MAX(moisture_value) as max
      FROM sensor_readings
      WHERE device_id = ?
      ''',
      [deviceId],
    );

    return (result.first['max'] as num?)?.toDouble() ?? 0.0;
  }

  Future<double> getMinMoisture(
    int deviceId,
  ) async {
    final db = await database;

    final result = await db.rawQuery(
      '''
      SELECT MIN(moisture_value) as min
      FROM sensor_readings
      WHERE device_id = ?
      ''',
      [deviceId],
    );

    return (result.first['min'] as num?)?.toDouble() ?? 0.0;
  }

  Future<int> getPumpActivationCount(
    int deviceId,
  ) async {
    final db = await database;

    final result = await db.rawQuery(
      '''
      SELECT COUNT(*) as total
      FROM pump_activations
      WHERE device_id = ?
      ''',
      [deviceId],
    );

    return result.first['total'] as int;
  }

  Future<int> getTotalPumpTime(
    int deviceId,
  ) async {
    final db = await database;

    final result = await db.rawQuery(
      '''
      SELECT SUM(duration_seconds) as total
      FROM pump_activations
      WHERE device_id = ?
      ''',
      [deviceId],
    );

    return (result.first['total'] as int?) ?? 0;
  }
}