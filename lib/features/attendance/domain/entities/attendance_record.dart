import 'package:equatable/equatable.dart';

class AttendanceRecord extends Equatable {
  const AttendanceRecord({
    required this.timestamp,
    required this.currentLat,
    required this.currentLon,
    required this.distanceAtCheckIn,
  });

  final DateTime timestamp;
  final double currentLat;
  final double currentLon;
  final double distanceAtCheckIn;

  @override
  List<Object?> get props => [timestamp, currentLat, currentLon, distanceAtCheckIn];
}
