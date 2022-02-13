import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import '../constants.dart';
import 'package:path_provider/path_provider.dart';

class CvController extends GetxController {
  static CvController instance = Get.find();

  final Rx<double> _percentage = 0.0.obs;

  double get percentage => _percentage.value;

  //upload to firebase storage
  Future<String> uploadtoStorage(File cv) async {
    Reference ref =
        firebaseStorage.ref().child('cv').child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(cv);

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

  void updateCv(
    File? cv,
  ) async {
    String downloadUrl = await uploadtoStorage(cv!);
    try {
      await firestore.collection('users').doc(authController.user.uid).update({
        'cv': downloadUrl,
      }).then((value) {
        _percentage.value = 0.0;
        Get.back();
      });
    } catch (e) {
      Get.snackbar(
        'Error Updating CV',
        e.toString(),
      );
    }

    update();
  }

  Future<File> loadFirebase(String url) async {
    // final refPDF = firebaseStorage.ref().child(url);
    final refPDF =
        firebaseStorage.ref().child('cv').child(firebaseAuth.currentUser!.uid);

    final bytes = await refPDF.getData();
    return _storeFile(url, bytes!);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
