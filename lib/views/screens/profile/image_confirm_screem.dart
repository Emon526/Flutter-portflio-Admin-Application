import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/controller/photo_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../constants.dart';

class ImageConfirmScreen extends StatelessWidget {
  final File imagefile;
  final String imagePath;
  final VoidCallback ontap;
  ImageConfirmScreen(
      {Key? key,
      required this.imagefile,
      required this.imagePath,
      required this.ontap})
      : super(key: key);

  final PhotoController profileController = Get.put(PhotoController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: darkColor,
          elevation: 0,
          centerTitle: true,
          title: const Text('Upload Picture'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: Image.file(
                  imagefile,
                  fit: BoxFit.fitWidth,
                  filterQuality: FilterQuality.low,
                ),
              ),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width,
                lineHeight: 15.0,
                percent: photocontroller.percentage / 100,
                progressColor: Colors.red,
                center: Text(photocontroller.percentage.toString()),
              ),
              InkWell(
                onTap: ontap,
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
                    'Upload',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
