import 'package:location/location.dart';

Location _location = Location();

late bool _serviceEnabled;
late PermissionStatus _permissionGranted;

Future<LocationData?> getUserLocation() async {
  _serviceEnabled = await _location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await _location.requestService();
    if (!_serviceEnabled) {
      return null;
    }
  }

  _permissionGranted = await _location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await _location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return null;
    }
  }

  return await _location.getLocation();
}
