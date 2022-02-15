import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:personal_portfolio_admin_app/views/widgets/text_input_widget.dart';
import '../../../constants.dart';

class EditProfile extends StatefulWidget {
  final String name;
  final String description;
  final String residence;
  final String city;
  final String age;
  final String profilePhoto;
  const EditProfile(
      {Key? key,
      required this.name,
      required this.description,
      required this.residence,
      required this.city,
      required this.age,
      required this.profilePhoto})
      : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _residenceController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.profilePhoto,
                  height: size.height * 0.17,
                  width: size.width * 0.32,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: const BoxDecoration(
                  // color: bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextInputField(
                      hintText: widget.name,
                      controller: _nameController,
                      labelText: 'Full Name',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      controller: _descriptionController,
                      labelText: 'Description',
                      hintText: widget.description,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      controller: _residenceController,
                      labelText: 'Residence',
                      hintText: widget.residence,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      controller: _cityController,
                      labelText: 'City',
                      hintText: widget.city,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextInputField(
                      controller: _ageController,
                      labelText: 'Age',
                      hintText: widget.age,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => {
                  authController.updateUser(
                      _nameController.text.isEmpty
                          ? widget.name
                          : _nameController.text,
                      _descriptionController.text.isEmpty
                          ? widget.description
                          : _descriptionController.text,
                      _ageController.text.isEmpty
                          ? widget.age
                          : _ageController.text,
                      _cityController.text.isEmpty
                          ? widget.city
                          : _cityController.text,
                      _residenceController.text.isEmpty
                          ? widget.residence
                          : _residenceController.text),
                  Navigator.pop(context),
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    'Update',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
