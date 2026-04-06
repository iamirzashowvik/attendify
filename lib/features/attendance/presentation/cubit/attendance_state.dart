import 'package:attendify/features/attendance/domain/entities/office_location.dart';
import 'package:equatable/equatable.dart';

enum AttendanceStatus { initial, loading, ready, success, error }

class AttendanceState extends Equatable {
  const AttendanceState({
    this.status = AttendanceStatus.initial,
    this.officeLocation,
    this.currentLat,
    this.currentLon,
    this.distanceMeters,
    this.isInRange = false,
    this.canMarkAttendance = false,
    this.message,
  });

  final AttendanceStatus status;
  final OfficeLocation? officeLocation;
  final double? currentLat;
  final double? currentLon;
  final double? distanceMeters;
  final bool isInRange;
  final bool canMarkAttendance;
  final String? message;

  AttendanceState copyWith({
    AttendanceStatus? status,
    OfficeLocation? officeLocation,
    double? currentLat,
    double? currentLon,
    double? distanceMeters,
    bool? isInRange,
    bool? canMarkAttendance,
    String? message,
    bool clearMessage = false,
  }) {
    return AttendanceState(
      status: status ?? this.status,
      officeLocation: officeLocation ?? this.officeLocation,
      currentLat: currentLat ?? this.currentLat,
      currentLon: currentLon ?? this.currentLon,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      isInRange: isInRange ?? this.isInRange,
      canMarkAttendance: canMarkAttendance ?? this.canMarkAttendance,
      message: clearMessage ? null : (message ?? this.message),
    );
  }

  @override
  List<Object?> get props => [
        status,
        officeLocation,
        currentLat,
        currentLon,
        distanceMeters,
        isInRange,
        canMarkAttendance,
        message,
      ];
}
