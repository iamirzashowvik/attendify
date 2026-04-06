import 'package:attendify/features/attendance/domain/repositories/attendance_repository.dart';

class WatchDistanceToOffice {
  const WatchDistanceToOffice(this._repository);

  final AttendanceRepository _repository;

  Stream<DistanceSnapshot> call() => _repository.watchDistanceToOffice();
}
