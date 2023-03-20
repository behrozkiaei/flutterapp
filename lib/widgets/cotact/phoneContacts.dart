// ignore: file_names, unused_import
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/user/mutual-friends/mutual-friends.bloc.dart';
import 'package:paytel/blocs/user/mutual-friends/mutual-friends.event.dart';
import 'package:paytel/blocs/user/mutual-friends/mutual-friends.state.dart';
import 'package:paytel/models/mutual-friends.model.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:paytel/style/theme.dart' as Style;
class MyContacts extends StatefulWidget {
  const MyContacts({super.key});

  @override
  State<MyContacts> createState() => PhoneContacts();

}


class PhoneContacts extends State<MyContacts> {
   List<MutualFriendsModel>? _contacts;
   List<Contact>? _mobilecontacts;

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
            _mobilecontacts = temp.toList();

          });
          if(!mounted){
            return ;
          }
          BlocProvider.of<MutualFriendsBloc>(context).add(MutualFriendsButtonPressed(listOfContacts: _mobilecontacts!));
        }
      }catch(e){
        return ;
      }
    }


  @override
  Widget build(BuildContext context) {
    return BlocListener<MutualFriendsBloc, MutualFriendsState>(
      listener: (context, state) {
        if (state is MutualFriendsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("مشکل در دریافت اطلاعات رخ داده است",
                  style: TextStyle(color: Style.Colors.gray2)),
              backgroundColor: Style.Colors.fail,
            ),
          );
        }
        if (state is MutualFriendsListSuccess) {
          setState(() {
            _contacts = state.mutualFriends;
          });
        }
      },
      child: 
     _contacts == null
          ? const  Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts!.length,
              itemBuilder: (context, index) {
                MutualFriendsModel contact = _contacts![index] ;
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(contact.name!.split('').first),
                  ),
                  title: Text(contact.name ?? ""),
                );
              },
            ),
            );
    
  }
}