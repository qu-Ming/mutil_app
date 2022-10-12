import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mutil_app/components/list_title_component.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/components/todo_item.dart';
import 'package:mutil_app/model/todo_model.dart';
import 'package:mutil_app/pages/chat_page/security_page.dart';
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
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(
                Icons.sort_rounded,
                size: AppDimens.icon_size_28,
              )),
        ),
        backgroundColor: AppColors.colorPink,
        elevation: 0,
        title: const TextComponent(
          text: 'Danh sách ghi chú',
          fontWeight: FontWeight.w500,
          textSize: AppDimens.text_size_18,
          colorText: AppColors.colorWhite,
        ),
      ),
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.colorPink,
              ),
              child: Center(
                  child: TextComponent(
                text: 'Điều chỉnh ghi chú',
                fontWeight: FontWeight.w600,
                textSize: AppDimens.text_size_18,
                colorText: AppColors.colorWhite,
              )),
            ),
            ListTitleComponent(
              text: "    Thêm ghi chú",
              iconData: Icons.note_add,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddTodoPage()));
              },
            ),
            ListTitleComponent(
              text: "    Thông báo",
              iconData: Icons.notifications,
              onTap: () {},
            ),
            ListTitleComponent(
              text: "    Nhắn tin",
              iconData: Icons.chat,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecurityPage()));
              },
            ),
            Container(
              color: AppColors.colorGrey2,
              height: 1,
            ),
            ListTitleComponent(
              text: "    Cài đặt",
              iconData: Icons.settings,
              onTap: () {},
            )
          ],
        ),
      ),
      backgroundColor: AppColors.colorPink4,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ////////////////////////////
                  Stack(
                    children: [
                      Container(
                        height: 40.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(24),
                              bottomRight: Radius.circular(24),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.colorGrey2.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 9,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                            color: AppColors.colorPink),
                      ),
                      Container(
                        height: 50.0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5.0),
                        margin: const EdgeInsets.fromLTRB(50, 15, 50, 0),
                        decoration: BoxDecoration(
                          color: AppColors.colorPink4,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.colorPink.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 9,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
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
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
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

                            //to model
                            TodoModel todoModel = TodoModel.fromJson(documents);
                            todoModel.idTodo =
                                snapshot.data!.docs[index].reference.id;

                            Timestamp dateCreate = todoModel.dayCreate!;
                            DateTime timeToDate = dateCreate.toDate();

                            String toDate = '';
                            if (timeToDate.weekday == 1) {
                              toDate = 'Thứ hai';
                            } else if (timeToDate.weekday == 2) {
                              toDate = 'Thứ ba';
                            } else if (timeToDate.weekday == 3) {
                              toDate = 'Thứ tư';
                            } else if (timeToDate.weekday == 4) {
                              toDate = 'Thứ năm';
                            } else if (timeToDate.weekday == 5) {
                              toDate = 'Thứ sáu';
                            } else if (timeToDate.weekday == 6) {
                              toDate = 'Thứ bảy';
                            } else if (timeToDate.weekday == 7) {
                              toDate = 'Chủ nhật';
                            }

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailPage(todoModel: todoModel)));
                              },
                              onLongPress: () {
                                {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const TextComponent(
                                        text: 'EM MUỐN XÓA?',
                                        fontWeight: FontWeight.w600,
                                        textSize: AppDimens.text_size_14,
                                      ),
                                      content: const TextComponent(
                                        text: 'Em chắc chưa?',
                                        fontWeight: FontWeight.w500,
                                        textSize: AppDimens.text_size_14,
                                        colorText: AppColors.colorGreyText,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const TextComponent(
                                              text: 'Nô',
                                              fontWeight: FontWeight.bold,
                                              colorText: AppColors.colorPink,
                                              textSize: AppDimens.text_size_14,
                                            )),
                                        TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection("Todo")
                                                  .doc(todoModel.idTodo)
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: const TextComponent(
                                              text: 'Sure',
                                              fontWeight: FontWeight.bold,
                                              colorText: AppColors.colorPink,
                                              textSize: AppDimens.text_size_14,
                                            )),
                                      ],
                                    ),
                                  );
                                }
                              },
                              child: TodoItem(
                                title: documents["Title"],
                                content: documents["Content"],
                                dayCreate1:
                                    "Ngày tạo : $toDate , ngày ${timeToDate.day} tháng ${timeToDate.month} năm ${timeToDate.year}.",
                                dayCreate2:
                                    "${timeToDate.hour}:${timeToDate.minute}:${timeToDate.second}   ",
                                checked: documents["Check"],
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
      ),
    );
  }
}
