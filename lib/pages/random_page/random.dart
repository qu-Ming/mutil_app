import 'dart:math';

import 'package:flutter/material.dart';

import '../../components/text_component.dart';
import '../../components/textfield_component.dart';
import '../../utils/const/app_colors.dart';
import '../../utils/const/app_dimens.dart';

class RandomTab extends StatefulWidget {
  const RandomTab({Key? key}) : super(key: key);

  @override
  State<RandomTab> createState() => _RandomState();
}

String title = 'Random';

class _RandomState extends State<RandomTab> {
  @override
  Widget build(BuildContext context) {
    TextEditingController fNum = TextEditingController();
    TextEditingController lNum = TextEditingController();

    String firstNum = 'Nhập số đầu';
    String lastNum = 'Nhập số cuối';
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100.0,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.colorPink,
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(30))),
                child: Center(
                  child: TextComponent(
                    colorText: AppColors.colorWhite,
                    text: title,
                    textSize: AppDimens.text_size_28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 50.0,
                  right: 50.0,
                ),
                child: TextFieldComponent(
                  textEditingController: fNum,
                  text: firstNum.isEmpty ? 'Lỗi' : firstNum,
                  textInputType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                ),
                child: TextFieldComponent(
                  textEditingController: lNum,
                  text: lastNum,
                  textInputType: TextInputType.number,
                ),
              ),
              GestureDetector(
                onTap: (() {
                  setState(
                    () {
                      if (fNum.text.isEmpty || lNum.text.isEmpty) {
                        title = 'Hông bỏ trống';
                      } else {
                        clickedRandom(
                            int.parse(fNum.text), int.parse(lNum.text));
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                  );
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 20.0),
                  height: 40.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.colorBlue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: TextComponent(
                      textSize: AppDimens.text_size_20,
                      text: 'Xác nhận',
                      colorText: AppColors.colorWhite,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void clickedRandom(int min, int max) {
    if (min < 0 || max < 0) {
      title = 'Không chọn số âm';
    } else if (max - min < 0) {
      title = 'Số đầu bự hơn số cuối';
    } else if (min > 10000 || max > 10000) {
      title = 'Số bự quá';
    } else {
      title = ((min + Random().nextInt((max + 1) - min))).toString();
    }
  }
}
