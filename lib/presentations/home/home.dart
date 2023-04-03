import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/app-state/app-state.bloc.dart';
import 'package:paytel/blocs/app-state/app-state.state.dart';
import 'package:paytel/blocs/transaction/increase-wallet/increase-wallet.bloc.dart';
import 'package:paytel/repositories/transactions.repository.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/home/contanctScreen.dart';
import 'package:paytel/widgets/home/homeScreen.dart';
import 'package:paytel/widgets/home/profile.dart';
import 'package:paytel/widgets/home/tansactionScreen.dart';
import 'package:paytel/widgets/scaner/transferPage.dart';

import '../../blocs/app-state/app-state.event.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedItem = 0;
  final transactionRepo = TransactionRepo();

  final List<Widget> pages  = [
     const HomeScreen(),
     const Transfer(),
     const Transactions(),
     const Contacts(),
      Profile(),
  ];
  void changeSelectedItem(int item){
    BlocProvider.of<AppStateBloc>(context).add(PageIndex(pageIndex: item));
    // setState(() {selectedItem = item;});
  }
  @override
  initState(){

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
          SystemNavigator.pop();
        return true;
      },child : MultiBlocProvider(
      providers: [
          BlocProvider<IncreaseWalletBloc>(create: (BuildContext context) => IncreaseWalletBloc(transactionRepository: transactionRepo),),
      ], 
      child: MultiBlocListener(listeners:[
      BlocListener<AppStateBloc, AppStateState>(
          listener: (context, state) {
            if(state != null ){
             setState(() {selectedItem = state.tabIndex ?? 0; });
            }
          }
       )
      ],
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: pages[selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        onTap:changeSelectedItem ,
        currentIndex: selectedItem,
        elevation: 10,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Style.Colors.primary,
        unselectedItemColor: Style.Colors.secondary,
        items:const [
          BottomNavigationBarItem(icon:Icon(EvaIcons.home ) , label:"اصلی"),
          BottomNavigationBarItem(icon:Icon(CupertinoIcons.arrow_up_arrow_down_circle ) , label:"انتقال"),
          BottomNavigationBarItem(icon:Icon(EvaIcons.fileTextOutline ) , label:"تراکنش‌ها"),
          BottomNavigationBarItem(icon:Icon(EvaIcons.phone ) , label:"کاربران"),
          BottomNavigationBarItem(icon:Icon(EvaIcons.person ) , label:"پروفایل"),
        ]),
      ),
      ),
      ),
    );
  }
}