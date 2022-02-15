import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_portfolio_admin_app/controller/heading_controller.dart';
import 'package:personal_portfolio_admin_app/controller/profile_controller.dart';
import 'package:personal_portfolio_admin_app/views/screens/heading/widgets/overview.dart';
import 'package:personal_portfolio_admin_app/views/screens/heading/widgets/subheading_widget.dart';
import 'package:personal_portfolio_admin_app/views/screens/profile/image_confirm_screem.dart';

import '../../../constants.dart';

class Heading extends StatelessWidget {
  Heading({Key? key}) : super(key: key);
  Future<void> adddialog({
    required Function() ontap,
    required String title,
    required String namelabeltext,
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
              controller: _nameController,
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

  final HeadingController headingController = HeadingController();
  final ProfileController profileController = Get.put(ProfileController());
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    pickImage() async {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );
      if (image != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ImageConfirmScreen(
              imagefile: File(image.path),
              imagePath: image.path,
              ontap: () {
                headingController.updateCoverPic(File(image.path));
              },
            ),
          ),
        );
      }
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Heading'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Obx(() {
                        return CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: profilecontroller.user['coverphoto'],
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        );
                      }),
                    ),
                    Center(
                        child: Text(
                      profilecontroller.user['heading'],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ))
                  ],
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  child: IconButton(
                    onPressed: () => pickImage(),
                    icon: const Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => adddialog(
                namelabeltext: 'Heading',
                title: 'Change Heading',
                ontap: () {
                  headingController.updateHeading(_nameController.text.trim());
                  _nameController.clear();

                  Get.back();
                },
              ),
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: size.width / 2,
                  height: 35,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Center(
                      child: Text(
                    'Update Heading',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Overview(),
            const SizedBox(
              height: 20,
            ),
            SubHeadingWidget(),
          ],
        ),
      ),
    );
  }
}
