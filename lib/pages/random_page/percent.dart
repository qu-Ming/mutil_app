import 'package:flutter/material.dart';

import '../../components/text_component.dart';
import '../../components/textfield_component.dart';
import '../../utils/const/app_colors.dart';
import '../../utils/const/app_dimens.dart';

class PercentTab extends StatefulWidget {
  const PercentTab({Key? key}) : super(key: key);

  @override
  State<PercentTab> createState() => _PercentTabState();
}

String title = 'Tính phần trăm';

class _PercentTabState extends State<PercentTab> {
  @override
  Widget build(BuildContext context) {
    TextEditingController fNum = TextEditingController();
    TextEditingController lNum = TextEditingController();

    String firstNum = 'Nhập số';
    String lastNum = 'Nhập số phần trăm';
    return Scaffold(
      backgroundColor: AppColors.colorPink4,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 150.0,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.appBarColor,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(12))),
                child: Center(
                  child: TextComponent(
                    colorText: AppColors.colorWhite,
                    text: title,
                    textSize: AppDimens.textSize_28,
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
                        clickedPercent(
                            double.parse(fNum.text), double.parse(lNum.text));
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
                    color: AppColors.appBarColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: TextComponent(
                      textSize: AppDimens.textSize_20,
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

  void clickedPercent(double number, double percent) {
    if (number < 0 || percent < 0) {
      title = 'Không chọn số âm';
    } else if (percent > 100) {
      title = '% hông vượt quá 100';
    } else {
      title = (number - ((number * percent) / 100)).toString();
    }
  }
}
