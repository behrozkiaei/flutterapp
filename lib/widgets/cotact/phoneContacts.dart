// ignore: file_names, unused_import
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytell/style/theme.dart';
import 'package:paytell/style/theme.dart' as Style;
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
    // ListView(
    //   children: List.generate(20, (index) {
    //     return
        
    //      Container(
    //       margin: const EdgeInsets.all(2),
    //       height: 80,
    //       child: Row(
    //         children: [
    //           Container(
    //             height: 80,
    //             width: 80,
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               border: Border.all(
    //                 color: Style.Colors.primary,
    //                 width: 1
    //               ),
    //             ),
    //             child:      CachedNetworkImage(
    //                         imageUrl: 'https://picsum.photos/200?random=$index',
    //                         imageBuilder: (context, imageProvider) => Container(
    //                         width: 80.0,
    //                           height: 80.0,
    //                           decoration: BoxDecoration(
    //                             shape: BoxShape.circle,
    //                             image: DecorationImage(
    //                               image: imageProvider, fit: BoxFit.cover),
    //                           ),
    //                         ),
    //                          progressIndicatorBuilder: (context, url, downloadProgress) => 
    //                           CircularProgressIndicator(value: downloadProgress.progress,color: Style.Colors.gray2,strokeWidth :1.0),
    //                         errorWidget: (context, url, error) =>const Icon(Icons.error),
    //                   ),
    //           ),
    //           const  SizedBox(width: 8),
    //           Text("User $index"),
    //         ],
    //       ),
    //     );
     
    //   })
    // );
  
  }
}