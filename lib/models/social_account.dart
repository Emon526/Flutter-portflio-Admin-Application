import 'package:cloud_firestore/cloud_firestore.dart';

class SocialAccount {
  String icon;
  String profileUrl;

  String uid;

  SocialAccount({
    required this.icon,
    required this.profileUrl,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "icon": icon,
        "profileUrl": profileUrl,
        "uid": uid,
      };

  static SocialAccount fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return SocialAccount(
      icon: snapshot['icon'],
      profileUrl: snapshot['profileUrl'],
      uid: snapshot['uid'],
    );
  }
}
