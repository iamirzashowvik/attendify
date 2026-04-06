import 'package:attendify/app/di.dart';
import 'package:attendify/features/attendance/presentation/cubit/attendance_cubit.dart';
import 'package:attendify/features/attendance/presentation/view/attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendifyApp extends StatelessWidget {
  const AttendifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<AppDependencies>(
      future: AppDependencies.create(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        final deps = snapshot.data!;
        return RepositoryProvider.value(
          value: deps.attendanceRepository,
          child: BlocProvider(
            create: (_) => AttendanceCubit(
              setOfficeLocationUseCase: deps.setOfficeLocationUseCase,
              watchDistanceToOfficeUseCase: deps.watchDistanceToOfficeUseCase,
              markAttendanceUseCase: deps.markAttendanceUseCase,
            )..initialize(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Attendify GeoCheck',
              theme: ThemeData(
                colorSchemeSeed: const Color(0xFF2F5BEA),
                useMaterial3: true,
              ),
              home: const AttendanceScreen(),
            ),
          ),
        );
      },
    );
  }
}
