import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/models/profile.dart' as model;
import 'package:personal_portfolio_admin_app/views/screens/auth/login_screen.dart';
import 'package:personal_portfolio_admin_app/views/screens/home_screen.dart';

import '../constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;

  User get user => _user.value!;

//saving user state
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  //register user
  void registerUser(String username, String email, String password, File? image,
      String description, String age, String city, String residence) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save out user to auth and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String downloadUrl = await photocontroller.uploadtoStorage(image);
        model.Profile user = model.Profile(
          name: username,
          uid: cred.user!.uid,
          profilePhoto: downloadUrl,
          age: age,
          description: description,
          residence: residence,
          city: city,
        );
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar('Error Creating Account ', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar(
        'Error Creating Account ',
        e.toString(),
      );
    }
  }

  void updateUser(String username, String description, String age, String city,
      String residence) async {
    try {
      await firestore.collection('users').doc(authController.user.uid).update({
        'name': username,
        'uid': authController.user.uid,
        'age': age,
        'description': description,
        'residence': residence,
        'city': city,
      }).then((value) => Get.back());
    } catch (e) {
      Get.snackbar(
        'Error Updating Data',
        e.toString(),
      );
    }

    update();
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        // print('login Success');
      } else {
        Get.snackbar('Error Login Account ', 'Please enter all the fields');
      }
    } catch (e) {
      Get.snackbar(
        'Error Login Account ',
        e.toString(),
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
