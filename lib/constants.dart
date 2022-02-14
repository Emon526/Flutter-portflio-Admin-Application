import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:personal_portfolio_admin_app/controller/auth_controller.dart';
import 'package:personal_portfolio_admin_app/controller/photo_controller.dart';
import 'package:personal_portfolio_admin_app/controller/profile_controller.dart';
import 'package:personal_portfolio_admin_app/controller/skill_controller.dart';
import 'package:personal_portfolio_admin_app/views/screens/heading/heading.dart';
import 'package:personal_portfolio_admin_app/views/screens/website_screen.dart';
import 'package:personal_portfolio_admin_app/views/screens/statics/statics_screen.dart';

import 'views/screens/profile/profile_screen.dart';

List pages = [
  const WebsiteView(),
  const Text('Recomond Screen'),
  Heading(),
  const StaticsScreen(),
  const Text('Project Screen'),
  ProfileScreen(
    uid: authController.user.uid,
  ),
];

const primaryColor = Color(0xFFFFC107);
const secondaryColor = Color(0xFF242430);
const darkColor = Color(0xFF191923);
const bodyTextColor = Color(0xFF8B8B8D);
const bgColor = Color(0xFF1E1E28);
const borderColor = Colors.grey;

const defaultPadding = 20.0;
const defaultDuration = Duration(seconds: 1); // we use it on our animation
const maxWidth = 1440.0; // max width of our web

//nav bar color
const navbarbg = Color(0xFFFFC107);
const navbariconbg = Color(0xffffffff);
const selectednavbar = Color(0xFF191923);
const curveColor = Color(0xFF191923);

//Firebase

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//controller
var authController = AuthController.instance;
var profilecontroller = ProfileController.instance;
var skillcontroller = SkillController.instance;
var photocontroller = PhotoController.instance;
