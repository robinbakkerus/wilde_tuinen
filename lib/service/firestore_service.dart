import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wilde_tuinen/model/garden.dart';

class FirestoreService {

static final FirestoreService _singleton = new FirestoreService._internal();

  factory FirestoreService() {
    return _singleton;
  }

  FirestoreService._internal() ;

  Object saveVolunteer(Garden garden) async {
    final databaseReference = Firestore.instance;
    DocumentReference ref = await databaseReference
        .collection("vrijwilligers")
        .add(Garden.toJson());
    print(ref.documentID);
    return ref.documentID;
  }


}