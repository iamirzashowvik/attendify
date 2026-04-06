import 'package:attendify/features/attendance/domain/entities/office_location.dart';
import 'package:attendify/features/attendance/domain/repositories/attendance_repository.dart';

class SetOfficeLocation {
  const SetOfficeLocation(this._repository);

  final AttendanceRepository _repository;

  Future<OfficeLocation> call() => _repository.setCurrentLocationAsOffice();
}
