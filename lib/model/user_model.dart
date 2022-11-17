class UserModel {
  String? userImgUrl;
  String? userName;

  UserModel({this.userImgUrl, this.userName});
  UserModel.fromJson(dynamic json) {
    userImgUrl = json['USER_IMG_URL'] ?? '';
    userName = json['USER_NAME'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["USER_IMG_URL"] = userImgUrl;
    map["USER_NAME"] = userName;

    return map;
  }
}
