// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mutil_app/components/chat_item.dart';
import 'package:mutil_app/model/chat_model.dart';
import 'package:mutil_app/utils/const/app_colors.dart';
import 'package:mutil_app/utils/const/my_behavior.dart';

import '../../components/text_component.dart';
import '../../utils/const/app_dimens.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key, required this.pass}) : super(key: key);

  final String pass;

  final ChatModel chatModel = ChatModel();

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection("Chat")
      .orderBy("Time", descending: false)
      .snapshots();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool scrollToEnd = false;

  @override
  Widget build(BuildContext context) {
    double widthText = 250;
    return Scaffold(
      appBar: AppBar(
        title: Text('@${widget.pass}'),
        backgroundColor: AppColors.colorPink,
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.878,
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            controller: _scrollController,
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> doc =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;

                              ChatModel chatModel = ChatModel.fromJson(doc);
                              chatModel.idMess =
                                  snapshot.data!.docs[index].reference.id;
                              Timestamp time = chatModel.time!;
                              DateTime toTime = time.toDate();

                              FirebaseFirestore.instance
                                  .collection("Chat")
                                  .snapshots()
                                  .listen((event) {
                                if (event.docs.length >
                                    snapshot.data!.docs.length) {
                                  getEndPage();
                                }
                              });

                              return widget.pass == "minh"
                                  ? GestureDetector(
                                      onLongPress: () {
                                        onDelete(chatModel);
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      child: ChatItem(
                                          width:
                                              chatModel.messenger!.length < 30
                                                  ? null
                                                  : widthText,
                                          aligment: chatModel.user == "minh"
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          textMess: chatModel.messenger!,
                                          texTime:
                                              '${toTime.hour} : ${toTime.minute}'),
                                    )
                                  : GestureDetector(
                                      onLongPress: () {
                                        onDelete(chatModel);
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      child: ChatItem(
                                          width:
                                              chatModel.messenger!.length < 30
                                                  ? null
                                                  : widthText,
                                          aligment: doc["User"] == "ngan"
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          textMess: chatModel.messenger!,
                                          texTime:
                                              '${toTime.hour} : ${toTime.minute}'),
                                    );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      color: AppColors.colorWhite,
                      child: Center(
                        child: TextFormField(
                          controller: _controller,
                          decoration: InputDecoration(
                            prefixIconColor: AppColors.colorWhite,
                            hintText: 'Nh???n tin...',
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Icons.tag_faces,
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  onTapSend();
                                });
                              },
                              child: const Icon(
                                Icons.send,
                              ),
                            ),
                          ),
                          cursorColor: AppColors.colorBlack,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom) *
                          0.01)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapSend() async {
    if (_controller.text.isEmpty) {
      print('khong the gui');
    } else {
      widget.chatModel.messenger = _controller.text;
      widget.chatModel.time = Timestamp.now();
      widget.chatModel.user = widget.pass;
      FirebaseFirestore.instance
          .collection("Chat")
          .add(widget.chatModel.toJson())
          .then((value) {})
          .catchError(
            (onError) => print(onError.toString()),
          );

      _controller.clear();
      getEndPage();
    }
  }

  onDelete(ChatModel chat) async {
    if (chat.user != widget.pass) {
      print('khong the xoa');
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const TextComponent(
            text: 'EM MU???N THU H???I?',
            fontWeight: FontWeight.w600,
            textSize: AppDimens.textSize_14,
          ),
          content: const TextComponent(
            text: 'Em ch???c ch??a?',
            fontWeight: FontWeight.w500,
            textSize: AppDimens.textSize_14,
            colorText: AppColors.colorGreyText,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const TextComponent(
                  text: 'N??',
                  fontWeight: FontWeight.bold,
                  colorText: AppColors.colorPink,
                  textSize: AppDimens.textSize_14,
                )),
            TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("Chat")
                      .doc(chat.idMess)
                      .delete();
                  Navigator.pop(context);
                },
                child: const TextComponent(
                  text: 'Thu h???i',
                  fontWeight: FontWeight.bold,
                  colorText: AppColors.colorPink,
                  textSize: AppDimens.textSize_14,
                )),
          ],
        ),
      );
    }
  }

  getEndPage() {
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 150.0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.ease);
  }
}
