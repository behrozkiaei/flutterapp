import 'package:flutter/material.dart';

import 'package:paytel/style/theme.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/simcard/chooseChargeAmount.dart';
import 'package:paytel/widgets/utils/addCommaText.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
class IntertetPackages extends StatefulWidget {
  const IntertetPackages({super.key});

  @override
  State<IntertetPackages> createState() => _IntertetPackagesState();
}

class _IntertetPackagesState extends State<IntertetPackages> {
   int? isSelected;

  _changeState(index){
    setState(() {
      isSelected = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child:
        SizedBox(height: double.infinity,
        child: 
         Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                  const SizedBox(height:30), 
                   SizedBox( 
                    width: width,
                    height: 30,
                    child :ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(20, (index) {
                        return  Container(
                                        margin:const EdgeInsets.symmetric(horizontal: 4),
                                        height: 30,
                                        width: 70,
                                        child: ElevatedButton(
                                            style:  StyledElevatedButton.buttonTinyStyle(false),
                                            child: Text("50000", style: ButtonStyleCustom.textStyle(false)),
                                            onPressed: () { _changeState(2);},
                                ),
                              );
                        }),
                      ),
                    ),
                   const SizedBox(height: 10,),
                    Expanded(
                      child: 
                      ListView(
                        scrollDirection: Axis.vertical,
                        physics:  const BouncingScrollPhysics(),
                        children: List.generate(20, (index) {
                        return Padding(padding:const  EdgeInsets.symmetric(vertical: 5),
                          
                          child: Row(
                            mainAxisAlignment:  MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Container(
                                  width: 50,
                                  height: 60,
                                  decoration: const BoxDecoration( shape: BoxShape.circle,    
                                      color: Style.Colors.gray2                                      
                                    ),
                                  child:Image.asset("assets/icons/internet.png",scale:10,), 
                                ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:const [
                                  Text("یکروزه 1.5 گیگابایت"),
                                  Text("مبلغ + مالیات", style: TextStyle(fontSize: 14.0,color: Style.Colors.gray1)),

                              ],),
                              Expanded(
                                child:Container(
                                  margin: EdgeInsets.only(left: 10),
                                    alignment: Alignment.centerLeft,
                                    child: 
                                      const Icon(Icons.arrow_forward),
                                    ),
                                  ), 
                            ],
                          ),
                        );
                      }),
                   ),
                ),
              ],
            )
            ,)
            ),
          );
      }
}