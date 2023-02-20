// To parse this JSON data, do
//
//     final myTransactions = myTransactionsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyTransactions myTransactionsFromJson(String str) => MyTransactions.fromJson(json.decode(str));

String myTransactionsToJson(MyTransactions data) => json.encode(data.toJson());

class MyTransactions {
    MyTransactions({
        required this.id,
        required this.type,
        required this.amount,
        required this.userId,
        required this.date,
        required this.title,
        required this.subTitle,
        required this.avatar,
        required this.isPaid,
        required this.createdAt,
        required this.updatedAt,
        required this.datePaid,
        required this.data1,
        required this.data2,
        required this.data3,
        required this.data4,
        required this.payload,
        required this.desc,
    });

    String id;
    String type;
    int amount;
    String userId;
    String date;
    String title;
    String subTitle;
    dynamic avatar;
    bool isPaid;
    DateTime createdAt;
    DateTime updatedAt;
    String datePaid;
    dynamic data1;
    dynamic data2;
    dynamic data3;
    dynamic data4;
    dynamic payload;
    List<Desc> desc;
 MyTransactions copyWith(Map<dynamic, List<Desc>> map, {
        String? id,
        String? type,
        int? amount,
        String? userId,
        String? date,
        String? title,
        String? subTitle,
        dynamic avatar,
        bool? isPaid,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? datePaid,
        dynamic data1,
        dynamic data2,
        dynamic data3,
        dynamic data4,
        dynamic payload,
        List<Desc>? desc,
    }) => 
        MyTransactions(
            id: id ?? this.id,
            type: type ?? this.type,
            amount: amount ?? this.amount,
            userId: userId ?? this.userId,
            date: date ?? this.date,
            title: title ?? this.title,
            subTitle: subTitle ?? this.subTitle,
            avatar: avatar ?? this.avatar,
            isPaid: isPaid ?? this.isPaid,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            datePaid: datePaid ?? this.datePaid,
            data1: data1 ?? this.data1,
            data2: data2 ?? this.data2,
            data3: data3 ?? this.data3,
            data4: data4 ?? this.data4,
            payload: payload ?? this.payload,
            desc: desc ?? this.desc,
        );
    factory MyTransactions.fromJson(Map<String, dynamic> json) => MyTransactions(
        id: json["id"],
        type: json["type"],
        amount: json["amount"],
        userId: json["userId"],
        date: json["date"],
        title: json["title"],
        subTitle: json["subTitle"],
        avatar: json["avatar"],
        isPaid: json["isPaid"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        datePaid: json["datePaid"],
        data1: json["data1"],
        data2: json["data2"],
        data3: json["data3"],
        data4: json["data4"],
        payload: json["payload"],
        desc: List<Desc>.from(json["desc"].map((x) => Desc.fromJson(x))),
    );
   
    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "amount": amount,
        "userId": userId,
        "date": date,
        "title": title,
        "subTitle": subTitle,
        "avatar": avatar,
        "isPaid": isPaid,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "datePaid": datePaid,
        "data1": data1,
        "data2": data2,
        "data3": data3,
        "data4": data4,
        "payload": payload,
        "desc": List<dynamic>.from(desc.map((x) => x.toJson())),
    };
}

class Desc {
    Desc({
        required this.id,
        required this.key,
        required this.value,
        required this.orderId,
    });

    String id;
    String key;
    String value;
    String orderId;

    factory Desc.fromJson(Map<String, dynamic> json) => Desc(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        orderId: json["orderId"],
    );
    Desc copyWith({
        String? id,
        String? key,
        String? value,
        String? orderId,
    }) => 
        Desc(
            id: id ?? this.id,
            key: key ?? this.key,
            value: value ?? this.value,
            orderId: orderId ?? this.orderId,
        );
    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "orderId": orderId,
    };

  toList() {}
}
