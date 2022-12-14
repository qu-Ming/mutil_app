import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';
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

  bool isEdit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPinkBG,
      appBar: AppBar(
        elevation: 1,
        title: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: const Text(
            'Ghi chú',
            style: TextStyle(fontFamily: "Montserrat"),
          ),
        ),
        backgroundColor: AppColors.colorPink,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: AppDimens.iconSize_28,
            )),
        actions: [
          TextButton(
              onPressed: () async {
                Map<String, dynamic> todoUpdate = TodoModel().toJson();
                todoUpdate = {
                  'Title': titleController.text,
                  'Content': contentController.text,
                  'Check': widget.todoModel.check
                };
                FirebaseFirestore.instance
                    .collection('Todo')
                    .doc(widget.todoModel.idTodo)
                    .update(todoUpdate);

                Navigator.pop(context);
              },
              child: const TextComponent(
                text: 'Lưu',
                fontWeight: FontWeight.w500,
                textSize: AppDimens.textSize_16,
                colorText: AppColors.colorWhite,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Flexible(
                      flex: 9,
                      child: TextFormField(
                        enabled: isEdit,
                        controller: titleController,
                        style: const TextStyle(
                            fontSize: AppDimens.textSize_18,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: AppDimens.textSize_18,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Checkbox(
                        side: const BorderSide(
                            width: 2.0, color: AppColors.colorPink),
                        activeColor: AppColors.colorPink,
                        value: widget.todoModel.check,
                        onChanged: (bool? newValue) {
                          setState(() {
                            widget.todoModel.check = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                enabled: isEdit,
                style: const TextStyle(
                  fontSize: AppDimens.textSize_14,
                  fontFamily: 'Montserrat',
                ),
                controller: contentController,
                maxLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: AppDimens.textSize_14,
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
