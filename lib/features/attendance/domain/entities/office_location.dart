import 'package:equatable/equatable.dart';

class OfficeLocation extends Equatable {
  const OfficeLocation({
    required this.lat,
    required this.lon,
    required this.setAt,
  });

  final double lat;
  final double lon;
  final DateTime setAt;

  @override
  List<Object?> get props => [lat, lon, setAt];
}
