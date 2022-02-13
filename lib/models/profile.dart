import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String profilePhoto;
  String name;
  String description;
  String residence;
  String city;
  String age;
  String uid;

  Profile({
    required this.name,
    required this.description,
    required this.profilePhoto,
    required this.residence,
    required this.city,
    required this.age,
    required this.uid,
  });
  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "profilePhoto": profilePhoto,
        "residence": residence,
        "city": city,
        "age": age,
        "uid": uid,
      };

  static Profile fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Profile(
      name: snapshot['name'],
      uid: snapshot['uid'],
      profilePhoto: snapshot['profilePhoto'],
      age: snapshot['age'],
      city: snapshot['city'],
      description: snapshot['description'],
      residence: snapshot['residence'],
    );
  }
}
