import 'package:flutter/material.dart';
import 'package:mutil_app/utils/const/app_colors.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPagePageState();
}

class _TodoPagePageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backGourndColor,
        body: ElevatedButton(onPressed: () {}, child: const Text('data')),
      ),
    );
  }
}
