// ignore: file_names, unused_import
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytel/style/theme.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:permission_handler/permission_handler.dart';
class MyContacts extends StatefulWidget {
  const MyContacts({super.key});

  @override
  State<MyContacts> createState() => PhoneContacts();

}


class PhoneContacts extends State<MyContacts> {
   List<Contact>? _contacts;

    @override
    void initState() {
      super.initState();
      _getContacts();
    }

    void _getContacts() async {
      try{

        if (await Permission.contacts.request().isGranted) {
          // Either the permission was already granted before or the user just granted it.
          // Get all contacts
          final temp = await FastContacts.allContacts;
          setState(() {
            _contacts = temp.toList();
          });
        }
      }catch(e){
        return ;
      }
    }


  @override
  Widget build(BuildContext context) {
    return 
     _contacts == null
          ? const  Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts!.length,
              itemBuilder: (context, index) {
                Contact contact = _contacts![index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(contact.displayName.split('').first),
                  ),
                  title: Text(contact.displayName),
                );
              },
            );
    
  }
}