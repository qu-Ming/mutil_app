import 'package:flutter/material.dart';

import '../utils/const/app_colors.dart';
import '../utils/const/app_dimens.dart';

class TextComponent extends StatelessWidget {
  const TextComponent(
      {Key? key,
      required this.text,
      this.textSize = AppDimens.textSize_12,
      this.fontWeight = FontWeight.normal,
      this.colorText = AppColors.colorBlack,
      this.maxLines})
      : super(key: key);

  final String text;
  final double? textSize;
  final FontWeight? fontWeight;
  final Color? colorText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
          color: colorText,
          fontSize: textSize,
          fontFamily: 'Montserrat',
          fontWeight: fontWeight),
    );
  }
}
