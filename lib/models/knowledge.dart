import 'package:cloud_firestore/cloud_firestore.dart';

class Knowledge {
  String knowledgeName;

  String uid;

  Knowledge({
    required this.knowledgeName,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "knowledgeName": knowledgeName,
        "uid": uid,
      };

  static Knowledge fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Knowledge(
      knowledgeName: snapshot['knowledgeName'],
      uid: snapshot['uid'],
    );
  }
}
