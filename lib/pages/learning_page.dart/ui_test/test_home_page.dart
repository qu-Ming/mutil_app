import 'package:flutter/material.dart';
import 'package:mutil_app/components/chat_avatar_item.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/components/todo_item.dart';
import 'package:mutil_app/pages/learning_page.dart/ui_test/component_avatar.dart';
import 'package:mutil_app/utils/const/app_colors.dart';

class TestHomePage extends StatelessWidget {
  const TestHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ColoredBox(
        color: AppColors.colorBlue,
        child: SizedBox(
          child: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 36, left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      TextComponent(
                        text: 'Chats',
                        colorText: AppColors.colorWhite,
                        textSize: 40.0,
                        fontWeight: FontWeight.w600,
                      ),
                      Icon(
                        Icons.person_add,
                        color: AppColors.colorWhite,
                        size: 40.0,
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 36, 12, 0),
                    height: sizeHeight * 0.8,
                    decoration: const BoxDecoration(
                      color: AppColors.colorWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.colorGrey,
                          ),
                          child: TextFormField(
                            cursorColor: AppColors.colorBlack,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.colorBlack,
                                ),
                                hintText: 'Tìm kiếm',
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              ComponentAvater(
                                networkImage:
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg/200px-Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg',
                              ),
                              ComponentAvater(
                                text: 'NA',
                              ),
                              ComponentAvater(
                                  networkImage:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1LPpymg72HSCIDu9yks4S2ML9z0Rb--ZfqA&usqp=CAU'),
                              ComponentAvater(
                                  networkImage:
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBlh02iLlvRc7qlpW4B2OUmJrCvBfK7PF4Zg&usqp=CAU'),
                              ComponentAvater(
                                networkImage:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGDcyQKzGcS9nOmGCwCgMZEclDdP3uDAkDBw&usqp=CAU',
                              ),
                              ComponentAvater(
                                networkImage:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSbcIlJ8yJS4Cr-rXPpnBUFwbV08BLS-WZvCw&usqp=CAU',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
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
