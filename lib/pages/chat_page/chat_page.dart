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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('@${widget.pass}'),
        backgroundColor: AppColors.colorPink,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60.0,
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
                  setState(() {
                    onTapSend();
                    _controller.text = '';
                    FocusManager.instance.primaryFocus?.unfocus();
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
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Column(
                children: [
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
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> doc = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;

                          ChatModel chatModel = ChatModel.fromJson(doc);
                          widget.chatModel.idMess =
                              snapshot.data!.docs[index].reference.id;
                          Timestamp time = chatModel.time!;
                          DateTime toTime = time.toDate();

                          return widget.pass == "minh"
                              ? GestureDetector(
                                  onLongPress: () {
                                    onDelete();
                                  },
                                  child: ChatItem(
                                      aligment: chatModel.user == "minh"
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      textMess: chatModel.messenger!,
                                      texTime:
                                          '${toTime.hour} giờ ${toTime.second}'),
                                )
                              : GestureDetector(
                                  onLongPress: () {
                                    onDelete();
                                  },
                                  child: ChatItem(
                                      aligment: doc["User"] == "ngan"
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      textMess: chatModel.messenger!,
                                      texTime:
                                          '${toTime.hour} giờ ${toTime.second}'),
                                );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapSend() async {
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
  }

  onDelete() async {
    print(widget.chatModel.idMess);
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
                    .collection("Chat")
                    .doc(widget.chatModel.idMess)
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
}
