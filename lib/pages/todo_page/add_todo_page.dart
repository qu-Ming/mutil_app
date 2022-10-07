import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mutil_app/utils/const/app_colors.dart';
import 'package:mutil_app/utils/const/app_dimens.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPinkBG,
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Tạo ghi chú',
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        backgroundColor: AppColors.colorPink,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
        actions: [
          IconButton(
            onPressed: () async {
              FirebaseFirestore.instance
                  .collection("Todo")
                  .add({
                    "Content": contentController.text,
                    "Title": titleController.text,
                    "Check": false,
                    "Time": DateTime.now(),
                  })
                  .then((value) {})
                  .catchError(
                    // ignore: avoid_print, invalid_return_type_for_catch_error
                    (onError) => print(onError.toString()),
                  );
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  controller: titleController,
                  style: const TextStyle(
                      fontSize: AppDimens.text_size_18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập tiêu đề',
                    hintStyle: TextStyle(
                        fontSize: AppDimens.text_size_18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              TextFormField(
                style: const TextStyle(
                  fontSize: AppDimens.text_size_14,
                  fontFamily: 'Montserrat',
                ),
                controller: contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Nội dung',
                  hintStyle: TextStyle(
                    fontSize: AppDimens.text_size_14,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
