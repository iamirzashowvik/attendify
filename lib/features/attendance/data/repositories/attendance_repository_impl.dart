import 'package:attendify/core/error/failures.dart';
import 'package:attendify/core/utils/date_time_provider.dart';
import 'package:attendify/core/utils/distance_calculator.dart';
import 'package:attendify/features/attendance/data/datasources/attendance_local_datasource.dart';
import 'package:attendify/features/attendance/data/datasources/location_datasource.dart';
import 'package:attendify/features/attendance/data/models/attendance_record_model.dart';
import 'package:attendify/features/attendance/data/models/office_location_model.dart';
import 'package:attendify/features/attendance/domain/entities/attendance_record.dart';
import 'package:attendify/features/attendance/domain/entities/office_location.dart';
import 'package:attendify/features/attendance/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  AttendanceRepositoryImpl({
    required AttendanceLocalDataSource localDataSource,
    required LocationDataSource locationDataSource,
    required DateTimeProvider dateTimeProvider,
  })  : _localDataSource = localDataSource,
        _locationDataSource = locationDataSource,
        _dateTimeProvider = dateTimeProvider;

  final AttendanceLocalDataSource _localDataSource;
  final LocationDataSource _locationDataSource;
  final DateTimeProvider _dateTimeProvider;

  @override
  Future<OfficeLocation?> getSavedOfficeLocation() async {
    return _localDataSource.getOfficeLocation();
  }

  @override
  Future<OfficeLocation> setCurrentLocationAsOffice() async {
    try {
      await _locationDataSource.ensureLocationReady();
      final current = await _locationDataSource.getCurrentPosition();

      final office = OfficeLocationModel(
        lat: current.latitude,
        lon: current.longitude,
        setAt: _dateTimeProvider.now(),
      );

      await _localDataSource.saveOfficeLocation(office);
      return office;
    } on LocationServiceDisabledException {
      throw const ServiceFailure('Location service is disabled.');
    } on LocationPermissionDeniedForeverException {
      throw const PermissionFailure('Location permission denied forever.');
    } on LocationPermissionDeniedException {
      throw const PermissionFailure('Location permission denied.');
    }
  }

  @override
  Stream<DistanceSnapshot> watchDistanceToOffice() async* {
    final office = _localDataSource.getOfficeLocation();
    if (office == null) {
      throw const ValidationFailure('Please set office location first.');
    }

    try {
      await _locationDataSource.ensureLocationReady();
      await for (final pos in _locationDataSource.watchPosition()) {
        final distance = DistanceCalculator.metersBetween(
          startLat: office.lat,
          startLon: office.lon,
          endLat: pos.latitude,
          endLon: pos.longitude,
        );

        yield DistanceSnapshot(
          currentLat: pos.latitude,
          currentLon: pos.longitude,
          distanceMeters: distance,
          isInRange: distance <= AttendanceRepository.checkInRadiusMeters,
        );
      }
    } on LocationServiceDisabledException {
      throw const ServiceFailure('Location service is disabled.');
    } on LocationPermissionDeniedForeverException {
      throw const PermissionFailure('Location permission denied forever.');
    } on LocationPermissionDeniedException {
      throw const PermissionFailure('Location permission denied.');
    }
  }

  @override
  Future<AttendanceRecord> markAttendance() async {
    final office = _localDataSource.getOfficeLocation();
    if (office == null) {
      throw const ValidationFailure('Office location not set.');
    }

    try {
      await _locationDataSource.ensureLocationReady();
      final current = await _locationDataSource.getCurrentPosition();
      final distance = DistanceCalculator.metersBetween(
        startLat: office.lat,
        startLon: office.lon,
        endLat: current.latitude,
        endLon: current.longitude,
      );

      if (distance > AttendanceRepository.checkInRadiusMeters) {
        throw const ValidationFailure('You are out of range for check-in.');
      }

      final record = AttendanceRecordModel(
        timestamp: _dateTimeProvider.now(),
        currentLat: current.latitude,
        currentLon: current.longitude,
        distanceAtCheckIn: distance,
      );
      await _localDataSource.saveAttendanceRecord(record);
      return record;
    } on LocationServiceDisabledException {
      throw const ServiceFailure('Location service is disabled.');
    } on LocationPermissionDeniedForeverException {
      throw const PermissionFailure('Location permission denied forever.');
    } on LocationPermissionDeniedException {
      throw const PermissionFailure('Location permission denied.');
    }
  }
}
