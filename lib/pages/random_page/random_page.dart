import 'package:flutter/material.dart';

import '../../components/text_component.dart';
import '../../components/textfield_component.dart';
import '../../utils/const/app_colors.dart';
import '../../utils/const/app_dimens.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController fNum = TextEditingController();
    TextEditingController lNum = TextEditingController();

    String title = '0';
    String title2 = '';

    String fNum1 = 'First number';
    String lNum1 = 'Last number';

    return GestureDetector(
      onTap: () {},
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 60, bottom: 60),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.colorGrey,
                    ),
                    child: Column(
                      children: [
                        TextComponent(
                          text: title2.isEmpty ? title : title2,
                          colorText: AppColors.colorBlack,
                          fontWeight: FontWeight.bold,
                          textSize: 50.0,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60.0, vertical: 10.0),
                          child: TextFieldComponent(
                            textEditingController: fNum,
                            text: fNum1,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 60.0),
                          child: TextFieldComponent(
                            textEditingController: lNum,
                            text: lNum1,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          height: 50,
                          width: 200,
                          color: AppColors.colorBlue,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {},
                              child: const TextComponent(
                                text: 'Enter',
                                colorText: AppColors.colorWhite,
                                textSize: AppDimens.text_size_16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
