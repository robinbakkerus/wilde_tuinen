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

      if (garden.id == 0) {
        garden.id = DateTime.now().millisecondsSinceEpoch;
        DocumentReference docRef = gardens.doc(garden.id.toString());
        _addGarden(docRef, garden);
      } else {
        DocumentReference docRef = gardens.doc(garden.id.toString());
        _updateGarden(docRef, garden);
      }
    } catch (ex) {
      log("Failed to add garden: $ex");
    }
  }

  Future<void> _addGarden(DocumentReference docRef, Garden garden) async {
    var json = garden.toJson();
    // log('json = ' + json.toString());

    await docRef.set(json).whenComplete(() => null).catchError((e) => print(e));
  }

  Future<void> _updateGarden(DocumentReference docRef, Garden garden) async {
    var json = garden.toJson();
    // log('json = ' + json.toString());

    await docRef
        .update(json)
        .whenComplete(() => null)
        .catchError((e) => print(e));
  }

  void retrieveAllGardens() {
    FirebaseFirestore.instance
        .collection('wild-gardens')
        .get()
        .then((querySnapshot) => _mapSnapshot(querySnapshot));
  }

  _mapSnapshot(QuerySnapshot snapshot) {
    AppData().gardens.clear();

    snapshot.docs.forEach((doc) {
      // log('doc = ' + doc.data().toString());

      AppData()
          .gardens
          .add(Garden.fromJson(doc.data() as Map<String, dynamic>));

    });

    //           AppData().gardens.add(Garden.fromJson(doc.data() as Map<String, dynamic>)));

    AppEvents.fireGardensRetrieved();
  }
}
