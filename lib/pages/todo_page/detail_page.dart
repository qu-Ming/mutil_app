import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mutil_app/model/todo_model.dart';
import 'package:mutil_app/utils/const/app_colors.dart';
import 'package:mutil_app/utils/const/app_dimens.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.todoModel}) : super(key: key);

  TodoModel todoModel = TodoModel();

  @override
  State<DetailPage> createState() => _DetailPage();
}

class _DetailPage extends State<DetailPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPinkBG,
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Ghi chú',
          style: TextStyle(fontFamily: "Montserrat"),
        ),
        backgroundColor: AppColors.colorPink,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: AppDimens.icon_size_28,
            )),
        actions: [
          IconButton(
              onPressed: () async {
                TodoModel todo = TodoModel();
                todo.title = titleController.text;
                todo.content = titleController.text;
                final doc = FirebaseFirestore.instance
                    .collection('Todo')
                    .doc('2Lvx16wtp9W1L4UQ18UO');

                doc.update({'Check': true, 'Title': 'Yolo', 'Content': 'Duoc'});
              },
              icon: const Icon(
                Icons.update,
                size: AppDimens.icon_size_28,
              )),

          // IconButton(
          //   onPressed: () async {
          //     TodoModel todo = TodoModel();
          //     todo.title = titleController.text;
          //     todo.content = contentController.text;
          //     todo.dayCreate = Timestamp.now();
          //     FirebaseFirestore.instance
          //         .collection("Todo")
          //         .add(todo.toJson())
          //         .then((value) {})
          //         .catchError(
          //           // ignore: avoid_print, invalid_return_type_for_catch_error
          //           (onError) => print(onError.toString()),
          //         );
          //     Navigator.pop(context);
          //   },
          //   icon: const Icon(Icons.check),
          // ),
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
                  enabled: false,
                  controller: titleController,
                  style: const TextStyle(
                      fontSize: AppDimens.text_size_18,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                        fontSize: AppDimens.text_size_18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              TextFormField(
                enabled: false,
                style: const TextStyle(
                  fontSize: AppDimens.text_size_14,
                  fontFamily: 'Montserrat',
                ),
                controller: contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
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

  startPage() {
    titleController.text = widget.todoModel.title!;
    contentController.text = widget.todoModel.content!;
  }
}
