import 'package:attendify/core/services/location_permission_service.dart';
import 'package:attendify/core/utils/date_time_provider.dart';
import 'package:attendify/features/attendance/data/datasources/attendance_local_datasource.dart';
import 'package:attendify/features/attendance/data/datasources/location_datasource.dart';
import 'package:attendify/features/attendance/data/repositories/attendance_repository_impl.dart';
import 'package:attendify/features/attendance/domain/usecases/mark_attendance.dart';
import 'package:attendify/features/attendance/domain/usecases/set_office_location.dart';
import 'package:attendify/features/attendance/domain/usecases/watch_distance_to_office.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDependencies {
  AppDependencies._({
    required this.attendanceRepository,
    required this.setOfficeLocationUseCase,
    required this.watchDistanceToOfficeUseCase,
    required this.markAttendanceUseCase,
  });

  final AttendanceRepositoryImpl attendanceRepository;
  final SetOfficeLocation setOfficeLocationUseCase;
  final WatchDistanceToOffice watchDistanceToOfficeUseCase;
  final MarkAttendance markAttendanceUseCase;

  static Future<AppDependencies> create() async {
    final prefs = await SharedPreferences.getInstance();

    final local = AttendanceLocalDataSource(prefs);
    final permissionService = LocationPermissionService();
    final locationSource = LocationDataSource(permissionService);

    final repo = AttendanceRepositoryImpl(
      localDataSource: local,
      locationDataSource: locationSource,
      dateTimeProvider: DateTimeProvider(),
    );

    return AppDependencies._(
      attendanceRepository: repo,
      setOfficeLocationUseCase: SetOfficeLocation(repo),
      watchDistanceToOfficeUseCase: WatchDistanceToOffice(repo),
      markAttendanceUseCase: MarkAttendance(repo),
    );
  }
}
