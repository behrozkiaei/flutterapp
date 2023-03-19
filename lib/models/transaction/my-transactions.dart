// To parse this JSON data, do
//
//     final myTransactions = myTransactionsFromJson(jsonString);

import 'dart:convert';

List<MyTransactions> myTransactionsFromJson(String str) => List<MyTransactions>.from(json.decode(str).map((x) => MyTransactions.fromJson(x)));

String myTransactionsToJson(List<MyTransactions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyTransactions {
    MyTransactions({
        this.id,
        this.type,
        this.amount,
        this.userId,
        this.date,
        this.title,
        this.subTitle,
        this.avatar,
        this.isPaid,
        this.createdAt,
        this.updatedAt,
        this.datePaid,
        this.data1,
        this.data2,
        this.data3,
        this.data4,
        this.payload,
        this.desc,
    });

    final String? id;
    final String? type;
    final int? amount;
    final String? userId;
    final String? date;
    final String? title;
    final String? subTitle;
    final dynamic avatar;
    final bool? isPaid;
    final String? createdAt;
    final String? updatedAt;
    final dynamic datePaid;
    final dynamic data1;
    final dynamic data2;
    final dynamic data3;
    final dynamic data4;
    final String? payload;
    final List<Desc>? desc;

    MyTransactions copyWith({
        String? id,
        String? type,
        int? amount,
        String? userId,
        String? date,
        String? title,
        String? subTitle,
        dynamic avatar,
        bool? isPaid,
        String? createdAt,
        String? updatedAt,
        dynamic datePaid,
        dynamic data1,
        dynamic data2,
        dynamic data3,
        dynamic data4,
        String? payload,
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
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        datePaid: json["datePaid"],
        data1: json["data1"],
        data2: json["data2"],
        data3: json["data3"],
        data4: json["data4"],
        payload: json["payload"],
        desc: json["desc"] == null ? [] : List<Desc>.from(json["desc"]!.map((x) => Desc.fromJson(x))),
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
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "datePaid": datePaid,
        "data1": data1,
        "data2": data2,
        "data3": data3,
        "data4": data4,
        "payload": payload,
        "desc": desc == null ? [] : List<dynamic>.from(desc!.map((x) => x.toJson())),
    };
}

class Desc {
    Desc({
        this.id,
        this.key,
        this.value,
        this.orderId,
    });

    final String? id;
    final String? key;
    final String? value;
    final String? orderId;

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

    factory Desc.fromJson(Map<String, dynamic> json) => Desc(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        orderId: json["orderId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "orderId": orderId,
    };
}
