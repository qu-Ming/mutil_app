import 'package:flutter/material.dart';
import 'package:mutil_app/components/text_component.dart';
import 'package:mutil_app/utils/const/app_colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPink,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60.0,
        color: AppColors.colorWhite,
        child: Center(
          child: TextFormField(
            decoration: const InputDecoration(
                hintText: 'Nhắn tin...',
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.tag_faces,
                ),
                suffixIcon: Icon(Icons.send)),
            cursorColor: AppColors.colorBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  color: AppColors.colorPink4,
                  child: TextComponent(text: 'text'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
