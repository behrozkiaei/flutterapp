// To parse this JSON data, do
//
//     final mutualFriends = mutualFriendsFromJson(jsonString);

import 'dart:convert';

MutualFriendsModel mutualFriendsFromJson(String str) => MutualFriendsModel.fromJson(json.decode(str));

String mutualFriendsToJson(MutualFriendsModel data) => json.encode(data.toJson());

class MutualFriendsModel {
    MutualFriendsModel({
        this.wallet,
        this.avatar,
        this.name,
    });

    final Wallet? wallet;
    final String? avatar;
    final String? name;

    MutualFriendsModel copyWith({
        Wallet? wallet,
        String? avatar,
        String? name,
    }) => 
        MutualFriendsModel(
            wallet: wallet ?? this.wallet,
            avatar: avatar ?? this.avatar,
            name: name ?? this.name,
        );

    factory MutualFriendsModel.fromJson(Map<String, dynamic> json) => MutualFriendsModel(
        wallet: json["Wallet"] == null ? null : Wallet.fromJson(json["Wallet"]),
        avatar: json["avatar"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "Wallet": wallet?.toJson(),
        "avatar": avatar,
        "name": name,
    };
}

class Wallet {
    Wallet({
        this.walletCode,
    });

    final String? walletCode;

    Wallet copyWith({
        String? walletCode,
    }) => 
        Wallet(
            walletCode: walletCode ?? this.walletCode,
        );

    factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        walletCode: json["walletCode"],
    );

    Map<String, dynamic> toJson() => {
        "walletCode": walletCode,
    };
}


class LastPaidUsersModel extends MutualFriendsModel{

}