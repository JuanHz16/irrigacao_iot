class SystemConfig {
  final int? id;
  final int deviceId;
  final int intervalHours;
  final int sensorEnabled;
  final double moistureThreshold;
  final String updatedAt;

  SystemConfig({
    this.id,
    required this.deviceId,
    required this.intervalHours,
    required this.sensorEnabled,
    required this.moistureThreshold,
    required this.updatedAt,
  });

  factory SystemConfig.fromMap(Map<String, dynamic> map) {
    return SystemConfig(
      id: map['id'],
      deviceId: map['device_id'],
      intervalHours: map['interval_hours'],
      sensorEnabled: map['sensor_enabled'],
      moistureThreshold: map['moisture_threshold'],
      updatedAt: map['updated_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'device_id': deviceId,
      'interval_hours': intervalHours,
      'sensor_enabled': sensorEnabled,
      'moisture_threshold': moistureThreshold,
      'updated_at': updatedAt,
    };
  }
}