import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';

import '../utils/const/app_colors.dart';
import '../utils/const/app_dimens.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {Key? key,
      required this.title,
      required this.content,
      required this.dayCreate1,
      required this.dayCreate2,
      required this.checked})
      : super(key: key);

  final String title;
  final String content;
  final String dayCreate1;
  final String dayCreate2;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorPink.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextComponent(
                        text: title,
                        fontWeight: FontWeight.w600,
                        textSize: AppDimens.textSize_16,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextComponent(
                          maxLines: 1,
                          text: content,
                          textSize: AppDimens.textSize_12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Checkbox(
                side: const BorderSide(width: 2.0, color: AppColors.colorPink),
                activeColor: AppColors.colorPinkCheck,
                value: checked,
                onChanged: (bool? neValue) {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextComponent(
                  text: dayCreate1,
                  colorText: AppColors.colorGreyText,
                  textSize: AppDimens.textSize_10,
                  fontWeight: FontWeight.w100,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextComponent(
                  text: dayCreate2,
                  colorText: AppColors.colorGreyText,
                  textSize: AppDimens.textSize_10,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
