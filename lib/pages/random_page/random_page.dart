import 'package:flutter/material.dart';
import 'package:mutil_app/utils/const/app_colors.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.colorPink,
      body: Center(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            'People in love with the moon learn to live with the distance.',
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
