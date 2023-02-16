import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/addCommaText.dart';
import 'package:paytel/widgets/utils/toPersianDate.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TransactionsPanel extends StatelessWidget {
  const TransactionsPanel({super.key , required this.scrollController , required this.panelController});

  final PanelController panelController;
  final ScrollController scrollController;

  Widget draggableButton() => GestureDetector(
          onTap: togglePanel,
          child : Center(
                      child:SizedBox(width:30 , height : 5 ,
                      child:Container(decoration:const BoxDecoration(color:Style.Colors.primary,borderRadius:  BorderRadius.all(Radius.circular(10))) )  ,)
                      ),
      ); 

     void togglePanel()=> panelController.isPanelOpen ? panelController.close() : panelController.open();

  @override
  Widget build(BuildContext context) {
    
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
      children: [
      // const Padding(padding:EdgeInsets.symmetric(horizontal : 20)),
      const  SizedBox(height: 10),
      draggableButton(),
      Expanded(
        child: 
         ListView(
            controller: scrollController,
            children:  [
                const SizedBox(height: 10,),
                Padding(padding:const  EdgeInsets.symmetric(horizontal : 10),
                child: Container(
                    height: 80,
                    decoration:const BoxDecoration(border:  Border(bottom: BorderSide( //                   <--- left side
                        color: Style.Colors.primary,
                        width: 1.0,
                         )
                       )   
                      ),
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.only(right: 3),
                                      decoration:  const BoxDecoration(shape: BoxShape.circle , color: Style.Colors.gray2),
                                      child:const   Icon( CupertinoIcons.shopping_cart,color: Style.Colors.gray1 , size:20 ,),
                                    ),
                          const SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:const  [
                               Text(" خرید از فروشگاه مارکت",style:  TextStyle(fontSize: 12)),
                               ToPersianDate(y:1395,m:11,d:10,style:  TextStyle(color: Style.Colors.gray1,fontSize: 8),)
                            ],
                          ),
                          Expanded(child: 
                          Container(alignment:Alignment.centerLeft ,
                               child: const AddComma(value:"4666300" ,textStyle: TextStyle(fontSize: 12))) 
                          )
                      ],
                    ),
                  ),
              ),
           Padding(padding:const  EdgeInsets.symmetric(horizontal : 10),
                child: Container(
                    height: 80,
                    decoration:const BoxDecoration(border:  Border(bottom: BorderSide( //                   <--- left side
                        color: Style.Colors.primary,
                        width: 1.0,
                         )
                       )   
                      ),
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.only(right: 3),
                                      decoration:  const BoxDecoration(shape: BoxShape.circle , color: Style.Colors.gray2),
                                      child:const   Icon( CupertinoIcons.shopping_cart,color: Style.Colors.gray1 , size:20 ,),
                                    ),
                          const SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:const  [
                               Text("خرید از فروشگاه مارکت",style:  TextStyle(fontSize: 12)),
                               ToPersianDate(y:1395,m:11,d:10,style:  TextStyle(color: Style.Colors.gray1,fontSize: 8),)
                            ],
                          ),
                          Expanded(child: 
                          Container(alignment:Alignment.centerLeft ,
                          child: Text('${addCommas(4666300)} ریال',style:const   TextStyle(fontSize: 12)),),)
                      ],
                    ),
                  ),
              ),
           Padding(padding:const  EdgeInsets.symmetric(horizontal : 10),
                child: Container(
                    height: 80,
                    decoration:const BoxDecoration(border:  Border(bottom: BorderSide( //                   <--- left side
                        color: Style.Colors.primary,
                        width: 1.0,
                         )
                       )   
                      ),
                    child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.only(right: 3),
                                      decoration:  const BoxDecoration(shape: BoxShape.circle , color: Style.Colors.gray2),
                                      child:const   Icon( CupertinoIcons.shopping_cart,color: Style.Colors.gray1 , size:20 ,),
                                    ),
                          const SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                               Text(" خرید از فروشگاه مارکت",style:  TextStyle(fontSize: 12)),
                               ToPersianDate(y:1395,m:11,d:10,style:  TextStyle(color: Style.Colors.gray1,fontSize: 8),)
                            ],
                          ),
                          Expanded(child: 
                          Container(alignment:Alignment.centerLeft ,
                          child: Text('${addCommas(4666300)} ریال',style:const   TextStyle(fontSize: 12)),),)
                      ],
                    ),
                  ),
              ),
          
              ],
             ) ,
      )
    ]
    )
    );
  }
}


