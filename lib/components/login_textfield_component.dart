import 'package:flutter/material.dart';

import '../utils/const/app_colors.dart';

class LoginTextFieldComponent extends StatelessWidget {
  const LoginTextFieldComponent(
      {Key? key,
      this.hintText,
      required this.controller,
      this.focusNode,
      this.onChange,
      this.obscureText = false})
      : super(key: key);

  final String? hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function(String)? onChange;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.colorGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        obscureText: obscureText!,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChange,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
