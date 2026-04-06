import 'package:attendify/features/attendance/domain/entities/attendance_record.dart';
import 'package:attendify/features/attendance/domain/entities/office_location.dart';

class DistanceSnapshot {
  const DistanceSnapshot({
    required this.currentLat,
    required this.currentLon,
    required this.distanceMeters,
    required this.isInRange,
  });

  final double currentLat;
  final double currentLon;
  final double distanceMeters;
  final bool isInRange;
}

abstract class AttendanceRepository {
  static const checkInRadiusMeters = 50;

  Future<OfficeLocation?> getSavedOfficeLocation();

  Future<OfficeLocation> setCurrentLocationAsOffice();

  Stream<DistanceSnapshot> watchDistanceToOffice();

  Future<AttendanceRecord> markAttendance();
}
