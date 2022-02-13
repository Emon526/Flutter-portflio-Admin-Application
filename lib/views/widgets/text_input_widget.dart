import 'package:flutter/material.dart';

import '../../constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;

  final String labelText;
  final String hintText;
  final bool isObscure;
  final TextInputType? keyboardtype;

  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.isObscure = false,
    this.keyboardtype,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardtype,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        // labelText: labelText,
        label: Text(labelText),

        // prefixIcon: Icon(iconData),
        labelStyle: const TextStyle(fontSize: 18, color: borderColor),

        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
