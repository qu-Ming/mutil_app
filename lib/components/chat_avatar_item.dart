import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/pages/learning_page.dart/ui_test/component_avatar.dart';
import 'package:mutil_app/utils/const/app_colors.dart';

import '../utils/const/app_dimens.dart';

class ChatAvatarItem extends StatelessWidget {
  final String name;
  final String day;
  final String? avatar;

  const ChatAvatarItem({
    Key? key,
    this.avatar = '',
    required this.day,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ComponentAvater(
              networkImage: avatar,
              radius: 30.0,
            ),
            Flexible(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextComponent(
                          text: name,
                          fontWeight: FontWeight.w600,
                          textSize: AppDimens.textSize_16,
                        ),
                      ),
                      TextComponent(
                        text: day,
                        colorText: AppColors.colorGreyText,
                        textSize: AppDimens.textSize_10,
                        fontWeight: FontWeight.w100,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
