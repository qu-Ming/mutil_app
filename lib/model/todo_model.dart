import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? idTodo;
  String? title;
  String? content;
  Timestamp? dayCreate;
  bool? check;

  TodoModel({this.title, this.content, this.dayCreate, this.idTodo});

  TodoModel.fromJson(dynamic json) {
    title = json['Title'] ?? '';
    content = json['Content'] ?? '';
    dayCreate = json['Time'] ?? '';
    check = json['Check'] ?? false;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['Title'] = title;
    map['Content'] = content;
    map['Time'] = dayCreate;
    map['Check'] = check;
    return map;
  }
}
