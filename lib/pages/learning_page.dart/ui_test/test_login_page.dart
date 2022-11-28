import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mutil_app/components/login_textfield_component.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/utils/const/app_colors.dart';
import 'package:mutil_app/utils/const/app_dimens.dart';
import 'package:rive/rive.dart';

class TestLoginPage extends StatefulWidget {
  const TestLoginPage({Key? key}) : super(key: key);

  @override
  State<TestLoginPage> createState() => _TestLoginPageState();
}

class _TestLoginPageState extends State<TestLoginPage> {
  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  FocusNode passFocusNode = FocusNode();
  TextEditingController passController = TextEditingController();

  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? isSuccess;
  SMIInput<bool>? isFail;

  @override
  void initState() {
    emailFocusNode.addListener((emailFocus));
    passFocusNode.addListener((passFocus));
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener((emailFocus));
    passFocusNode.removeListener((passFocus));
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passFocus() {
    isHandsUp?.change(passFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.colorBG,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 275,
                    width: 275,
                    child: RiveAnimation.asset(
                      'assets/login/login_teddy.riv',
                      fit: BoxFit.fitHeight,
                      stateMachines: const ["Login Machine"],
                      onInit: (artboard) {
                        controller = StateMachineController.fromArtboard(
                          artboard,
                          "Login Machine",
                        );
                        if (controller == null) return;

                        artboard.addController(controller!);
                        isChecking = controller?.findInput("isChecking");
                        numLook = controller?.findInput("numLook");
                        isHandsUp = controller?.findInput("isHandsUp");

                        isSuccess = controller?.findInput("isSuccess");
                        isFail = controller?.findInput("isFail");
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        LoginTextFieldComponent(
                          controller: emailController,
                          focusNode: emailFocusNode,
                          onChange: (value) {
                            numLook?.change(value.length.toDouble());
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        LoginTextFieldComponent(
                          focusNode: passFocusNode,
                          controller: passController,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 24),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.colorDarkBlue,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                              child: TextComponent(
                            text: 'Login',
                            fontWeight: FontWeight.w600,
                            colorText: AppColors.colorWhite,
                            textSize: AppDimens.textSize_18,
                          )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
