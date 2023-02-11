import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytell/style/theme.dart' as Style;
import 'package:paytell/widgets/home/contanctScreen.dart';
import 'package:paytell/widgets/home/homeScreen.dart';
import 'package:paytell/widgets/home/profile.dart';
import 'package:paytell/widgets/scaner/scanner.dart';
import 'package:paytell/widgets/scaner/transferPage.dart';
import 'package:paytell/widgets/home/tansactionScreen.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedItem = 1;
  final List<Widget> pages  = [
     const HomeScreen(),
     Transfer(),
     const Transactions(),
     const Contacts(),
     const Profile(),
  ];
  void changeSelectedItem(int item){
    setState(() {selectedItem = item;});
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
          BottomNavigationBarItem(icon:Icon( CupertinoIcons.arrow_up_arrow_down_circle ) , label:"انتقال"),
          BottomNavigationBarItem(icon:Icon(EvaIcons.fileTextOutline ) , label:"تراکنش‌ها"),
          BottomNavigationBarItem(icon:Icon(EvaIcons.phone ) , label:"کاربران"),
          BottomNavigationBarItem(icon:Icon(EvaIcons.person ) , label:"پروفایل"),
        ]),
    );
  }
}