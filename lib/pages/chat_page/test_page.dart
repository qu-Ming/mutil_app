import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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
                  final mountainsRef = storeRef.child("/avatar_img/minh/");
                  Directory appDocDir =
                      await getApplicationDocumentsDirectory();
                  String filePath = '${appDocDir.absolute}/file-to-upload.png';
                  File file = File(filePath);
                  try {
                    await mountainsRef.putFile(file);
                  } on FirebaseException catch (e) {
                    print(e);
                  }
                },
                child: const Text('Đăng ảnh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
