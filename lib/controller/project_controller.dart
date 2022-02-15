import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/constants.dart';
import 'package:personal_portfolio_admin_app/models/project.dart';

class ProjectController extends GetxController {
  static ProjectController instance = Get.find();
  final Rx<List<Project>> _projects = Rx<List<Project>>([]);
  List<Project> get projects => _projects.value;

  @override
  void onInit() {
    super.onInit();
    _projects.bindStream(firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('projects')
        .snapshots()
        .map(
      (QuerySnapshot query) {
        List<Project> retValue = [];
        for (var element in query.docs) {
          retValue.add(Project.fromSnap(element));
        }

        return retValue;
      },
    ));
    update();
  }

  void addProject(String projectName, String projectDescription) async {
    try {
      Project project = Project(
        projectName: projectName,
        projectDescription: projectDescription,
        uid: projectName,
      );
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('projects')
          .doc(projectName)
          .set(project.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error Adding projects',
        e.toString(),
      );
    }
    update();
  }

  void deleteProject(uid) async {
    try {
      await firestore
          .collection('users')
          .doc(authController.user.uid)
          .collection('projects')
          .doc(uid)
          .delete();
    } catch (e) {
      Get.snackbar(
        'Error Deleting projects',
        e.toString(),
      );
    }
  }
}
