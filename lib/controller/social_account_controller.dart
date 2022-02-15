import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/constants.dart';
import 'package:personal_portfolio_admin_app/models/social_account.dart';

class SocialAccountController extends GetxController {
  static SocialAccountController instance = Get.find();
  final Rx<List<SocialAccount>> _socialAccount = Rx<List<SocialAccount>>([]);
  List<SocialAccount> get socialAccount => _socialAccount.value;

  @override
  void onInit() {
    super.onInit();
    _socialAccount.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('socialAccount')
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<SocialAccount> retValue = [];
        for (var element in query.docs) {
          retValue.add(SocialAccount.fromSnap(element));
        }

        return retValue;
      },
    ));
    update();
  }

  //upload to firebase storage
  Future<String> uploadtoStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('icons')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void addAccount(
    String uid,
    File? image,
    String url,
  ) async {
    String downloadUrl = await uploadtoStorage(image!);
    try {
      SocialAccount socialAccount = SocialAccount(
        uid: uid,
        icon: downloadUrl,
        profileUrl: url,
      );
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('socialAccount')
          .doc(uid)
          .set(socialAccount.toJson())
          .then((value) {
        Get.back();
      });
    } catch (e) {
      Get.snackbar(
        'Error Updating Icon Picture',
        e.toString(),
      );
    }

    update();
  }

  void deleteSocialAccount(uid) async {
    try {
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('socialAccount')
          .doc(uid)
          .delete();
    } catch (e) {
      Get.snackbar(
        'Error Deleting socialAccount',
        e.toString(),
      );
    }
  }
}
