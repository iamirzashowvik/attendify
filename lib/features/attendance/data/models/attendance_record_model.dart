import 'package:attendify/features/attendance/domain/entities/attendance_record.dart';

class AttendanceRecordModel extends AttendanceRecord {
  const AttendanceRecordModel({
    required super.timestamp,
    required super.currentLat,
    required super.currentLon,
    required super.distanceAtCheckIn,
  });

  Map<String, Object> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'current_lat': currentLat,
        'current_lon': currentLon,
        'distance_at_check_in': distanceAtCheckIn,
      };

  factory AttendanceRecordModel.fromJson(Map<String, Object?> json) {
    return AttendanceRecordModel(
      timestamp: DateTime.parse(json['timestamp'] as String),
      currentLat: json['current_lat'] as double,
      currentLon: json['current_lon'] as double,
      distanceAtCheckIn: json['distance_at_check_in'] as double,
    );
  }
}
