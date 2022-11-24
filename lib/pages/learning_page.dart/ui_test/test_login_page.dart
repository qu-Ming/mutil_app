import 'package:flutter/material.dart';
import 'package:mutil_app/components/login_textfield_component.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/components/textfield_component.dart';
import 'package:mutil_app/utils/const/app_colors.dart';
import 'package:rive/rive.dart';

class TestLoginPage extends StatefulWidget {
  const TestLoginPage({Key? key}) : super(key: key);

  @override
  State<TestLoginPage> createState() => _TestLoginPageState();
}

class _TestLoginPageState extends State<TestLoginPage> {
  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
        backgroundColor: AppColors.colorBG,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.center,
                    child: TextComponent(text: 'Login')),
                const SizedBox(
                  height: 300,
                  width: 300,
                  child: RiveAnimation.asset(
                    'assets/login/login_teddy.riv',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.colorWhite,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      LoginTextFieldComponent(),
                      SizedBox(
                        height: 12,
                      ),
                      LoginTextFieldComponent(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
