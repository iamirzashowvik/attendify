import 'package:attendify/features/attendance/domain/entities/attendance_record.dart';
import 'package:attendify/features/attendance/domain/repositories/attendance_repository.dart';

class MarkAttendance {
  const MarkAttendance(this._repository);

  final AttendanceRepository _repository;

  Future<AttendanceRecord> call() => _repository.markAttendance();
}
