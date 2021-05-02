import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wilde_tuinen/data/app_data.dart';
import 'package:wilde_tuinen/model/garden.dart';
import 'package:wilde_tuinen/event/app_events.dart';

class FirestoreService {
  static final FirestoreService _singleton = new FirestoreService._internal();

  factory FirestoreService() {
    return _singleton;
  }

  FirestoreService._internal();

  Future<void> saveGarden(Garden garden) async {
    try {
      CollectionReference gardens =
          FirebaseFirestore.instance.collection('wild-gardens');

      garden.lastupdated = DateTime.now();
      garden.updatedBy = 'todo';
      garden.id = DateTime.now().millisecondsSinceEpoch;
      var json = garden.toJson();

      gardens
          .add(json)
          .then((value) => print('Added garden'))
          .catchError((error) => log("Failed to add garden. $error"));
    } catch (ex) {
      log("Failed to add garden: $ex");
    }
  }

  void retrieveAllGardens() {
    FirebaseFirestore.instance
        .collection('wild-gardens')
        .get()
        .then((querySnapshot) => _mapSnapshot(querySnapshot));
  }

  _mapSnapshot(QuerySnapshot snapshot) {
    AppData().gardens.clear();

     snapshot.docs.forEach((doc) =>
                  AppData().gardens.add(Garden.fromJson(doc.data() as Map<String, dynamic>)));
      
    AppEvents.fireGardensRetrieved();
  }
}
