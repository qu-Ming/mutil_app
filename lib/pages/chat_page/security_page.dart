import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/pages/chat_page/chat_page.dart';
import 'package:mutil_app/utils/const/app_colors.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

TextEditingController security = TextEditingController();

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.colorPink4,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60),
                decoration: BoxDecoration(
                    color: AppColors.colorWhite,
                    borderRadius: BorderRadius.circular(24)),
                child: TextFormField(
                  controller: security,
                  cursorColor: AppColors.colorBlack,
                  decoration: const InputDecoration(
                      hintText: 'Nhập pass',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: AppColors.colorPink,
                      ),
                      border: InputBorder.none),
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.colorPink)),
                  onPressed: () {
                    if (security.text == "m912") {
                      String pass = "minh";
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(
                                    pass: pass,
                                  )));
                    } else if (security.text == "n912") {
                      String pass = "ngan";
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(
                                    pass: pass,
                                  )));
                    }
                  },
                  child: const Text('Xác nhận'))
            ],
          )),
    );
  }
}
