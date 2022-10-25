import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mutil_app/pages/bottom_navigator.dart';
import 'package:mutil_app/pages/chat_page/chat_page.dart';
import 'package:mutil_app/pages/chat_page/security_page.dart';
import 'package:mutil_app/pages/chat_page/test_page.dart';

import 'firebase_options.dart';

// void main() {
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: BottomNavigator(),
      home: TestPage(),
    );
  }
}
