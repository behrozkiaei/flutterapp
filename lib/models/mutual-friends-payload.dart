// To parse this JSON data, do
//
//     final mutualFriendsPayload = mutualFriendsPayloadFromJson(jsonString);

import 'dart:convert';

import 'package:fast_contacts/fast_contacts.dart';


MutualFriendsPayload mutualFriendsPayloadFromJson(String str) => MutualFriendsPayload.fromJson(json.decode(str));

String mutualFriendsPayloadToJson(MutualFriendsPayload data) => json.encode(data.toJson());

class MutualFriendsPayload {
    MutualFriendsPayload({
        this.phone,
        this.name,
    });

    final String? phone;
    final String? name;

    MutualFriendsPayload copyWith({
        String? phone,
        String? name,
    }) => 
        MutualFriendsPayload(
            phone: phone ?? this.phone,
            name: name ?? this.name,
        );

    factory MutualFriendsPayload.fromJson(Map<String, dynamic> json) => MutualFriendsPayload(
        phone: json["phone"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "name": name,
    };
}



class ContactImpl  {
  ContactImpl({
    required this.id,
    required this.displayName,
    required this.phones,
    required this.emails,
    this.structuredName,
    this.organization,
  });

  @override
  final String id;
  @override
  final String displayName;
  @override
  final List<String> phones;
  @override
  final List<String> emails;
  @override
  final StructuredName? structuredName;
  @override
  final Organization? organization;

  static List<ContactImpl> expandAllByPhones(List<Contact> contacts) {
  return contacts.expand((contact) => expandByPhones(contact)).toList();
  }

  static List<ContactImpl> expandByPhones(Contact contact) {
    return contact.phones.map((phone) => ContactImpl(
      id: contact.id, // use the same ID for all new objects
      displayName: contact.displayName, // use the same display name for all new objects
      phones: [phone], // use only one phone number in each new object
      emails: contact.emails,
      structuredName: contact.structuredName,
      organization: contact.organization,
    )).toList();
}


 static String contactsToJson(List<ContactImpl> contacts) {
  List<Map<String, dynamic>> contactMaps = contacts.map((contact) => {
    'name': contact.displayName,
    'phones': contact.phones[0],
  }).toList();
  
  return jsonEncode(contactMaps);
  }
}


 