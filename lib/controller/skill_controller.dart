import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/constants.dart';
import 'package:personal_portfolio_admin_app/models/skill.dart';

class SkillController extends GetxController {
  static SkillController instance = Get.find();
  final Rx<List<Skill>> _skills = Rx<List<Skill>>([]);
  List<Skill> get skills => _skills.value;

  @override
  void onInit() {
    super.onInit();
    _skills.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('skills')
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

  void addSkill(String name, String percentage) async {
    try {
      Skill skill = Skill(
        skillName: name,
        skillPercentage: percentage,
        uid: name,
      );
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('skills')
          .doc(name)
          .set(skill.toJson());
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
          .collection('skills')
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
