import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/models/overview.dart';
import 'package:personal_portfolio_admin_app/models/subheading.dart';
import '../constants.dart';

class HeadingController extends GetxController {
  static HeadingController instance = Get.find();
  //pick image
  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;

  final Rx<double> _percentage = 0.0.obs;

  double get percentage => _percentage.value;
  final Rx<List<OverView>> _overview = Rx<List<OverView>>([]);
  List<OverView> get overview => _overview.value;

  final Rx<List<SubHeading>> _subheading = Rx<List<SubHeading>>([]);
  List<SubHeading> get subheading => _subheading.value;

  @override
  void onInit() {
    super.onInit();
    _overview.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('overview')
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<OverView> retValue = [];
        for (var element in query.docs) {
          retValue.add(OverView.fromSnap(element));
        }

        return retValue;
      },
    ));
    _subheading.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('subheading')
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<SubHeading> retValue = [];
        for (var element in query.docs) {
          retValue.add(SubHeading.fromSnap(element));
        }

        return retValue;
      },
    ));
    update();
  }

  void addOverview(String name, String amount) async {
    try {
      OverView overView = OverView(
        name: name,
        amount: amount,
        uid: name,
      );
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('overview')
          .doc(name)
          .set(overView.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Adding Overview',
        e.toString(),
      );
    }
    update();
  }

  void deleteOverview(uid) async {
    try {
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('overview')
          .doc(uid)
          .delete();
    } catch (e) {
      Get.snackbar(
        'Error Deleting Overview',
        e.toString(),
      );
    }
  }

  void addSubHeading(String title, String subtitle) async {
    try {
      SubHeading subHeading = SubHeading(
        title: title,
        subtitle: subtitle,
        uid: subtitle,
      );
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('subheading')
          .doc(subtitle)
          .set(subHeading.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Adding SubHeading',
        e.toString(),
      );
    }
    update();
  }

  void deleteSubHeading(uid) async {
    try {
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('subheading')
          .doc(uid)
          .delete();
    } catch (e) {
      Get.snackbar(
        'Error Deleting Subheading',
        e.toString(),
      );
    }
  }

  //upload to firebase storage
  Future<String> uploadtoStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('cover')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);

    uploadTask.snapshotEvents.listen((event) async {
      final progress =
          ((event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) *
                  100)
              .roundToDouble();
      _percentage.value = progress;
    });
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void updateCoverPic(
    File? image,
  ) async {
    String downloadUrl = await uploadtoStorage(image!);
    try {
      await firestore.collection('users').doc(authController.user.uid).update({
        'coverphoto': downloadUrl,
      }).then((value) {
        _percentage.value = 0.0;
        Get.back();
      });
    } catch (e) {
      Get.snackbar(
        'Error Updating Cover Picture',
        e.toString(),
      );
    }

    update();
  }

  void updateHeading(String heading) async {
    try {
      await firestore.collection('users').doc(authController.user.uid).update({
        'heading': heading,
      });
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Adding Knowledge',
        e.toString(),
      );
    }
    update();
  }
}
