import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:personal_portfolio_admin_app/controller/cv_controller.dart';
import 'package:personal_portfolio_admin_app/views/screens/statics/widgets/pdf_view_widget.dart';

import '../../../../constants.dart';

class CvWidget extends StatefulWidget {
  const CvWidget({Key? key}) : super(key: key);

  @override
  State<CvWidget> createState() => _CvWidgetState();
}

class _CvWidgetState extends State<CvWidget> {
  final CvController cvController = CvController();

  File? file;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            const url = 'CV';
            final file = await cvController.loadFirebase(url);

            openPDF(context, file, false);
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(5)),
            child: const Center(
                child: Text(
              'View CV',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () async {
            final file = await selectFile();
            if (file == null) return;
            openPDF(context, file, true);
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(5)),
            child: const Center(
                child: Text(
              'Change CV',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            )),
          ),
        ),
      ],
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return null;

    return File(result.paths.first!);
  }

  void openPDF(BuildContext context, File file, bool uploaded) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PdfViewWidget(
                file: file,
                uploaded: uploaded,
              )));
}
