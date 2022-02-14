import 'package:cloud_firestore/cloud_firestore.dart';

class OverView {
  String name;
  String amount;
  String uid;

  OverView({
    required this.name,
    required this.amount,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "uid": uid,
      };

  static OverView fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return OverView(
      name: snapshot['name'],
      amount: snapshot['amount'],
      uid: snapshot['uid'],
    );
  }
}
