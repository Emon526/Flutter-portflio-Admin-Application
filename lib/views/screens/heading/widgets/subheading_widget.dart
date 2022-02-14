import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/controller/heading_controller.dart';

import '../../../../constants.dart';

class SubHeadingWidget extends StatelessWidget {
  SubHeadingWidget({Key? key}) : super(key: key);

  Future<void> adddialog(
      {required Function() ontap,
      required String title,
      required String namelabeltext,
      required String amountlabeltext}) async {
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
              controller: _titleController,
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
              controller: _subtitleController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: amountlabeltext,
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

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final HeadingController headingController = Get.put(HeadingController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Sub Heading',
              style: TextStyle(
                fontSize: 20,
                color: primaryColor,
              ),
            ),
            GestureDetector(
                child: const Icon(Icons.add),
                onTap: () => adddialog(
                    ontap: () {
                      headingController.addSubHeading(
                          _titleController.text.trim(),
                          _subtitleController.text.trim());
                      _titleController.clear();
                      _subtitleController.clear();
                    },
                    title: 'Add SubHeading',
                    namelabeltext: 'Title',
                    amountlabeltext: 'Sub Title')),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () {
            return ListView.builder(
                shrinkWrap: true,
                physics:
                    const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                itemCount: headingController.subheading.length,
                itemBuilder: (context, index) {
                  final data = headingController.subheading[index];

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    tileColor: secondaryColor,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        data.title,
                        style:
                            const TextStyle(fontSize: 18, color: primaryColor),
                      ),
                    ),
                    subtitle: Text(
                      data.subtitle,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    trailing: GestureDetector(
                        onTap: () =>
                            headingController.deleteSubHeading(data.uid),
                        child: const Icon(
                          Icons.delete_outline_outlined,
                        )),
                  );
                });
          },
        ),
      ],
    );
  }
}
