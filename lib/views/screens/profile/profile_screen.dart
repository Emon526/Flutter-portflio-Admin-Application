import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_portfolio_admin_app/controller/profile_controller.dart';
import 'package:personal_portfolio_admin_app/views/widgets/custm_card_widget.dart';
import '../../../constants.dart';
import 'image_confirm_screem.dart';
import 'profile_edit.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

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
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
              appBar: AppBar(
                backgroundColor: darkColor,
                elevation: 0,
                centerTitle: true,
                title: const Text('Profile'),
                leading: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(
                          name: controller.user['name'],
                          profilePhoto: controller.user['profilePhoto'],
                          city: controller.user['city'],
                          age: controller.user['age'],
                          description: controller.user['description'],
                          residence: controller.user['residence'],
                        ),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: () => authController.signOut(),
                    child: const Center(
                      widthFactor: 1.5,
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: controller.user['profilePhoto'],
                            height: 150,
                            width: 150,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          left: 90,
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
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomCard(
                                title: 'Name',
                                subtitle: controller.user['name'],
                              ),
                              CustomCard(
                                title: 'Description',
                                subtitle: controller.user['description'],
                              ),
                              CustomCard(
                                title: 'Residence',
                                subtitle: controller.user['residence'],
                              ),
                              CustomCard(
                                title: 'City',
                                subtitle: controller.user['city'],
                              ),
                              CustomCard(
                                title: 'Age',
                                subtitle: controller.user['age'],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}
