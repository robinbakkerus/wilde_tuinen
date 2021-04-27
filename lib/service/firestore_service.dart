import 'dart:convert';
import 'dart:developer'; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wilde_tuinen/model/garden.dart';

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

      String json = jsonEncode(garden);
      var map = jsonDecode(json);

      gardens
          .add(map)
          .then((value) => print('Added garden'))
          .catchError((error) => print("Failed to add garden: $error"));
    } catch (ex) {
      log("Failed to add garden: $ex");
    }
  }
}
