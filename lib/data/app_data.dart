import 'package:camera/camera.dart';
import 'package:location/location.dart';
import 'package:wilde_tuinen/model/garden.dart';

class Constants {
  static late String title;
  static late CameraDescription camera;
  static late String imagePath;
}

const int STACK_HOME = 0;
const int STACK_DETAIL_PAGE = 1;
const int STACK_TAKE_PICTURE = 2;
const int STACK_ADMIN = 3;

class AppData {
  static final AppData _singleton = AppData._internal();

  factory AppData() {
    return _singleton;
  }

  AppData._internal();

  Garden currentGarden = Garden();
  Garden newGarden = Garden();
  Set<Garden> gardens = new Set();
  
  late LocationData _currentLocationData;
  LocationData get currentLocationData => _currentLocationData;
  set currentLocationData(LocationData locdata) {
    this._currentLocationData = locdata;
    this.newGarden.lat = locdata.latitude as double;
    this.newGarden.lng = locdata.longitude as double;
  }

}
