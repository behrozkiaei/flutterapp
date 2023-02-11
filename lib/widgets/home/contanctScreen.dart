import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytel/widgets/cotact/lastPaidUsersListView.dart';
import 'package:paytel/widgets/cotact/phoneContacts.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
      // ignore: avoid_unnecessary_containers
      return SafeArea(child: SizedBox(

        child :Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  const[
               SizedBox(height: 20),
               SizedBox(height:120,width: 400,child:   LastPaid()),
               SizedBox(height: 5),
               Expanded(child:  MyContacts()),
            ],
      ),
    )
    );
  }
}