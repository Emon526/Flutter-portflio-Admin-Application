import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_portfolio_admin_app/controller/recommendation_controller.dart';

import '../../../constants.dart';

class RecommendationScreen extends StatelessWidget {
  RecommendationScreen({Key? key}) : super(key: key);

  final RecommendationController recommendationController =
      Get.put(RecommendationController());

  final TextEditingController _recomonderNameController =
      TextEditingController();
  final TextEditingController _platformNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  Future<void> adddialog(
      {required Function() ontap,
      required String title,
      required String recommendernamelabeltext,
      required String platformnamelabeltext,
      required String reviewlabelText}) async {
    return Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 30),
      barrierDismissible: true,
      backgroundColor: darkColor,
      radius: 5,
      title: title,
      actions: [
        InkWell(
          onTap: ontap,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(5)),
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        )
      ],
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _recomonderNameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: recommendernamelabeltext,
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: borderColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _platformNameController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: platformnamelabeltext,
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: borderColor,
                  ),
                ),
              ),
            ),
            TextField(
              controller: _reviewController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: reviewlabelText,
                focusedBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                    color: borderColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkColor,
        elevation: 0,
        centerTitle: true,
        title: const Text('Recommendations'),
        actions: [
          Center(
            widthFactor: 2.5,
            child: InkWell(
              onTap: () => adddialog(
                  ontap: () {
                    recommendationController.addRecommendation(
                        _recomonderNameController.text.trim(),
                        _platformNameController.text.trim(),
                        _reviewController.text.trim());
                    _recomonderNameController.clear();
                    _platformNameController.clear();
                    _reviewController.clear();
                  },
                  title: 'Add Recommendation',
                  recommendernamelabeltext: 'Recommender Name',
                  platformnamelabeltext: 'Platform Name',
                  reviewlabelText: "Review"),
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Obx(() {
          return ListView.builder(
            physics:
                const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            shrinkWrap: true,
            itemCount: recommendationController.recommendation.length,
            itemBuilder: (context, index) {
              final data = recommendationController.recommendation[index];
              return Container(
                  padding: const EdgeInsets.all(10),
                  color: secondaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.recommendarName.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: primaryColor,
                            ),
                          ),
                          InkWell(
                            onTap: () => recommendationController
                                .deleteRecommendation(data.uid),
                            child: const Icon(Icons.delete_outlined),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        data.platfrom.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: bodyTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        data.review,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          color: bodyTextColor,
                        ),
                      ),
                    ],
                  ));
            },
          );
        }),
      ),
    );
  }
}
