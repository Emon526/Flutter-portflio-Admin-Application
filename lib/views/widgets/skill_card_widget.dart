import 'package:flutter/material.dart';
import 'package:personal_portfolio_admin_app/constants.dart';

class SkillCardWidget extends StatelessWidget {
  final String skillname;
  final String skillid;
  final String skillPercentage;
  final VoidCallback ontap;
  const SkillCardWidget({
    Key? key,
    required this.skillname,
    required this.skillPercentage,
    required this.skillid,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: secondaryColor,
      title: Text(
        skillname,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: LinearProgressIndicator(
              value: double.parse(skillPercentage) / 100,
              color: primaryColor,
              backgroundColor: darkColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            skillPercentage,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
      trailing: GestureDetector(
          onTap: ontap, child: const Icon(Icons.delete_outline_outlined)),
    );
  }
}
