import 'package:attendify/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:attendify/features/attendance/presentation/cubit/attendance_state.dart';
import 'package:attendify/features/attendance/presentation/widgets/attendance_button.dart';
import 'package:attendify/features/attendance/presentation/widgets/distance_gauge.dart';
import 'package:attendify/features/attendance/presentation/widgets/office_context_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              OfficeContextCard(
                officeLocation: state.officeLocation,
                onSetOfficePressed: () {
                  context.read<AttendanceCubit>().setOfficeLocation();
                },
              ),
              const SizedBox(height: 24),
              DistanceGauge(
                distanceMeters: state.distanceMeters,
                isInRange: state.isInRange,
              ),
              const SizedBox(height: 24),
              AttendanceButton(
                enabled: state.canMarkAttendance,
                onPressed: () => context.read<AttendanceCubit>().markAttendance(),
              ),
              if (state.status == AttendanceStatus.loading) ...[
                const SizedBox(height: 16),
                const Center(child: CircularProgressIndicator()),
              ],
            ],
          );
        },
      ),
    );
  }
}
