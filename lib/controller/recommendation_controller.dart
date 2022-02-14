import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/constants.dart';
import 'package:personal_portfolio_admin_app/models/recommendation.dart';

class RecommendationController extends GetxController {
  static RecommendationController instance = Get.find();
  final Rx<List<Recommendation>> _recommendation = Rx<List<Recommendation>>([]);
  List<Recommendation> get recommendation => _recommendation.value;

  @override
  void onInit() {
    super.onInit();
    _recommendation.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('recommendation')
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<Recommendation> retValue = [];
        for (var element in query.docs) {
          retValue.add(Recommendation.fromSnap(element));
        }

        return retValue;
      },
    ));
    update();
  }

  void addRecommendation(
      String recommendarName, String platfrom, String review) async {
    try {
      Recommendation recommendation = Recommendation(
        recommendarName: recommendarName,
        platfrom: platfrom,
        review: review,
        uid: recommendarName,
      );
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('recommendation')
          .doc(recommendarName)
          .set(recommendation.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Adding Recommendation',
        e.toString(),
      );
    }
    update();
  }

  void deleteRecommendation(uid) async {
    try {
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('recommendation')
          .doc(uid)
          .delete();
    } catch (e) {
      Get.snackbar(
        'Error Deleting Recommendation',
        e.toString(),
      );
    }
  }
}
