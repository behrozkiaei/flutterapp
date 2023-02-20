// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
    Login({
        this.result,
    });

    Result? result;

    factory Login.fromJson(Map<String, dynamic> json) => Login(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "result": result?.toJson(),
    };
}

class Result {
    Result({
        this.otpType,
        this.token,
    });

    dynamic otpType;
    Token? token;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        otpType: json["otpType"],
        token: json["token"] == null ? null : Token.fromJson(json["token"]),
    );

    Map<String, dynamic> toJson() => {
        "otpType": otpType,
        "token": token?.toJson(),
    };
}

class Token {
    Token({
        this.accessToken,
    });

    String? accessToken;

    factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"],
    );

    Map<String, dynamic> toJson() => {
        "access_token": accessToken,
    };
}
