import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/utils/const/app_colors.dart';

class ComponentAvater extends StatelessWidget {
  final String? networkImage;
  final Color? color;
  final String? text;
  final double? radius;
  const ComponentAvater(
      {Key? key,
      this.networkImage = '',
      this.color = AppColors.colorBlue,
      this.text = '',
      this.radius = 25})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: color,
        radius: radius,
        backgroundImage: NetworkImage(
          networkImage!,
        ),
        child: TextComponent(
          text: text!,
          colorText: AppColors.colorWhite,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
