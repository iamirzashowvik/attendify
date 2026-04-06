import 'package:attendify/features/attendance/domain/entities/office_location.dart';

class OfficeLocationModel extends OfficeLocation {
  const OfficeLocationModel({
    required super.lat,
    required super.lon,
    required super.setAt,
  });

  Map<String, Object> toJson() => {
        'lat': lat,
        'lon': lon,
        'set_at': setAt.toIso8601String(),
      };

  factory OfficeLocationModel.fromJson(Map<String, Object?> json) {
    return OfficeLocationModel(
      lat: json['lat'] as double,
      lon: json['lon'] as double,
      setAt: DateTime.parse(json['set_at'] as String),
    );
  }
}
