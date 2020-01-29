import 'package:geolocator/geolocator.dart';

class LocationRepository {
  final Geolocator _geolocator;

  LocationRepository({Geolocator geolocator})
      : _geolocator = geolocator,
        assert(geolocator != null);

  Future<Position> getCurrentLocation() {
    return _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<Placemark> getAddress(Position pos) async {
    try {
      List<Placemark> p = await _geolocator.placemarkFromCoordinates(
          pos.latitude, pos.longitude);

      return p[0];
    } catch (e) {
      print(e);
      return null;
    }
  }

  
}
