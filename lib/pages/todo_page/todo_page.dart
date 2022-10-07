import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/pages/todo_page/add_todo_page.dart';
import 'package:mutil_app/utils/const/app_colors.dart';
import 'package:mutil_app/utils/const/my_behavior.dart';

import '../../utils/const/app_dimens.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPagePageState();
}

class _TodoPagePageState extends State<TodoPage> {
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
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
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: AppColors.colorPinkBG,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30, left: 20.0, bottom: 10.0),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: TextComponent(
                            text: 'Ghi chú những việc sẽ làm\ncùng nhau',
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
                StreamBuilder<QuerySnapshot>(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.colorPink,
                          ),
                        );
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> documents =
                              snapshot.data!.docs[index].data()
                                  as Map<String, dynamic>;

                          //item

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: TextComponent(
                                              text: documents["Title"],
                                              fontWeight: FontWeight.w600,
                                              textSize: AppDimens.text_size_16,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0),
                                              child: TextComponent(
                                                maxLines: 1,
                                                text: documents["Content"],
                                                textSize:
                                                    AppDimens.text_size_12,
                                              ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        flex: 9,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: TextComponent(
                                            text: 'Ngày 9 Tháng 12 Năm 2017',
                                            colorText: AppColors.colorGreyText,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Checkbox(
                                          side: const BorderSide(
                                              width: 1.0,
                                              color: AppColors.colorPink),
                                          activeColor: AppColors.colorPinkCheck,
                                          value: documents["Check"] ?? false,
                                          onChanged: (bool? newValue) {},
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
