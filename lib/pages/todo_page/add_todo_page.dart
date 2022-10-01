import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/components/textfield_component.dart';
import 'package:mutil_app/utils/const/app_colors.dart';
import 'package:mutil_app/utils/const/app_dimens.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPinkBG,
      appBar: AppBar(
        backgroundColor: AppColors.colorPink,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
      ),
      body: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: TextComponent(
              text: 'Create a task\nTodo',
              colorText: AppColors.colorPink,
              fontWeight: FontWeight.bold,
              textSize: AppDimens.text_size_20,
            ),
          ),
          TextFieldComponent(
              text: 'Tieu de', textEditingController: titleController),
          TextFieldComponent(
              text: 'Noi dung', textEditingController: titleController),
        ],
      ),
    );
  }
}
