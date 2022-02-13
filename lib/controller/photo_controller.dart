import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../constants.dart';

class PhotoController extends GetxController {
  static PhotoController instance = Get.find();
  //pick image
  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;

  final Rx<double> _percentage = 0.0.obs;

  double get percentage => _percentage.value;

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture',
          'You have successfully selected your profile picture!');
    }
    _pickedImage = Rx<File?>(
      File(pickedImage!.path),
    );
  }

  //upload to firebase storage
  Future<String> uploadtoStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
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

  void updateProfilePic(
    File? image,
  ) async {
    String downloadUrl = await uploadtoStorage(image!);
    try {
      await firestore.collection('users').doc(authController.user.uid).update({
        'profilePhoto': downloadUrl,
      }).then((value) {
        _percentage.value = 0.0;
        Get.back();
      });
    } catch (e) {
      Get.snackbar(
        'Error Updating Profile Picture',
        e.toString(),
      );
    }

    update();
  }
}
