class PumpActivation {
  final int? id;
  final int deviceId;
  final String triggerType;
  final String startedAt;
  final String? endedAt;
  final int? durationSeconds;

  PumpActivation({
    this.id,
    required this.deviceId,
    required this.triggerType,
    required this.startedAt,
    this.endedAt,
    this.durationSeconds,
  });

  factory PumpActivation.fromMap(Map<String, dynamic> map) {
    return PumpActivation(
      id: map['id'],
      deviceId: map['device_id'],
      triggerType: map['trigger_type'],
      startedAt: map['started_at'],
      endedAt: map['ended_at'],
      durationSeconds: map['duration_seconds'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'device_id': deviceId,
      'trigger_type': triggerType,
      'started_at': startedAt,
      'ended_at': endedAt,
      'duration_seconds': durationSeconds,
    };
  }
}