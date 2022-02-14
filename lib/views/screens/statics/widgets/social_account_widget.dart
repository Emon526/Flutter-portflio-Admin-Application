import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/controller/social_account_controller.dart';
import '../../../../constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialAccountWidget extends StatefulWidget {
  const SocialAccountWidget({Key? key}) : super(key: key);

  @override
  State<SocialAccountWidget> createState() => _SocialAccountWidgetState();
}

class _SocialAccountWidgetState extends State<SocialAccountWidget> {
  Future<void> adddialog({
    required Function() ontap,
    required String title,
    required String namelabeltext,
    required String uidlabeltext,
  }) async {
    // String name;
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
            Column(
              children: [
                IconButton(
                  onPressed: () async {
                    var file = await selectFile();
                    if (file == null) return;

                    // name = basename(file.path);
                    // print(name);
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
            TextField(
              controller: _uidController,
              keyboardType: TextInputType.url,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: uidlabeltext,
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: borderColor,
                  ),
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              keyboardType: TextInputType.url,
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
  final TextEditingController _uidController = TextEditingController();

  final SocialAccountController socialAccountController =
      Get.put(SocialAccountController());
  File? file;

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
                'Social Accounts',
                style: TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                ),
              ),
              GestureDetector(
                child: const Icon(Icons.add),
                onTap: () => adddialog(
                  namelabeltext: 'Line Icon Name',
                  uidlabeltext: 'PlatForm Name',
                  title: 'Add Social Account',
                  ontap: () {
                    socialAccountController.addAccount(
                      _uidController.text.trim(),
                      file,
                      _nameController.text.trim(),
                    );

                    _nameController.clear();
                    _uidController.clear();

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
              itemCount: socialAccountController.socialAccount.length,
              itemBuilder: (context, index) {
                final data = socialAccountController.socialAccount[index];

                return ListTile(
                  leading: SvgPicture.network(
                    data.icon,
                    color: primaryColor,
                    height: 24,
                    placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator()),
                  ),
                  tileColor: secondaryColor,
                  trailing: GestureDetector(
                      onTap: () =>
                          socialAccountController.deleteSocialAccount(data.uid),
                      child: const Icon(Icons.delete_outline_outlined)),
                  //for Account Url
                  // subtitle: Text(data.profileUrl),
                  title: Text(data.uid.toUpperCase()),
                );
              }),
        ],
      );
    });
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['svg'],
    );
    if (result == null) return null;

    Get.snackbar('Selected Icon', result.files.first.name);
    setState(() {
      file = File(result.paths.first!);
    });
    return File(result.paths.first!);
  }
}
