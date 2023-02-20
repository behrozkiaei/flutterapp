// To parse this JSON data, do
//
//     final userByCode = userByCodeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserByCode userByCodeFromJson(String str) => UserByCode.fromJson(json.decode(str));

String userByCodeToJson(UserByCode data) => json.encode(data.toJson());

class UserByCode {
    UserByCode({
        required this.username,
        required this.name,
        required this.avatar,
        required this.code,
    });

    String username;
    String name;
    String avatar;
    String code;

    UserByCode copyWith({
        String? username,
        String? name,
        String? avatar,
        String? code,
    }) => 
        UserByCode(
            username: username ?? this.username,
            name: name ?? this.name,
            avatar: avatar ?? this.avatar,
            code: code ?? this.code,
        );

    factory UserByCode.fromJson(Map<String, dynamic> json) => UserByCode(
        username: json["username"],
        name: json["name"],
        avatar: json["avatar"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "avatar": avatar,
        "code": code,
    };
}