// To parse this JSON data, do
//
//     final userByCode = userByCodeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BankUrl userByCodeFromJson(String str) => BankUrl.fromJson(json.decode(str));

String userByCodeToJson(BankUrl data) => json.encode(data.toJson());

class BankUrl {
    BankUrl({
        required this.redirectUrl,
    });

    String redirectUrl;

    factory BankUrl.fromJson(Map<String, dynamic> json) => BankUrl(
        redirectUrl: json["RedirectURL"],
    );

    Map<String, dynamic> toJson() => {
        "RedirectURL": redirectUrl,
    };
}
