import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/utils/const/app_colors.dart';

import '../utils/const/app_dimens.dart';

class ListTitleComponent extends StatelessWidget {
  const ListTitleComponent(
      {Key? key, this.iconData, required this.text, this.onTap})
      : super(key: key);

  final IconData? iconData;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            iconData,
            size: AppDimens.iconSize_28,
            color: AppColors.colorGreyText,
          ),
          TextComponent(
            text: text,
            colorText: AppColors.colorBlack,
            textSize: 14,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
