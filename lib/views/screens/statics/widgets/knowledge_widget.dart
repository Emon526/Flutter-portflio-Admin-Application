import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/controller/knowledge_controller.dart';

import '../../../../constants.dart';

class KnowledgeWidget extends StatelessWidget {
  KnowledgeWidget({Key? key}) : super(key: key);
  Future<void> adddialog(
      {required Function() ontap,
      required String title,
      required String namelabeltext,
      required String percentagelabeltext}) async {
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
              controller: _nameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: namelabeltext,
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

  final TextEditingController _nameController = TextEditingController();

  final KnowledgeController knowledgeController =
      Get.put(KnowledgeController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Knowledge',
                style: TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                child: const Icon(Icons.add),
                onTap: () => adddialog(
                  namelabeltext: 'Knowledge Name',
                  percentagelabeltext: 'knowledge Percentage',
                  title: 'Add knowledge',
                  ontap: () {
                    knowledgeController
                        .addKnowledge(_nameController.text.trim());
                    _nameController.clear();

                    Get.back();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics:
                  const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              itemCount: knowledgeController.knowledge.length,
              itemBuilder: (context, index) {
                final data = knowledgeController.knowledge[index];
                return ListTile(
                  leading: const Icon(
                    Icons.check,
                    size: 24,
                    color: primaryColor,
                  ),
                  tileColor: secondaryColor,
                  trailing: GestureDetector(
                      onTap: () =>
                          knowledgeController.deleteKnowledge(data.uid),
                      child: const Icon(Icons.delete_outline_outlined)),
                  title: Text(data.knowledgeName),
                );
              }),
        ],
      );
    });
  }
}
