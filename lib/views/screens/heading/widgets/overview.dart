import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/controller/heading_controller.dart';

import '../../../../constants.dart';

class Overview extends StatelessWidget {
  Overview({Key? key}) : super(key: key);
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
              controller: _amountController,
              keyboardType: TextInputType.number,
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

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final HeadingController headingController = Get.put(HeadingController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 20,
                color: primaryColor,
              ),
            ),
            GestureDetector(
                child: const Icon(Icons.add),
                onTap: () => adddialog(
                    ontap: () {
                      headingController.addOverview(_nameController.text.trim(),
                          _amountController.text.trim());
                      _nameController.clear();
                      _amountController.clear();
                    },
                    title: 'Add Overview',
                    namelabeltext: 'Name',
                    amountlabeltext: 'Amount')),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(() {
          return ListView.builder(
              shrinkWrap: true,
              physics:
                  const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              itemCount: headingController.overview.length,
              itemBuilder: (context, index) {
                final data = headingController.overview[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  tileColor: secondaryColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.name,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        data.amount,
                        style: const TextStyle(
                            fontSize: 18,
                            color: primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  trailing: GestureDetector(
                      onTap: () => headingController.deleteOverview(data.uid),
                      child: const Icon(
                        Icons.delete_outline_outlined,
                      )),
                );
              });
        }),
      ],
    );
  }
}
