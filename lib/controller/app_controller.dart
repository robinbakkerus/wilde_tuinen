import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/model/garden.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/service/firestore_service.dart';

class AppController {
  static final AppController _singleton = new AppController._internal();

  factory AppController() {
    return _singleton;
  }

  AppController._internal() {
    AppEvents.onTakePicture(_onTakePicture);
    AppEvents.onSaveGarden(_onSaveGarden);
    AppEvents.onAddGarden(_onAddGarden);
  }

  void _onTakePicture(TakePictureEvent event) {
    AppEvents.fireSwitchStack(StackType.MAIN, STACK_TAKE_PICTURE);
  }

  void _onSaveGarden(SaveGardenEvent event) {
    var g = event.garden;
    g.lastupdated = DateTime.now();
    g.updatedBy = ""; //todo
    FirestoreService()..saveGarden(g);
    //Todo geef okay msg
    AppEvents.fireSwitchStack(StackType.MAIN, STACK_HOME);
  }

  void _onAddGarden(AddGardenEvent event) {
    AppData().currentGarden = Garden();
    AppEvents.fireSwitchStack(StackType.START_PAGE, STACK_ADD);
  }
}
