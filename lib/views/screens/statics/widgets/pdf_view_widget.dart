import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:personal_portfolio_admin_app/controller/cv_controller.dart';

import '../../../../constants.dart';

class PdfViewWidget extends StatelessWidget {
  final File file;
  final bool uploaded;

  PdfViewWidget({Key? key, required this.file, required this.uploaded})
      : super(key: key);

  final CvController cvController = CvController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final name = basename(file.path);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(name),
      ),
      body: Obx(() {
        return Stack(
          children: [
            Stack(
              children: [
                PDFView(
                  filePath: file.path,
                ),
                uploaded
                    ? Positioned(
                        bottom: size.height * 0.03,
                        left: size.width / 4,
                        child: InkWell(
                          onTap: () {
                            cvController.updateCv(file);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width / 2,
                            height: 50,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                                child: Text(
                              'Upload CV',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                          ),
                        ))
                    : const SizedBox(),
              ],
            ),
            cvController.percentage > 0.1
                ? Positioned(
                    bottom: size.height * 0.12,
                    child: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width,
                      lineHeight: 15.0,
                      percent: cvController.percentage / 100,
                      progressColor: primaryColor,
                      center: Text(cvController.percentage.toString()),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      }),
    );
  }
}
