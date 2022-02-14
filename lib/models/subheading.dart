import 'package:cloud_firestore/cloud_firestore.dart';

class SubHeading {
  String title;
  String subtitle;
  String uid;

  SubHeading({
    required this.title,
    required this.subtitle,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "uid": uid,
      };

  static SubHeading fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return SubHeading(
      title: snapshot['title'],
      subtitle: snapshot['subtitle'],
      uid: snapshot['uid'],
    );
  }
}
