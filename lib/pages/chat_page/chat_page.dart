import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mutil_app/components/chat_item.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/model/chat_model.dart';
import 'package:mutil_app/utils/const/app_colors.dart';
import 'package:mutil_app/utils/const/app_dimens.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.pass}) : super(key: key);

  final String pass;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection("Chat")
      .orderBy("Time", descending: false)
      .snapshots();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.pass);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorPink,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60.0,
        color: AppColors.colorWhite,
        child: Center(
          child: TextFormField(
            decoration: const InputDecoration(
              prefixIconColor: AppColors.colorWhite,
              hintText: 'Nhắn tin...',
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.tag_faces,
              ),
              suffixIcon: Icon(
                Icons.send,
              ),
            ),
            cursorColor: AppColors.colorBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> doc = snapshot.data!.docs[index]
                          .data() as Map<String, dynamic>;

                      ChatModel chatModel = ChatModel.fromJson(doc);
                      Timestamp time = chatModel.time!;
                      DateTime toTime = time.toDate();

                      return widget.pass == "minh"
                          ? ChatItem(
                              aligment: chatModel.user == "minh"
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              textMess: chatModel.messenger!,
                              texTime: '${toTime.hour} giờ ${toTime.second}')
                          : ChatItem(
                              aligment: doc["User"] == "ngan"
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              textMess: chatModel.messenger!,
                              texTime: '${toTime.hour} giờ ${toTime.second}');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
