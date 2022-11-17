import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/components/textfield_component.dart';

import '../../utils/const/app_colors.dart';

class TestLoginPage extends StatelessWidget {
  const TestLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    TextEditingController controller1 = TextEditingController();
    return Scaffold(
      body: ColoredBox(
        color: AppColors.colorBlue,
        child: SizedBox(
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 36, left: 12),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextComponent(
                          text: 'Login',
                          colorText: AppColors.colorWhite,
                          textSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12, left: 12),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextComponent(
                          text: 'Welcome to our APP',
                          colorText: AppColors.colorWhite,
                          textSize: 24.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 36, 12, 24),
                    height: sizeHeight * 0.7,
                    decoration: const BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          topRight: Radius.circular(18)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextComponent(
                              text: "Email",
                              textSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFieldComponent(
                            suffixIcon: const Icon(Icons.person),
                            prefixIcon: const Icon(Icons.email),
                            text: 'yourEmail@student.ctuet.edu.vn',
                            textEditingController: controller1,
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Align(
                            alignment: Alignment.topLeft,
                            child: TextComponent(
                              text: "Password",
                              textSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextFieldComponent(
                            suffixIcon: const Icon(Icons.remove_red_eye),
                            prefixIcon: const Icon(Icons.lock),
                            obscureText: true,
                            text: 'Your Password',
                            textInputType: TextInputType.visiblePassword,
                            textEditingController: controller1,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: TextComponent(
                              text: "Forgot Password?",
                              textSize: 12,
                              fontWeight: FontWeight.w500,
                              colorText: AppColors.colorGreyText,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 18.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 130.0),
                            decoration: BoxDecoration(
                                color: AppColors.colorBlue,
                                borderRadius: BorderRadius.circular(12)),
                            child: const TextComponent(
                              text: 'Enter',
                              colorText: AppColors.colorWhite,
                              fontWeight: FontWeight.bold,
                              textSize: 20.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: sizeWidth * 0.35,
                                height: 1,
                                color: AppColors.colorGrey2,
                              ),
                              const TextComponent(
                                text: 'OR',
                                fontWeight: FontWeight.bold,
                                textSize: 18,
                              ),
                              Container(
                                width: sizeWidth * 0.35,
                                height: 1,
                                color: AppColors.colorGrey2,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(
                                  FontAwesomeIcons.google,
                                  color: AppColors.colorLightRed,
                                  size: 36,
                                ),
                                Icon(
                                  FontAwesomeIcons.facebook,
                                  color: AppColors.colorBlue,
                                  size: 36,
                                ),
                                Icon(
                                  FontAwesomeIcons.twitter,
                                  color: AppColors.colorBlue,
                                  size: 36,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              TextComponent(text: 'Don\'t have an account ?'),
                              TextComponent(
                                text: 'Click Here',
                                fontWeight: FontWeight.bold,
                                colorText: AppColors.colorBlue,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
