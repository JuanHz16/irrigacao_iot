class Device {
  final int? id;
  final String name;
  final String ipAddress;
  final int active;
  final String createdAt;

  Device({
    this.id,
    required this.name,
    required this.ipAddress,
    required this.active,
    required this.createdAt,
  });

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      id: map['id'],
      name: map['name'],
      ipAddress: map['ip_address'],
      active: map['active'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'ip_address': ipAddress,
      'active': active,
      'created_at': createdAt,
    };
  }
}