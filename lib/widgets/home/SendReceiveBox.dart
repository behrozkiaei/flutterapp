// ignore_for_file: unnecessary_const

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/scaner/enterCodeBottomSheet.dart';
import 'package:paytel/widgets/utils/enterAmountBottomSheet.dart';
import 'package:paytel/widgets/utils/mainPageIconButton.dart';
import 'package:persian_tools/persian_tools.dart';
class SendReceivePage extends StatelessWidget {
  const SendReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
  // final double  height =MediaQuery.of(context).size.height;
    return   Container(
      height: 100,
      decoration: const BoxDecoration(color:Style.Colors.primary) ,
      child: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all( 10),
          child: Column(
                  children:  [
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: 
                              const [
                                  Icon(EvaIcons.home , color: Style.Colors.background,),
                                  Text("خانه",style :TextStyle(color: Style.Colors.background , fontFamily: "IRANSansWeb")),
                                  Icon(EvaIcons.messageCircle, color: Style.Colors.background),
                            ]),
                             const SizedBox(height: 20,width: 30),
                             Text('${addCommas(4666300)} ریال', style: const TextStyle(color: Style.Colors.background , fontSize: 18 ,fontWeight: FontWeight.bold), ),
                             const  Text("موجودی", style: const TextStyle(color: Style.Colors.background , fontSize: 10 )),
                             const SizedBox(height: 30,width: 15),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:  [
                              InkWell(
                                onTap: (){

                                        EnterAmountBottomSheet.show(context, (result) => null, "");
                                      
                                  
                                  },
                                child:
                                const MainPageIcons(
                                      iconSize:  40, 
                                      iconColor:Style.Colors.primary,
                                      icon: CupertinoIcons.add, 
                                      iconBackgroundColor:Style.Colors.background,
                                      text:"افزایش موجودی", 
                                      textSize:10, 
                                      textColor: Style.Colors.background
                                    ),
                              ),
                                 
                                InkWell(
                                onTap: (){
                                        EnterAmountBottomSheet.show(context, (result) => null, "");
                                
                                    
                                  },
                                  
                                child:const  MainPageIcons(
                                    iconSize:  40, 
                                    iconColor:Style.Colors.primary,
                                    icon: CupertinoIcons.arrow_up, 
                                    iconBackgroundColor:Style.Colors.background,
                                    text:"ارسال", 
                                    textSize:10, 
                                    textColor: Style.Colors.background
                                  ),
                                  ),
                                InkWell(
                                onTap: (){
                                      //  Navigator.pushNamed(context, "/");
                                  },
                                  
                                child:const   MainPageIcons(
                                    iconSize:  40, 
                                    iconColor:Style.Colors.primary,
                                    icon: CupertinoIcons.money_dollar, 
                                    iconBackgroundColor:Style.Colors.background,
                                    text:"دریافت", 
                                    textSize:10, 
                                    textColor: Style.Colors.background
                                  ),
                                ),
                              ],
                             )
                      ]
                )
              ),
            ),
          );
  }
}