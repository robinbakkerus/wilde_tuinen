import 'package:camera/camera.dart';
import 'package:wilde_tuinen/model/garden.dart';

class Constants {
  static late String title;
  static late CameraDescription camera;
  static late String imagePath;
}

const int STACK_HOME = 0;
const int STACK_ADD = 1;
const int STACK_TAKE_PICTURE = 2;
const int STACK_ADMIN = 3;

class AppData {
  static Garden currentGarden = Garden();

  static prepareGarden() => currentGarden = Garden();
}
