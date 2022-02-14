import 'package:cloud_firestore/cloud_firestore.dart';

class Recommendation {
  String recommendarName;
  String platfrom;
  String review;
  String uid;

  Recommendation({
    required this.recommendarName,
    required this.review,
    required this.uid,
    required this.platfrom,
  });

  Map<String, dynamic> toJson() => {
        "recommendarName": recommendarName,
        "platfrom": platfrom,
        "review": review,
        "uid": uid,
      };

  static Recommendation fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Recommendation(
      recommendarName: snapshot['recommendarName'],
      platfrom: snapshot['platfrom'],
      review: snapshot['review'],
      uid: snapshot['uid'],
    );
  }
}
