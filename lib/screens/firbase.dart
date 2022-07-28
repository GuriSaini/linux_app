import 'package:cloud_firestore/cloud_firestore.dart';

class Firbase {
  final _db = FirebaseFirestore.instance;

  String Add(String collectionName, data) {
    _db.collection(collectionName).add(data).then((value) => null);
    return "";
  }
}
