import 'package:flutter/material.dart';
import 'package:mutil_app/components/item_todo.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/pages/todo_page/add_todo_page.dart';
import 'package:mutil_app/utils/const/app_colors.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPagePageState();
}

class _TodoPagePageState extends State<TodoPage> {
  bool nonCheck = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.colorPink,
        onPressed: (() {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddTodoPage()));
        }),
        child: const Icon(
          Icons.add,
          size: 30.0,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.colorPinkBG,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 30, left: 20.0, bottom: 10.0),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: TextComponent(
                          text: 'Những việc sẽ làm\ncùng nhau',
                          fontWeight: FontWeight.bold,
                          textSize: 20.0,
                          colorText: AppColors.colorPink,
                        ),
                      ),
                      Row(
                        children: const [
                          TextComponent(
                            fontWeight: FontWeight.w500,
                            text: 'Danh sách những việc sẽ làm ',
                            textSize: 14.0,
                            colorText: AppColors.colorGreyText,
                          ),
                          Icon(
                            Icons.error_outline,
                            color: AppColors.colorPink,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const ItemTodo(),
              const ItemTodo(),
              const ItemTodo(),
              const ItemTodo(),
              const ItemTodo(),
              const ItemTodo(),
              const ItemTodo(),
            ],
          ),
        ),
      ),
    );
  }
}
