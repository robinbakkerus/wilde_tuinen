import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wilde_tuinen/model/garden.dart';

class FirestoreService {
  static final FirestoreService _singleton = new FirestoreService._internal();

  factory FirestoreService() {
    return _singleton;
  }

  FirestoreService._internal();

  Future<void> saveVolunteer(Garden garden) async {
    CollectionReference gardens =
        FirebaseFirestore.instance.collection('vrijwilligers');

    gardens
        .add(garden.toJson())
        .then((value) => print('Added garden'))
        .catchError((error) => print("Failed to add garden: $error"));
  }
}
