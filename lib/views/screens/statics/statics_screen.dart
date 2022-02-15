import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/controller/photo_controller.dart';
import 'package:personal_portfolio_admin_app/views/screens/statics/widgets/coding_widget.dart';
import 'package:personal_portfolio_admin_app/views/screens/statics/widgets/cv_widget.dart';
import 'package:personal_portfolio_admin_app/views/screens/statics/widgets/social_account_widget.dart';
import '../../../constants.dart';
import 'widgets/knowledge_widget.dart';
import 'widgets/skill_widget.dart';

class StaticsScreen extends StatefulWidget {
  const StaticsScreen({Key? key}) : super(key: key);

  @override
  State<StaticsScreen> createState() => _StaticsScreenState();
}

final PhotoController profileController = Get.put(PhotoController());

class _StaticsScreenState extends State<StaticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkColor,
          elevation: 0,
          centerTitle: true,
          title: const Text('Statics'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            children: [
              SkillWidget(),
              const SizedBox(
                height: 40,
              ),
              CodingWidget(),

              const SizedBox(
                height: 40,
              ),
              KnowledgeWidget(),
              const SizedBox(
                height: 40,
              ),
              const SocialAccountWidget(),
              const SizedBox(
                height: 30,
              ),
              CvWidget(),
              // const SizedBox(
              //   height: 30,
              // )
            ],
          ),
        ));
  }
}
