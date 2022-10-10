import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/model/todo_model.dart';
import 'package:mutil_app/pages/todo_page/add_todo_page.dart';
import 'package:mutil_app/pages/todo_page/detail_page.dart';
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

  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
          child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: AppColors.colorPink,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Center(
                  child: TextComponent(
                text: 'Điều chỉnh ghi chú',
                fontWeight: FontWeight.bold,
                textSize: AppDimens.text_size_22,
                colorText: AppColors.colorWhite,
              )),
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.add,
                    size: AppDimens.icon_size_30,
                    color: AppColors.colorPink,
                  ),
                  TextComponent(
                    text: '  Thêm ghi chú',
                    textSize: 14,
                    colorText: AppColors.colorPink,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
              onTap: (() {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddTodoPage()));
              }),
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(
                    Icons.delete,
                    size: AppDimens.icon_size_30,
                    color: AppColors.colorPink,
                  ),
                  TextComponent(
                    text: '  Xóa ghi chú',
                    textSize: 14,
                    colorText: AppColors.colorPink,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
              onTap: (() {
                setState(() {
                  checked = !checked;
                  Navigator.pop(context);
                });
              }),
            ),
          ],
        ),
      )),
      backgroundColor: AppColors.colorPink4,
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.colorPink,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.colorPink.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 9,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: TextComponent(
                          text: 'Danh sách những việc sẽ làm',
                          fontWeight: FontWeight.bold,
                          textSize: AppDimens.text_size_16,
                          colorText: AppColors.colorWhite,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.colorPinkBG,
                            borderRadius: BorderRadius.circular(12)),
                        child: IconButton(
                            onPressed: (() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AddTodoPage()));
                            }),
                            icon: const Icon(
                              Icons.add,
                              size: AppDimens.icon_size_30,
                              color: AppColors.colorPink,
                            )),
                      ),
                    ],
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
                          TodoModel todoModel = TodoModel.fromJson(documents);
                          todoModel.idTodo =
                              snapshot.data!.docs[index].reference.id;

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPage(todoModel: todoModel)));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                color: AppColors.colorWhite,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12)),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.colorGrey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 9,
                                    offset: const Offset(
                                        0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
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
                                                textSize:
                                                    AppDimens.text_size_16,
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
                                      checked
                                          ? IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (_) => AlertDialog(
                                                    title: const TextComponent(
                                                      text: 'EM MUỐN XÓA?',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      textSize: AppDimens
                                                          .text_size_14,
                                                    ),
                                                    content:
                                                        const TextComponent(
                                                      text: 'Em chắc chưa?',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textSize: AppDimens
                                                          .text_size_14,
                                                      colorText: AppColors
                                                          .colorGreyText,
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Todo")
                                                                .doc(todoModel
                                                                    .idTodo)
                                                                .delete()
                                                                .then(
                                                                  (doc) => print(
                                                                      "Document deleted"),
                                                                  onError: (e) =>
                                                                      print(
                                                                          "Error updating document $e"),
                                                                );
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const TextComponent(
                                                            text: 'Sure',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            colorText: AppColors
                                                                .colorPink,
                                                            textSize: AppDimens
                                                                .text_size_14,
                                                          )),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const TextComponent(
                                                            text: 'Nô',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            colorText: AppColors
                                                                .colorPink,
                                                            textSize: AppDimens
                                                                .text_size_14,
                                                          )),
                                                    ],
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: AppColors.colorPink,
                                              ))
                                          : Checkbox(
                                              side: const BorderSide(
                                                  width: 2.0,
                                                  color: AppColors.colorPink),
                                              activeColor:
                                                  AppColors.colorPinkCheck,
                                              value:
                                                  documents["Check"] ?? false,
                                              onChanged: (bool? newValue) {},
                                            ),
                                      // IconButton(

                                      //   icon: Icon(
                                      //     Icons.chevron_right,
                                      //     size: AppDimens.icon_size_28,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  // Container(
                                  //   height: 1,
                                  //   margin: const EdgeInsets.only(bottom: 5.0),
                                  //   width: double.infinity,
                                  //   color: AppColors.colorGrey2,
                                  // ),
                                  // const Align(
                                  //   alignment: Alignment.centerLeft,
                                  //   child: TextComponent(
                                  //     text: 'Ngày 9 Tháng 12 Năm 2017',
                                  //     colorText: AppColors.colorGreyText,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
