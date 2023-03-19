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
        this.password2,
        this.loginTime,
        this.otpType,
        this.otpDate,
        this.nationalCode,
        this.cartMelli,
        this.shenasname,
        this.fcmToken,
        this.wallet,
        this.fromUsers,
    });

    final String? id;
    final String? mobile;
    final String? name;
    final dynamic address;
    final dynamic username;
    final dynamic description;
    final dynamic email;
    final dynamic lat;
    final String? lan;
    final dynamic status;
    final String? avatar;
    final String? role;
    final dynamic website;
    final dynamic contantPersonName;
    final dynamic contactPersonPhone;
    final dynamic icon;
    final bool? active;
    final bool? verified;
    final String? phone;
    final String? createdAt;
    final String? updatedAt;
    final String? sheba;
    final String? card;
    final bool? verifiedBank;
    final dynamic dateVerified;
    final String? date;
    final String? password;
    final String? password2;
    final String? loginTime;
    final String? otpType;
    final String? otpDate;
    final String? nationalCode;
    final String? cartMelli;
    final dynamic shenasname;
    final String? fcmToken;
    final MeModelWallet? wallet;
    final List<FromUser>? fromUsers;

    MeModel copyWith({
        String? id,
        String? mobile,
        String? name,
        dynamic address,
        dynamic username,
        dynamic description,
        dynamic email,
        dynamic lat,
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
        String? createdAt,
        String? updatedAt,
        String? sheba,
        String? card,
        bool? verifiedBank,
        dynamic dateVerified,
        String? date,
        String? password,
        String? password2,
        String? loginTime,
        String? otpType,
        String? otpDate,
        String? nationalCode,
        String? cartMelli,
        dynamic shenasname,
        String? fcmToken,
        MeModelWallet? wallet,
        List<FromUser>? fromUsers,
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
            password2: password2 ?? this.password2,
            loginTime: loginTime ?? this.loginTime,
            otpType: otpType ?? this.otpType,
            otpDate: otpDate ?? this.otpDate,
            nationalCode: nationalCode ?? this.nationalCode,
            cartMelli: cartMelli ?? this.cartMelli,
            shenasname: shenasname ?? this.shenasname,
            fcmToken: fcmToken ?? this.fcmToken,
            wallet: wallet ?? this.wallet,
            fromUsers: fromUsers ?? this.fromUsers,
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
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        sheba: json["sheba"],
        card: json["card"],
        verifiedBank: json["verified_bank"],
        dateVerified: json["dateVerified"],
        date: json["date"],
        password: json["password"],
        password2: json["password2"],
        loginTime: json["loginTime"],
        otpType: json["otpType"],
        otpDate: json["otpDate"],
        nationalCode: json["nationalCode"],
        cartMelli: json["cartMelli"],
        shenasname: json["shenasname"],
        fcmToken: json["fcmToken"],
        wallet: json["Wallet"] == null ? null : MeModelWallet.fromJson(json["Wallet"]),
        fromUsers: json["fromUsers"] == null ? [] : List<FromUser>.from(json["fromUsers"]!.map((x) => FromUser.fromJson(x))),
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
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "sheba": sheba,
        "card": card,
        "verified_bank": verifiedBank,
        "dateVerified": dateVerified,
        "date": date,
        "password": password,
        "password2": password2,
        "loginTime": loginTime,
        "otpType": otpType,
        "otpDate": otpDate,
        "nationalCode": nationalCode,
        "cartMelli": cartMelli,
        "shenasname": shenasname,
        "fcmToken": fcmToken,
        "Wallet": wallet?.toJson(),
        "fromUsers": fromUsers == null ? [] : List<dynamic>.from(fromUsers!.map((x) => x.toJson())),
    };
}

class FromUser {
    FromUser({
        this.id,
        this.fromUserId,
        this.destUserId,
        this.destUser,
    });

    final String? id;
    final String? fromUserId;
    final String? destUserId;
    final DestUser? destUser;

    FromUser copyWith({
        String? id,
        String? fromUserId,
        String? destUserId,
        DestUser? destUser,
    }) => 
        FromUser(
            id: id ?? this.id,
            fromUserId: fromUserId ?? this.fromUserId,
            destUserId: destUserId ?? this.destUserId,
            destUser: destUser ?? this.destUser,
        );

    factory FromUser.fromJson(Map<String, dynamic> json) => FromUser(
        id: json["id"],
        fromUserId: json["fromUserId"],
        destUserId: json["destUserId"],
        destUser: json["destUser"] == null ? null : DestUser.fromJson(json["destUser"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fromUserId": fromUserId,
        "destUserId": destUserId,
        "destUser": destUser?.toJson(),
    };
}

class DestUser {
    DestUser({
        this.name,
        this.avatar,
        this.wallet,
    });

    final String? name;
    final dynamic avatar;
    final DestUserWallet? wallet;

    DestUser copyWith({
        String? name,
        dynamic avatar,
        DestUserWallet? wallet,
    }) => 
        DestUser(
            name: name ?? this.name,
            avatar: avatar ?? this.avatar,
            wallet: wallet ?? this.wallet,
        );

    factory DestUser.fromJson(Map<String, dynamic> json) => DestUser(
        name: json["name"],
        avatar: json["avatar"],
        wallet: json["Wallet"] == null ? null : DestUserWallet.fromJson(json["Wallet"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "avatar": avatar,
        "Wallet": wallet?.toJson(),
    };
}

class DestUserWallet {
    DestUserWallet({
        this.walletCode,
    });

    final String? walletCode;

    DestUserWallet copyWith({
        String? walletCode,
    }) => 
        DestUserWallet(
            walletCode: walletCode ?? this.walletCode,
        );

    factory DestUserWallet.fromJson(Map<String, dynamic> json) => DestUserWallet(
        walletCode: json["walletCode"],
    );

    Map<String, dynamic> toJson() => {
        "walletCode": walletCode,
    };
}

class MeModelWallet {
    MeModelWallet({
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

    final String? id;
    final String? userId;
    final dynamic name;
    final int? amount;
    final String? walletCode;
    final String? walletType;
    final String? createdAt;
    final String? updatedAt;
    final String? date;

    MeModelWallet copyWith({
        String? id,
        String? userId,
        dynamic name,
        int? amount,
        String? walletCode,
        String? walletType,
        String? createdAt,
        String? updatedAt,
        String? date,
    }) => 
        MeModelWallet(
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

    factory MeModelWallet.fromJson(Map<String, dynamic> json) => MeModelWallet(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        amount: json["amount"],
        walletCode: json["walletCode"],
        walletType: json["walletType"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "name": name,
        "amount": amount,
        "walletCode": walletCode,
        "walletType": walletType,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "date": date,
    };
}
