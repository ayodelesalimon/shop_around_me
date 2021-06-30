// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String username;
    String name;

    UserModel({
        this.username,
        this.name,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        name: json["Name"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "Name": name,
    };
}