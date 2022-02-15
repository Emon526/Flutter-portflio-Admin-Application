import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String projectName;
  String projectDescription;
  String uid;

  Project({
    required this.projectName,
    required this.projectDescription,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "projectName": projectName,
        "projectDescription": projectDescription,
        "uid": uid,
      };

  static Project fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Project(
      projectName: snapshot['projectName'],
      projectDescription: snapshot['projectDescription'],
      uid: snapshot['uid'],
    );
  }
}
