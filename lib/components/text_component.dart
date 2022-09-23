import 'package:flutter/material.dart';

import '../utils/const/app_colors.dart';
import '../utils/const/app_dimens.dart';

class TextComponent extends StatelessWidget {
  const TextComponent(
      {Key? key,
      required this.text,
      this.textSize = AppDimens.text_size_12,
      this.fontWeight = FontWeight.normal,
      this.colorText = AppColors.colorBlack})
      : super(key: key);

  final String text;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? colorText;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: colorText,
          fontSize: textSize,
          fontFamily: 'Poppins',
          fontWeight: fontWeight),
    );
  }
}
