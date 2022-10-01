import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';

import '../utils/const/app_colors.dart';

class ItemTodo extends StatefulWidget {
  const ItemTodo({Key? key}) : super(key: key);

  @override
  State<ItemTodo> createState() => _ItemTodoState();
}

class _ItemTodoState extends State<ItemTodo> {
  bool nonCheck = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: const [
                    Align(
                      alignment: Alignment.topLeft,
                      child: TextComponent(
                        text: 'Tiêu đề',
                        textSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextComponent(
                        text:
                            'Nội dung: This upload has been generated using the putString method! Check the metadata too!',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 30.0,
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.colorGreyBG,
                borderRadius: BorderRadius.circular(30)),
            height: 30.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextComponent(
                    text: '17 tháng 12 năm 2022',
                    colorText: AppColors.colorGreyText,
                  ),
                ),
                Checkbox(
                  side:
                      const BorderSide(width: 1.0, color: AppColors.colorPink),
                  activeColor: AppColors.colorPinkCheck,
                  value: nonCheck,
                  onChanged: (bool? newValue) {
                    setState(
                      () {
                        nonCheck = newValue!;
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
