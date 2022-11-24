import 'package:flutter/material.dart';

import '../utils/const/app_colors.dart';

class LoginTextFieldComponent extends StatelessWidget {
  const LoginTextFieldComponent({Key? key, this.hintText}) : super(key: key);

  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.colorGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
