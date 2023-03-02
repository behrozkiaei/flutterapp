// To parse this JSON data, do
//
//     final paymentRequestModel = paymentRequestModelFromJson(jsonString);

import 'dart:convert';

PaymentRequestModel paymentRequestModelFromJson(String str) => PaymentRequestModel.fromJson(json.decode(str));

String paymentRequestModelToJson(PaymentRequestModel data) => json.encode(data.toJson());

class PaymentRequestModel {
    PaymentRequestModel({
        this.id,
        this.userId,
        this.description,
        this.amount,
        this.state,
        this.desc1,
        this.desc2,
        this.desc3,
        this.bankResponse,
        this.date,
        this.dateResponse,
    });

    String? id;
    String? userId;
    String? description;
    int? amount;
    String? state;
    String? desc1;
    String? desc2;
    String? desc3;
    String? bankResponse;
    String? date;
    String? dateResponse;

    PaymentRequestModel copyWith({
        String? id,
        String? userId,
        String? description,
        int? amount,
        String? state,
        String? desc1,
        String? desc2,
        String? desc3,
        String? bankResponse,
        String? date,
        String? dateResponse,
    }) => 
        PaymentRequestModel(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            description: description ?? this.description,
            amount: amount ?? this.amount,
            state: state ?? this.state,
            desc1: desc1 ?? this.desc1,
            desc2: desc2 ?? this.desc2,
            desc3: desc3 ?? this.desc3,
            bankResponse: bankResponse ?? this.bankResponse,
            date: date ?? this.date,
            dateResponse: dateResponse ?? this.dateResponse,
        );

    factory PaymentRequestModel.fromJson(Map<String, dynamic> json) => PaymentRequestModel(
        id: json["id"],
        userId: json["userId"],
        description: json["description"],
        amount: json["amount"],
        state: json["state"],
        desc1: json["desc1"],
        desc2: json["desc2"],
        desc3: json["desc3"],
        bankResponse: json["bankResponse"],
        date: json["date"],
        dateResponse: json["dateResponse"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "description": description,
        "amount": amount,
        "state": state,
        "desc1": desc1,
        "desc2": desc2,
        "desc3": desc3,
        "bankResponse": bankResponse,
        "date": date,
        "dateResponse": dateResponse,
    };
}
