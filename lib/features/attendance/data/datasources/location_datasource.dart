import 'package:attendify/core/services/location_permission_service.dart';
import 'package:geolocator/geolocator.dart';

class LocationDataSource {
  LocationDataSource(this._permissionService);

  final LocationPermissionService _permissionService;

  Future<void> ensureLocationReady() async {
    final serviceEnabled = await _permissionService.isServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException();
    }

    var permission = await _permissionService.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _permissionService.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw LocationPermissionDeniedException();
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedForeverException();
    }
  }

  Future<Position> getCurrentPosition() {
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
    );
  }

  Stream<Position> watchPosition() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    );
  }
}

class LocationServiceDisabledException implements Exception {}

class LocationPermissionDeniedException implements Exception {}

class LocationPermissionDeniedForeverException implements Exception {}
