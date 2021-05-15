import 'package:wilde_tuinen/event/app_events.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/service/firestore_service.dart';
// import 'dart:developer';

class AppController {
  static final AppController _singleton = new AppController._internal();

  factory AppController() {
    return _singleton;
  }

  AppController._internal() {
    AppEvents.onSaveGarden(_onSaveGarden);
    FirestoreService()..retrieveAllGardens();
  }

  void _onSaveGarden(SaveGardenEvent event) {
    var g = event.garden;

    final isNew = g.id == 0;

    g.lastupdated = DateTime.now();
    g.updatedBy = 'todo';
    FirestoreService()..saveGarden(g);

    if (isNew) {
      AppData().gardens.add(AppData().newGarden);
    } else {
      // var updateGarden = AppData().gardens.firstWhere((element) => element.id == g.id);
      // updateGarden = g;
    }

    AppEvents.fireGardensRetrieved();
  }
}
