import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/constants.dart';
import 'package:personal_portfolio_admin_app/models/knowledge.dart';

class KnowledgeController extends GetxController {
  static KnowledgeController instance = Get.find();
  final Rx<List<Knowledge>> _knowledge = Rx<List<Knowledge>>([]);
  List<Knowledge> get knowledge => _knowledge.value;

  @override
  void onInit() {
    super.onInit();
    _knowledge.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('knowledge')
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<Knowledge> retValue = [];
        for (var element in query.docs) {
          retValue.add(Knowledge.fromSnap(element));
        }

        return retValue;
      },
    ));
    update();
  }

  void addKnowledge(String name) async {
    try {
      Knowledge knowledge = Knowledge(
        knowledgeName: name,
        uid: name,
      );
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('knowledge')
          .doc(name)
          .set(knowledge.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Adding Knowledge',
        e.toString(),
      );
    }
    update();
  }

  void deleteKnowledge(uid) async {
    try {
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('knowledge')
          .doc(uid)
          .delete();
    } catch (e) {
      Get.snackbar(
        'Error Deleting knowledge',
        e.toString(),
      );
    }
  }
}
