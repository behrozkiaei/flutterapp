// To parse this JSON data, do
//
//     final tokenResponseModel = tokenResponseModelFromJson(jsonString);

import 'dart:convert';

TokenResponseModel tokenResponseModelFromJson(String str) => TokenResponseModel.fromJson(json.decode(str));

String tokenResponseModelToJson(TokenResponseModel data) => json.encode(data.toJson());

class TokenResponseModel {
    TokenResponseModel({
        this.otpType,
        this.token,
        this.uid,
        this.userId,
    });

    final String? otpType;
    final dynamic token;
    final String? uid;
    final String? userId;

    TokenResponseModel copyWith({
        String? otpType,
        dynamic token,
        String? uid,
        String? userId,
    }) => 
        TokenResponseModel(
            otpType: otpType ?? this.otpType,
            token: token ?? this.token,
            uid: uid ?? this.uid,
            userId: userId ?? this.userId,
        );

    factory TokenResponseModel.fromJson(Map<String, dynamic> json) => TokenResponseModel(
        otpType: json["otpType"],
        token: json["token"],
        uid: json["uid"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "otpType": otpType,
        "token": token,
        "uid": uid,
        "userId": userId,
    };
}
