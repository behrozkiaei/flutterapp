// To parse this JSON data, do
//
//     final internetPackages = internetPackagesFromJson(jsonString);

import 'dart:convert';

InternetPackagesModel internetPackagesFromJson(String str) => InternetPackagesModel.fromJson(json.decode(str));

String internetPackagesToJson(InternetPackagesModel data) => json.encode(data.toJson());

class InternetPackagesModel {
    InternetPackagesModel({
        this.key,
        this.value,
    });

    String? key;
    List<Value>? value;

    InternetPackagesModel copyWith({
        String? key,
        List<Value>? value,
    }) => 
        InternetPackagesModel(
            key: key ?? this.key,
            value: value ?? this.value,
        );

    factory InternetPackagesModel.fromJson(Map<String, dynamic> json) => InternetPackagesModel(
        key: json["key"],
        value: json["value"] == null ? [] : List<Value>.from(json["value"]!.map((x) => Value.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "value": value == null ? [] : List<dynamic>.from(value!.map((x) => x.toJson())),
    };
}

class Value {
    Value({
        this.name,
        this.amount,
        this.amountRial,
        this.simType,
        this.internetType,
        this.valueOperator,
        this.days,
        this.volume,
        this.unit,
        this.course,
        this.courseRange,
        this.productId,
        this.date,
    });

    String? name;
    String? amount;
    String? amountRial;
    String? simType;
    String? internetType;
    String? valueOperator;
    String? days;
    String? volume;
    String? unit;
    String? course;
    String? courseRange;
    String? productId;
    String? date;

    Value copyWith({
        String? name,
        String? amount,
        String? amountRial,
        String? simType,
        String? internetType,
        String? valueOperator,
        String? days,
        String? volume,
        String? unit,
        String? course,
        String? courseRange,
        String? productId,
        String? date,
    }) => 
        Value(
            name: name ?? this.name,
            amount: amount ?? this.amount,
            amountRial: amountRial ?? this.amountRial,
            simType: simType ?? this.simType,
            internetType: internetType ?? this.internetType,
            valueOperator: valueOperator ?? this.valueOperator,
            days: days ?? this.days,
            volume: volume ?? this.volume,
            unit: unit ?? this.unit,
            course: course ?? this.course,
            courseRange: courseRange ?? this.courseRange,
            productId: productId ?? this.productId,
            date: date ?? this.date,
        );

    factory Value.fromJson(Map<String, dynamic> json) => Value(
        name: json["name"],
        amount: json["amount"],
        amountRial: json["amount_rial"],
        simType: json["sim_type"],
        internetType: json["internet_type"],
        valueOperator: json["operator"],
        days: json["days"],
        volume: json["volume"],
        unit: json["unit"],
        course: json["course"],
        courseRange: json["course_range"],
        productId: json["product_id"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "amount_rial": amountRial,
        "sim_type": simType,
        "internet_type": internetType,
        "operator": valueOperator,
        "days": days,
        "volume": volume,
        "unit": unit,
        "course": course,
        "course_range": courseRange,
        "product_id": productId,
        "date": date,
    };
}
