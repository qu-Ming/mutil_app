import 'package:flutter/material.dart';

import '../utils/const/app_colors.dart';

class CircleAvatarComponent extends StatelessWidget {
  const CircleAvatarComponent(
      {Key? key, required this.name, required this.urlImage})
      : super(key: key);

  final String name;
  final String urlImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.colorGrey,
          radius: 40,
          backgroundImage: NetworkImage(urlImage),
        ),
        Text(
          name,
          style: const TextStyle(fontFamily: "Poppins"),
        )
      ],
    );
  }
}
