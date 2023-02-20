// To parse this JSON data, do
//
//     final tokenResponseModel = tokenResponseModelFromJson(jsonString);

import 'dart:convert';

TokenResponseModel tokenResponseModelFromJson(String str) => TokenResponseModel.fromJson(json.decode(str));

String tokenResponseModelToJson(TokenResponseModel data) => json.encode(data.toJson());

class TokenResponseModel {
    TokenResponseModel({
        required this.otpType,
        required this.token,
    });

    String otpType;
    Token token;

    factory TokenResponseModel.fromJson(Map<String, dynamic> json) => TokenResponseModel(
        otpType: json["otpType"],
        token: Token.fromJson(json["token"]),
    );

    Map<String, dynamic> toJson() => {
        "otpType": otpType,
        "token": token.toJson(),
    };
}

class Token {
    Token({
        required this.accessToken,
    });

    String accessToken;

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
    };
}
