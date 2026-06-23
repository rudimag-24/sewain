import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MessageTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final void Function(String value) sendTap;
  final Color textColor;

  const MessageTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.sendTap,
    this.textColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.send,
      onFieldSubmitted: (value) {
        sendTap(value);
        controller.clear();
      },
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        suffixIconColor: textColor,
        suffixIcon: IconButton(
          onPressed: () {
            sendTap(controller.text);
            controller.clear();
          },
          icon: const Icon(Icons.send),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: textColor),
      ),
    );
  }
}