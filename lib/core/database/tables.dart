class Tables {

  static const users = '''
  CREATE TABLE users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
  )
  ''';

  static const devices = '''
  CREATE TABLE devices(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    ip_address TEXT NOT NULL,
    active INTEGER DEFAULT 1,
    created_at TEXT NOT NULL
  )
  ''';

  static const systemConfig = '''
  CREATE TABLE system_config(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    device_id INTEGER,
    interval_hours INTEGER DEFAULT 4,
    sensor_enabled INTEGER DEFAULT 1,
    moisture_threshold REAL DEFAULT 30.0,
    updated_at TEXT NOT NULL
  )
  ''';

  static const sensorReadings = '''
  CREATE TABLE sensor_readings(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    device_id INTEGER,
    moisture_value REAL NOT NULL,
    reading_type TEXT NOT NULL,
    pump_triggered INTEGER DEFAULT 0,
    created_at TEXT NOT NULL
  )
  ''';

  static const pumpActivations = '''
  CREATE TABLE pump_activations(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    device_id INTEGER,
    trigger_type TEXT NOT NULL,
    started_at TEXT NOT NULL,
    ended_at TEXT,
    duration_seconds INTEGER
  )
  ''';
}