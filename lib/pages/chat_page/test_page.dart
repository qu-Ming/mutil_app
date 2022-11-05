// ignore_for_file: avoid_print
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mutil_app/model/chat_model.dart';
import 'package:mutil_app/model/user_model.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  XFile? _image;
  final storeRef = FirebaseStorage.instance.ref();

  openGallary() async {
    _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_image == null) {
      return;
    } else {
      setState(() {
        _image = _image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _image == null
                    ? const CircleAvatar(
                        child: Icon(Icons.person),
                      )
                    : Image.file(File(_image!.path)),
                ElevatedButton(
                  onPressed: () async {
                    openGallary();
                  },
                  child: const Text('Chọn ảnh'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_image != null) {
                      upLoadImg(
                          file: File(_image!.path),
                          callback: (url) {
                            /* Update user model*/
                            // user.url = url

                            Map<String, dynamic> userUpdate =
                                UserModel().toJson();
                            userUpdate = {
                              'USER_NAME': 'Minh',
                              'USER_IMG_URL': url,
                            };
                            FirebaseFirestore.instance
                                .collection('User')
                                .doc('user_minh')
                                .update(userUpdate);
                            // update userModel to firebase
                            // CatchNetworkImage
                          });

                      const SnackBar _snackBar = SnackBar(
                        content: Text('Success !'),
                        duration: Duration(milliseconds: 2000),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    }
                  },
                  child: const Text('Đăng ảnh'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    print(FirebaseFirestore.instance
                        .collection("User/user_minh")
                        .firestore);
                  },
                  child: const Text('Check'),
                ),
                // Image.network()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future upLoadImg({File? file, required Function(String) callback}) async {
    String? url;
    String filePath = 'avatar_img/minh/' 'minh.jpg';

    try {
      await FirebaseStorage.instance.ref(filePath).putFile(file!);
      url = await getUrl(filePath);
      if (url.isNotEmpty && url.contains('https')) {
        callback(url);
      }
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
    debugPrint(url);
  }

  static Future<String> getUrl(String path) async {
    String downloadURL =
        await FirebaseStorage.instance.ref(path).getDownloadURL();
    return downloadURL;
  }
}
