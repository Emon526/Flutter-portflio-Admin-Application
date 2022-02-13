import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/controller/coding_controller.dart';
import 'package:personal_portfolio_admin_app/views/widgets/skill_card_widget.dart';

import '../../../../constants.dart';

class CodingWidget extends StatelessWidget {
  CodingWidget({Key? key}) : super(key: key);
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
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _percentageController,
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: percentagelabeltext,
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
  final TextEditingController _percentageController = TextEditingController();
  final CoadingController coadingController = Get.put(CoadingController());

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
                'Coding',
                style: TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                child: const Icon(Icons.add),
                onTap: () => adddialog(
                  namelabeltext: 'Coading Name',
                  percentagelabeltext: 'Coading Percentage',
                  title: 'Add Coading',
                  ontap: () {
                    coadingController.addCoding(_nameController.text.trim(),
                        _percentageController.text.trim());
                    _nameController.clear();
                    _percentageController.clear();
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
              itemCount: coadingController.coding.length,
              itemBuilder: (context, index) {
                final data = coadingController.coding[index];
                return SkillCardWidget(
                  ontap: () => coadingController.deleteSkill(data.uid),
                  skillname: data.skillName,
                  skillPercentage: data.skillPercentage,
                  skillid: data.uid,
                );
              }),
        ],
      );
    });
  }
}
