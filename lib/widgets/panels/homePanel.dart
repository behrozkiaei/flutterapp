import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/bill/chooseBilBootomSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/enums.dart';
class HomePanelWidget extends StatelessWidget {
  final ScrollController scrollController;
  const HomePanelWidget({super.key , required this.scrollController});
 void _setMode(String mode) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("type", mode ); 

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment:  MainAxisAlignment.start,
        children:  [
         const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:  [
              InkWell(
                onTap: () async {
                          _setMode("charge");
                          Navigator.pushNamed(context, "/sim-enter-phone");
                },
                child: 
                  Container(
                        width: 80,
                        height: 80,
                        decoration:  BoxDecoration(
                            // color:Style.Colors.background ,
                            borderRadius:BorderRadius.circular(10.0) , 
                            border:  Border.all(color: Style.Colors.primary)
                          ),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/icons/sim.png",scale: 10,),
                            const Text("خرید شارژ" ,style:Style.TextStyling.primaryTextStyle)
                        ],) 
                  ),
              ),
              InkWell(
                onTap: () async {
                          // _setMode(Mode.internet.toString());
                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString("type", 'internet' ); 
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamed(context, "/sim-enter-phone");
                },
                child:
                Container(
                  width: 80,
                  height: 80,
                  decoration:  BoxDecoration(
                      borderRadius:BorderRadius.circular(10.0) , 
                      border:  Border.all(color: Style.Colors.primary)
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                            Image.asset("assets/icons/internet.png",scale:10,),
                            const Text("خرید اینترنت" ,style:Style.TextStyling.primaryTextStyle)
                        ],) 
                  ),
              ),
              InkWell(
              onTap: () {                         
                 _setMode(Mode.bill.toString());
                ChooseBillType.show(context,(value){
                          if(value !=null && value == BillType.mobile.toString()){
                            Navigator.pushNamed(context, "/sim-enter-phone");
                          }
                            if(value !=null && value == BillType.service.toString()){
                              Navigator.pushNamed(context, "/bill-enter-id");
                          }
                });
              },
              child:
              Container(
                width: 80,
                height: 80,
                decoration:  BoxDecoration(
                    borderRadius:BorderRadius.circular(10.0) , 
                    border:  Border.all(color: Style.Colors.primary)
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                          Image.asset("assets/icons/bill.png",scale: 10,),
                          const Text("پرداخت قبوض" ,style:Style.TextStyling.primaryTextStyle)
                      ],) 
              ),
              )
            ]
            )
        ]
      ),
    );
  }
}