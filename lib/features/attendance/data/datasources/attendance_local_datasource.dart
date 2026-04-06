import 'dart:convert';

import 'package:attendify/features/attendance/data/models/attendance_record_model.dart';
import 'package:attendify/features/attendance/data/models/office_location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceLocalDataSource {
  AttendanceLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  static const _officeLocationKey = 'office_location';
  static const _attendanceRecordsKey = 'attendance_records';

  Future<void> saveOfficeLocation(OfficeLocationModel model) async {
    await _prefs.setString(_officeLocationKey, jsonEncode(model.toJson()));
  }

  OfficeLocationModel? getOfficeLocation() {
    final raw = _prefs.getString(_officeLocationKey);
    if (raw == null) return null;
    return OfficeLocationModel.fromJson(
      Map<String, Object?>.from(jsonDecode(raw) as Map),
    );
  }

  Future<void> saveAttendanceRecord(AttendanceRecordModel record) async {
    final existing = _prefs.getStringList(_attendanceRecordsKey) ?? <String>[];
    existing.add(jsonEncode(record.toJson()));
    await _prefs.setStringList(_attendanceRecordsKey, existing);
  }
}
