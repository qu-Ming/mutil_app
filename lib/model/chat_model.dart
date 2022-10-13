import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? idMess;
  String? messenger;
  Timestamp? time;
  String? user;

  ChatModel({this.time, this.messenger, this.user});

  ChatModel.fromJson(dynamic json) {
    messenger = json['Messenger'] ?? '';
    time = json['Time'] ?? '';
    user = json['User'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["Messenger"] = messenger;
    map["Time"] = time;
    map["User"] = user;
    return map;
  }
}
