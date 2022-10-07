import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? title;
  String? content;
  Timestamp? dayCreate;

  TodoModel({this.title, this.content, this.dayCreate});

  TodoModel.fromJson(dynamic json) {
    title = json['Title'] ?? '';
    content = json['Content'] ?? '';
    dayCreate = json['Time'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['Title'] = title;
    map['Content'] = content;
    map['Time'] = dayCreate;
    return map;
  }
}
