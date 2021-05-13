import 'package:location/location.dart';
import '../data/app_data.dart';

class LocationHelper {
  static final LocationHelper _singleton = new LocationHelper._internal();

  factory LocationHelper() {
    return _singleton;
  }

  LocationHelper._internal();

  Location location = new Location();
  late LocationData _locationData;
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;

  Future<LocationData> locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.value(null);
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.value(null);
      }
    }

    _locationData = await location.getLocation();
    AppData().currentLocationData = _locationData;
    return _locationData;
  }
}
