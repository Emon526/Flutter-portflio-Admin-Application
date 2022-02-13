import 'package:cloud_firestore/cloud_firestore.dart';

class Skill {
  String skillName;
  String skillPercentage;
  String uid;

  Skill({
    required this.skillName,
    required this.skillPercentage,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "skillName": skillName,
        "skillpercentage": skillPercentage,
        "uid": uid,
      };

  static Skill fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Skill(
      skillName: snapshot['skillName'],
      skillPercentage: snapshot['skillpercentage'],
      uid: snapshot['uid'],
    );
  }
}
