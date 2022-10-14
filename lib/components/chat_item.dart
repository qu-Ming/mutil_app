import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';

import '../utils/const/app_colors.dart';
import '../utils/const/app_dimens.dart';

class ChatItem extends StatelessWidget {
  const ChatItem(
      {Key? key,
      required this.aligment,
      required this.textMess,
      required this.texTime,
      this.width})
      : super(key: key);

  final AlignmentGeometry aligment;
  final String textMess;
  final String texTime;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: aligment,
      child: Container(
          width: width,
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: AppColors.colorPink4,
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textMess,
                style: const TextStyle(fontSize: AppDimens.text_size_16),
              ),
              TextComponent(
                text: texTime,
                textSize: AppDimens.text_size_10,
                colorText: AppColors.colorGreyText,
              )
            ],
          )),
    );
  }
}
