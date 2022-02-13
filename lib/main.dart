import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/constants.dart';
import 'package:personal_portfolio_admin_app/views/screens/auth/login_screen.dart';

import 'controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Portfolio Admin",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkColor,
      ),
      home: LoginScreen(),
    );
  }
}
