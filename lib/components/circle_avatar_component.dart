import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mutil_app/utils/const/app_colors.dart';

class CircleAvatarComponent extends StatelessWidget {
  const CircleAvatarComponent(
      {Key? key, required this.name, required this.assetImage})
      : super(key: key);

  final String name;
  final String assetImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // CircleAvatar(
        //   backgroundColor: AppColors.colorGrey,
        //   radius: 40,
        //   backgroundImage: NetworkImage(assetImage),
        // ),

        Container(
            height: 75,
            width: 75,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(assetImage),
                fit: BoxFit.cover,
              ),
            )),

        Text(
          name,
          style: const TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w600,
            color: AppColors.colorPink,
          ),
        )
      ],
    );
  }
}
