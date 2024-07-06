import 'dart:convert';

class UserLoginResponseModel {
  final String? userId;
  final String? email;
  final String? name;
  final String? username;

  UserLoginResponseModel({
    this.userId,
    this.email,
    this.name,
    this.username,
  });

  factory UserLoginResponseModel.fromJson(String str) =>
      UserLoginResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserLoginResponseModel.fromMap(Map<String, dynamic> json) =>
      UserLoginResponseModel(
        userId: json["userId "],
        email: json["email"],
        name: json["name"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "userId ": userId,
        "email": email,
        "name": name,
        "username": username,
      };
}
