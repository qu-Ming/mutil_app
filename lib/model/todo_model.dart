import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? title;
  String? content;
  Timestamp? dayCreate;

  TodoModel({this.title, this.content, this.dayCreate});
}
