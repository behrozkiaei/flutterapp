// To parse this JSON data, do
//
//     final meModel = meModelFromJson(jsonString);

import 'dart:convert';

MeModel meModelFromJson(String str) => MeModel.fromJson(json.decode(str));

String meModelToJson(MeModel data) => json.encode(data.toJson());

class MeModel {
    MeModel({
        this.id,
        this.mobile,
        this.name,
        this.address,
        this.username,
        this.description,
        this.email,
        this.lat,
        this.lan,
        this.status,
        this.avatar,
        this.role,
        this.website,
        this.contantPersonName,
        this.contactPersonPhone,
        this.icon,
        this.active,
        this.verified,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.sheba,
        this.card,
        this.verifiedBank,
        this.dateVerified,
        this.date,
        this.password,
        this.otpType,
        this.otpDate,
        this.nationalCode,
        this.cartMelli,
        this.shenasname,
        this.wallet,
        this.order,
    });

    String? id;
    String? mobile;
    String? name;
    String? address;
    String? username;
    String? description;
    String? email;
    String? lat;
    String? lan;
    dynamic status;
    String? avatar;
    String? role;
    dynamic website;
    dynamic contantPersonName;
    dynamic contactPersonPhone;
    dynamic icon;
    bool? active;
    bool? verified;
    String? phone;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? sheba;
    String? card;
    bool? verifiedBank;
    dynamic dateVerified;
    String? date;
    String? password;
    String? otpType;
    String? otpDate;
    dynamic nationalCode;
    String? cartMelli;
    dynamic shenasname;
    Wallet? wallet;
    List<Order>? order;

    MeModel copyWith({
        String? id,
        String? mobile,
        String? name,
        String? address,
        String? username,
        String? description,
        String? email,
        String? lat,
        String? lan,
        dynamic status,
        String? avatar,
        String? role,
        dynamic website,
        dynamic contantPersonName,
        dynamic contactPersonPhone,
        dynamic icon,
        bool? active,
        bool? verified,
        String? phone,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? sheba,
        String? card,
        bool? verifiedBank,
        dynamic dateVerified,
        String? date,
        String? password,
        String? otpType,
        String? otpDate,
        dynamic nationalCode,
        String? cartMelli,
        dynamic shenasname,
        Wallet? wallet,
        List<Order>? order,
    }) => 
        MeModel(
            id: id ?? this.id,
            mobile: mobile ?? this.mobile,
            name: name ?? this.name,
            address: address ?? this.address,
            username: username ?? this.username,
            description: description ?? this.description,
            email: email ?? this.email,
            lat: lat ?? this.lat,
            lan: lan ?? this.lan,
            status: status ?? this.status,
            avatar: avatar ?? this.avatar,
            role: role ?? this.role,
            website: website ?? this.website,
            contantPersonName: contantPersonName ?? this.contantPersonName,
            contactPersonPhone: contactPersonPhone ?? this.contactPersonPhone,
            icon: icon ?? this.icon,
            active: active ?? this.active,
            verified: verified ?? this.verified,
            phone: phone ?? this.phone,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            sheba: sheba ?? this.sheba,
            card: card ?? this.card,
            verifiedBank: verifiedBank ?? this.verifiedBank,
            dateVerified: dateVerified ?? this.dateVerified,
            date: date ?? this.date,
            password: password ?? this.password,
            otpType: otpType ?? this.otpType,
            otpDate: otpDate ?? this.otpDate,
            nationalCode: nationalCode ?? this.nationalCode,
            cartMelli: cartMelli ?? this.cartMelli,
            shenasname: shenasname ?? this.shenasname,
            wallet: wallet ?? this.wallet,
            order: order ?? this.order,
        );

    factory MeModel.fromJson(Map<String, dynamic> json) => MeModel(
        id: json["id"],
        mobile: json["mobile"],
        name: json["name"],
        address: json["address"],
        username: json["username"],
        description: json["description"],
        email: json["email"],
        lat: json["lat"],
        lan: json["lan"],
        status: json["status"],
        avatar: json["avatar"],
        role: json["role"],
        website: json["website"],
        contantPersonName: json["contantPersonName"],
        contactPersonPhone: json["contactPersonPhone"],
        icon: json["icon"],
        active: json["active"],
        verified: json["verified"],
        phone: json["phone"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        sheba: json["sheba"],
        card: json["card"],
        verifiedBank: json["verified_bank"],
        dateVerified: json["dateVerified"],
        date: json["date"],
        password: json["password"],
        otpType: json["otpType"],
        otpDate: json["otpDate"],
        nationalCode: json["nationalCode"],
        cartMelli: json["cartMelli"],
        shenasname: json["shenasname"],
        wallet: json["Wallet"] == null ? null : Wallet.fromJson(json["Wallet"]),
        order: json["order"] == null ? [] : List<Order>.from(json["order"]!.map((x) => Order.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mobile": mobile,
        "name": name,
        "address": address,
        "username": username,
        "description": description,
        "email": email,
        "lat": lat,
        "lan": lan,
        "status": status,
        "avatar": avatar,
        "role": role,
        "website": website,
        "contantPersonName": contantPersonName,
        "contactPersonPhone": contactPersonPhone,
        "icon": icon,
        "active": active,
        "verified": verified,
        "phone": phone,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "sheba": sheba,
        "card": card,
        "verified_bank": verifiedBank,
        "dateVerified": dateVerified,
        "date": date,
        "password": password,
        "otpType": otpType,
        "otpDate": otpDate,
        "nationalCode": nationalCode,
        "cartMelli": cartMelli,
        "shenasname": shenasname,
        "Wallet": wallet?.toJson(),
        "order": order == null ? [] : List<dynamic>.from(order!.map((x) => x.toJson())),
    };
}

class Order {
    Order({
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
    });

    String? id;
    String? type;
    int? amount;
    String? userId;
    String? date;
    String? title;
    String? subTitle;
    dynamic avatar;
    bool? isPaid;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? datePaid;
    dynamic data1;
    dynamic data2;
    dynamic data3;
    dynamic data4;

    Order copyWith({
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
    }) => 
        Order(
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
        );

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        type: json["type"],
        amount: json["amount"],
        userId: json["userId"],
        date: json["date"],
        title: json["title"],
        subTitle: json["subTitle"],
        avatar: json["avatar"],
        isPaid: json["isPaid"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        datePaid: json["datePaid"],
        data1: json["data1"],
        data2: json["data2"],
        data3: json["data3"],
        data4: json["data4"],
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
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "datePaid": datePaid,
        "data1": data1,
        "data2": data2,
        "data3": data3,
        "data4": data4,
    };
}

class Wallet {
    Wallet({
        this.id,
        this.userId,
        this.name,
        this.amount,
        this.walletCode,
        this.walletType,
        this.createdAt,
        this.updatedAt,
        this.date,
    });

    String? id;
    String? userId;
    dynamic name;
    int? amount;
    String? walletCode;
    String? walletType;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? date;

    Wallet copyWith({
        String? id,
        String? userId,
        dynamic name,
        int? amount,
        String? walletCode,
        String? walletType,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? date,
    }) => 
        Wallet(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            name: name ?? this.name,
            amount: amount ?? this.amount,
            walletCode: walletCode ?? this.walletCode,
            walletType: walletType ?? this.walletType,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            date: date ?? this.date,
        );

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        amount: json["amount"],
        walletCode: json["walletCode"],
        walletType: json["walletType"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "amount": amount,
        "walletCode": walletCode,
        "walletType": walletType,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "date": date,
    };
}
