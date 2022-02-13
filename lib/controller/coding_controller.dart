import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/constants.dart';
import 'package:personal_portfolio_admin_app/models/skill.dart';

class CoadingController extends GetxController {
  static CoadingController instance = Get.find();
  final Rx<List<Skill>> _coding = Rx<List<Skill>>([]);
  List<Skill> get coding => _coding.value;

  @override
  void onInit() {
    super.onInit();
    _coding.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('coading')
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<Skill> retValue = [];
        for (var element in query.docs) {
          retValue.add(Skill.fromSnap(element));
        }

        return retValue;
      },
    ));
    update();
  }

  void addCoding(String name, String percentage) async {
    try {
      Skill coding = Skill(
        skillName: name,
        skillPercentage: percentage,
        uid: name,
      );
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('coading')
          .doc(name)
          .set(coding.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Adding Skill',
        e.toString(),
      );
    }
    update();
  }

  void deleteSkill(uid) async {
    try {
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('coading')
          .doc(uid)
          .delete();
    } catch (e) {
      Get.snackbar(
        'Error Deleting Skill',
        e.toString(),
      );
    }
  }
}
