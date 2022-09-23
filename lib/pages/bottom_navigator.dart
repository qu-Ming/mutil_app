import 'package:flutter/material.dart';
import 'package:mutil_app/pages/chat_page/chat_page.dart';
import 'package:mutil_app/pages/date_page/date_page.dart';
import 'package:mutil_app/pages/random_page/random_page.dart';
import 'package:mutil_app/utils/const/app_colors.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _currentIndex = 1;
  List<Widget> body = const [ChatPage(), DatePage(), RandomPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
            left: 26.0, top: 10.0, right: 26.0, bottom: 20.0),
        child: BottomNavigationBar(
          backgroundColor: AppColors.colorPink,
          selectedItemColor: AppColors.colorDarkPink,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Messege',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Date',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shuffle_outlined),
              label: 'Random',
            ),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
      body: body[_currentIndex],
    );
  }
}
