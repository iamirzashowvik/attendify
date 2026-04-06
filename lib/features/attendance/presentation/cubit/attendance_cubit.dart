import 'dart:async';

import 'package:attendify/core/error/failures.dart';
import 'package:attendify/features/attendance/domain/usecases/mark_attendance.dart';
import 'package:attendify/features/attendance/domain/usecases/set_office_location.dart';
import 'package:attendify/features/attendance/domain/usecases/watch_distance_to_office.dart';
import 'package:attendify/features/attendance/presentation/cubit/attendance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit({
    required SetOfficeLocation setOfficeLocationUseCase,
    required WatchDistanceToOffice watchDistanceToOfficeUseCase,
    required MarkAttendance markAttendanceUseCase,
  })  : _setOfficeLocationUseCase = setOfficeLocationUseCase,
        _watchDistanceToOfficeUseCase = watchDistanceToOfficeUseCase,
        _markAttendanceUseCase = markAttendanceUseCase,
        super(const AttendanceState());

  final SetOfficeLocation _setOfficeLocationUseCase;
  final WatchDistanceToOffice _watchDistanceToOfficeUseCase;
  final MarkAttendance _markAttendanceUseCase;

  StreamSubscription? _distanceSubscription;

  Future<void> initialize() async {
    emit(state.copyWith(status: AttendanceStatus.ready));
  }

  Future<void> setOfficeLocation() async {
    emit(state.copyWith(status: AttendanceStatus.loading, clearMessage: true));
    try {
      final office = await _setOfficeLocationUseCase();
      emit(
        state.copyWith(
          status: AttendanceStatus.success,
          officeLocation: office,
          message: 'Office location saved successfully.',
        ),
      );
      await startDistanceTracking();
    } catch (error) {
      emit(
        state.copyWith(
          status: AttendanceStatus.error,
          message: _mapError(error),
        ),
      );
    }
  }

  Future<void> startDistanceTracking() async {
    await _distanceSubscription?.cancel();
    _distanceSubscription = _watchDistanceToOfficeUseCase().listen(
      (distanceState) {
        emit(
          state.copyWith(
            status: AttendanceStatus.ready,
            currentLat: distanceState.currentLat,
            currentLon: distanceState.currentLon,
            distanceMeters: distanceState.distanceMeters,
            isInRange: distanceState.isInRange,
            canMarkAttendance: distanceState.isInRange,
            clearMessage: true,
          ),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(
            status: AttendanceStatus.error,
            message: _mapError(error),
          ),
        );
      },
    );
  }

  Future<void> markAttendance() async {
    if (!state.canMarkAttendance) {
      emit(
        state.copyWith(
          status: AttendanceStatus.error,
          message: 'Out of range. Move within 50m to check in.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: AttendanceStatus.loading, clearMessage: true));
    try {
      await _markAttendanceUseCase();
      emit(
        state.copyWith(
          status: AttendanceStatus.success,
          message: 'Attendance marked successfully.',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: AttendanceStatus.error,
          message: _mapError(error),
        ),
      );
    }
  }

  String _mapError(Object error) {
    if (error is Failure) {
      return error.message;
    }
    return 'Unexpected error occurred.';
  }

  @override
  Future<void> close() async {
    await _distanceSubscription?.cancel();
    return super.close();
  }
}
