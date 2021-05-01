// import 'dart:convert';
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

      garden.lastupdated = DateTime.now();
      garden.updatedBy = 'todo';
      garden.id = DateTime.now().millisecondsSinceEpoch;
      garden.name = 'test';
      var json = garden.toJson();
//      log('json = ' + json.toString());

      gardens
          .add(json)
          .then((value) => print('Added garden'))
          .catchError((error) => log("Failed to add garden. $error"));
    } catch (ex) {
      log("Failed to add garden: $ex");
    }
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }
}
