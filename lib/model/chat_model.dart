import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? idMess;
  String? messenger;
  Timestamp? time;
  String? user;
  String? imgUrl;

  ChatModel({this.time, this.messenger, this.user});

  ChatModel.fromJson(dynamic json) {
    messenger = json['Messenger'] ?? '';
    time = json['Time'] ?? '';
    user = json['User'] ?? '';
    imgUrl = json['ImgUrl'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["Messenger"] = messenger;
    map["Time"] = time;
    map["User"] = user;
    map['ImgUrl'] = imgUrl;
    return map;
  }
}
