import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/controller/photo_controller.dart';
import 'package:personal_portfolio_admin_app/views/widgets/text_input_widget.dart';

import '../../../constants.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _residenceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  SignUpScreen({Key? key}) : super(key: key);
  final PhotoController profileController = Get.put(PhotoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Register',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(
                        'https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg'),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () => photocontroller.pickImage(),
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInputField(
                    controller: _nameController,
                    labelText: 'Name',
                    hintText: 'Full Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputField(
                    controller: _descriptionController,
                    labelText: 'Description',
                    hintText: 'Description',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputField(
                    controller: _residenceController,
                    labelText: 'Residence',
                    hintText: 'Residence',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputField(
                    controller: _cityController,
                    labelText: 'City',
                    hintText: 'City',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextInputField(
                    controller: _ageController,
                    labelText: 'Age',
                    hintText: 'Age',
                  ),
                  TextInputField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'Email Address',
                  ),
                  TextInputField(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Password',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                height: 50,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: InkWell(
                  onTap: () => authController.registerUser(
                      _nameController.text,
                      _emailController.text,
                      _passwordController.text,
                      photocontroller.profilePhoto,
                      _descriptionController.text,
                      _ageController.text,
                      _cityController.text,
                      _residenceController.text),
                  child: const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen())),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
