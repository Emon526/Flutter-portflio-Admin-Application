import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constants.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();

  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uid = "".obs;
  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    String cv = userData['cv'];
    String coverphoto = userData['coverphoto'];
    String age = userData['age'];
    String city = userData['city'];
    String description = userData['description'];
    String residence = userData['residence'];
    String heading = userData['heading'];

    _user.value = {
      'name': name,
      'age': age,
      'city': city,
      'residence': residence,
      'description': description,
      'profilePhoto': profilePhoto,
      'cv': cv,
      'coverphoto': coverphoto,
      'heading': heading,
    };
    update();
  }
}
