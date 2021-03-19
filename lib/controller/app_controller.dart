import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/model/garden.dart';
import 'package:wilde_tuinen/util/image_utils.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/service/firestore_service.dart';

class AppController {
  static final AppController _singleton = new AppController._internal();

  factory AppController() {
    return _singleton;
  }

  AppController._internal() {
    AppEvents.onTakePicture(_onTakePicture);
    AppEvents.onCompressPicture(_onCompressPicture);
    AppEvents.onSaveGarden(_onSaveGarden);
    AppEvents.onAddGarden(_onAddGarden);
  }

  void _onTakePicture(TakePictureEvent event) {
    AppEvents.fireSwitchStack(STACK_TAKE_PICTURE);
  }

  void _onCompressPicture(CompressPictureEvent event) {
    String compressedPath = ImageUtils.compress(event.imagePath);
    // AppData.currentGarden.fotoBase64 = ImageUtils.imageAsBase64(compressedPath);
    AppEvents.fireShowPicture(compressedPath);
    AppEvents.fireSwitchStack(STACK_SHOW_PICTURE);
  }

  void _onSaveGarden(SaveGardenEvent event) {
    AppData.currentGarden.lastupdated = DateTime.now();
    AppData.currentGarden.updatedBy = ""; //todo
    FirestoreService()..saveVolunteer(AppData.currentGarden);
    //Todo geef okay msg
    AppEvents.fireSwitchStack(STACK_HOME.hashCode);
  }

  void _onAddGarden(AddGardenEvent event) {
    AppData.currentGarden = Garden();
    AppEvents.fireSwitchStack(STACK_ADD);
  }
}
