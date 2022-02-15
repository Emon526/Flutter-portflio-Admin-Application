import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/controller/project_controller.dart';
import 'package:personal_portfolio_admin_app/controller/recommendation_controller.dart';

import '../../../constants.dart';

class ProjectScreen extends StatelessWidget {
  ProjectScreen({Key? key}) : super(key: key);

  final ProjectController projectController = Get.put(ProjectController());

  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectDescriptionController =
      TextEditingController();
  Future<void> adddialog({
    required Function() ontap,
    required String title,
    required String projectNamelabeltext,
    required String projectDescriptionlabeltext,
  }) async {
    return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 30),
      barrierDismissible: true,
      backgroundColor: darkColor,
      radius: 5,
      title: title,
      actions: [
        InkWell(
          onTap: ontap,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(5)),
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        )
      ],
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _projectNameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: projectNamelabeltext,
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: borderColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _projectDescriptionController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: projectDescriptionlabeltext,
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: borderColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Projects'),
        actions: [
          Center(
            widthFactor: 2.5,
            child: InkWell(
              onTap: () => adddialog(
                ontap: () {
                  projectController.addProject(
                    _projectNameController.text.trim(),
                    _projectDescriptionController.text.trim(),
                  );
                  _projectNameController.clear();
                  _projectDescriptionController.clear();
                },
                title: 'Add project',
                projectNamelabeltext: 'Project Name',
                projectDescriptionlabeltext: 'Project Description',
              ),
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Obx(() {
          return ListView.builder(
            physics:
                const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            shrinkWrap: true,
            itemCount: projectController.projects.length,
            itemBuilder: (context, index) {
              final data = projectController.projects[index];
              return Container(
                  padding: const EdgeInsets.all(10),
                  color: secondaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              data.projectName,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 18,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () =>
                                projectController.deleteProject(data.uid),
                            child: const Icon(Icons.delete_outlined),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.projectDescription,
                        style: const TextStyle(
                          fontSize: 16,
                          color: bodyTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ));
            },
          );
        }),
      ),
    );
  }
}
