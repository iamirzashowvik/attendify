import 'dart:math';

class DistanceCalculator {
  static double metersBetween({
    required double startLat,
    required double startLon,
    required double endLat,
    required double endLon,
  }) {
    const earthRadius = 6371000.0;
    final dLat = _toRadians(endLat - startLat);
    final dLon = _toRadians(endLon - startLon);

    final a = pow(sin(dLat / 2), 2) +
        cos(_toRadians(startLat)) *
            cos(_toRadians(endLat)) *
            pow(sin(dLon / 2), 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  static double _toRadians(double degree) => degree * pi / 180;
}
