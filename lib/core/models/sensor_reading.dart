class SensorReading {
  final int? id;
  final int deviceId;
  final double moistureValue;
  final String readingType;
  final int pumpTriggered;
  final String createdAt;

  SensorReading({
    this.id,
    required this.deviceId,
    required this.moistureValue,
    required this.readingType,
    required this.pumpTriggered,
    required this.createdAt,
  });

  factory SensorReading.fromMap(Map<String, dynamic> map) {
    return SensorReading(
      id: map['id'],
      deviceId: map['device_id'],
      moistureValue: map['moisture_value'],
      readingType: map['reading_type'],
      pumpTriggered: map['pump_triggered'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'device_id': deviceId,
      'moisture_value': moistureValue,
      'reading_type': readingType,
      'pump_triggered': pumpTriggered,
      'created_at': createdAt,
    };
  }
}