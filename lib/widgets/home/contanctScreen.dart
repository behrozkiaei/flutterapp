import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/user/mutual-friends/mutual-friends.bloc.dart';
import 'package:paytel/widgets/cotact/lastPaidUsersListView.dart';
import 'package:paytel/widgets/cotact/phoneContacts.dart';

import '../../repositories/auth.repository.dart';
import 'package:paytel/style/theme.dart' as Style;
class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}
  final userRepository = UserRepository();
class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
      // ignore: avoid_unnecessary_containers
      return MultiBlocProvider(
      providers: [
          BlocProvider<MutualFriendsBloc>(create: (BuildContext context) => MutualFriendsBloc(userRepository: userRepository),),
      ],child : SafeArea(child: SizedBox(

        child :Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              const SizedBox(height: 10),
              Container(width : width , padding: const EdgeInsets.only(right: 10),height: 30,child: const Text("مخاطبین اخیر",style:TextStyle(color: Style.Colors.primary) ,),),
              const SizedBox(height:120,width: 400,child:   LastPaid()),
              const SizedBox(height: 5),
              Container(width : width , padding: const EdgeInsets.only(right: 10),height: 30,child: const Text("لیست مخاطبان مشترک",style:TextStyle(color: Style.Colors.primary) ,),),
              const Expanded(child:  MyContacts()),
            ],
      ),
    ),
    ),
    );
  }
}