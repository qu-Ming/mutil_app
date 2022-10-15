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
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getEndPage();
  // }

  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection("Chat")
      .orderBy("Time", descending: false)
      .snapshots();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double widthText = 170;
    bool click = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('@${widget.pass}'),
        backgroundColor: AppColors.colorPink,
        actions: [
          IconButton(
              onPressed: getEndPage,
              icon: const Icon(Icons.arrow_downward_rounded)),
        ],
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.878,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: StreamBuilder<QuerySnapshot>(
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

                              return widget.pass == "minh"
                                  ? GestureDetector(
                                      onLongPress: () {
                                        onDelete(chatModel);
                                      },
                                      child: ChatItem(
                                          width:
                                              chatModel.messenger!.length < 35
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
                                      },
                                      child: ChatItem(
                                          width:
                                              chatModel.messenger!.length < 35
                                                  ? null
                                                  : widthText = 170.0,
                                          aligment: doc["User"] == "ngan"
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          textMess: chatModel.messenger!,
                                          texTime:
                                              '${toTime.hour} : ${toTime.minute}'),
                                    );
                            },
                          );
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
                              hintText: 'Nhắn tin...',
                              border: InputBorder.none,
                              prefixIcon: const Icon(
                                Icons.tag_faces,
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  onTapSend();
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
      ),
    );
  }

  onTapSend() async {
    if (_controller.text.isEmpty) {
      print('khong the xoa');
    } else {
      widget.chatModel.messenger = _controller.text;
      widget.chatModel.time = Timestamp.now();
      widget.chatModel.user = widget.pass;
      FirebaseFirestore.instance
          .collection("Chat")
          .add(widget.chatModel.toJson())
          .then((value) {})
          .catchError(
            // ignore: avoid_print, invalid_return_type_for_catch_error
            (onError) => print(onError.toString()),
          );

      _controller.clear();
      getEndPage;
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
            text: 'EM MUỐN THU HỒI?',
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
                      .collection("Chat")
                      .doc(chat.idMess)
                      .delete();
                  Navigator.pop(context);
                },
                child: const TextComponent(
                  text: 'Thu hồi',
                  fontWeight: FontWeight.bold,
                  colorText: AppColors.colorPink,
                  textSize: AppDimens.text_size_14,
                )),
          ],
        ),
      );
    }
  }

  getEndPage() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.easeOut);
  }
}
