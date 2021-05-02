import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/service/firestore_service.dart';

class AppController {
  static final AppController _singleton = new AppController._internal();

  factory AppController() {
    return _singleton;
  }

  AppController._internal() {
    AppEvents.onSaveGarden(_onSaveGarden);
    // AppEvents.onRetrieveGardens(_onRetrieveGardens);
    FirestoreService()..retrieveAllGardens();
  }

  void _onSaveGarden(SaveGardenEvent event) {
    var g = event.garden;
    g.lastupdated = DateTime.now();
    g.updatedBy = ""; //todo
    FirestoreService()..saveGarden(g);
    //Todo geef okay msg
    AppEvents.fireSwitchStack(STACK_HOME);
  }

  // void _onRetrieveGardens(RetrieveGardensEvent event) {
    // FirestoreService()..retrieveAllGardens();
  // }
}
