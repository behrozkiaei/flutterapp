import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:paytell/style/theme.dart' as Style;
import 'package:paytell/widgets/utils/addCommaText.dart';
import 'package:paytell/widgets/utils/toPersianDate.dart';
import 'package:shamsi_date/shamsi_date.dart';
class Receipt extends StatelessWidget {
  const Receipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Padding(padding:const EdgeInsets.all(10),
          child: Column(children: [
              const SizedBox(height: 10,),
              Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.only(right: 3),
                        decoration:  const BoxDecoration(shape: BoxShape.circle , color: Style.Colors.gray2),
                        child:const Icon( CupertinoIcons.person,color: Style.Colors.gray1 , size:20 ,)
                  ),
              const SizedBox(height: 10,),
              const Text(" خرید از فروشگاه مارکت",style:  TextStyle(fontSize: 12)),
              const SizedBox(height: 10,),
              const Text("6104-3374-9675-9422",style:  TextStyle(color: Style.Colors.gray1,fontSize: 8)),
              const SizedBox(height: 10,),
              const AddComma(value:"4666300" ,textStyle: TextStyle(fontSize: 18)),
              const SizedBox(height: 10,),
               Container(
                        width: 100,
                        height: 40,
                        padding: const EdgeInsets.only(right: 3),
                        decoration:BoxDecoration(borderRadius: BorderRadius.circular(10.0)  , color: Style.Colors.success),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                          Icon( CupertinoIcons.checkmark_circle_fill ,color: Style.Colors.gray2 , size:20 ),
                          const SizedBox(width: 5,),
                          Text("انتقال موفق" , style: TextStyle(fontSize: 10,color: Style.Colors.gray2),)
                        ]),
                        
                  ),
                Container(
                  height: 40,
                   decoration:const BoxDecoration(border:  Border(bottom: BorderSide( //                   <--- left side
                        color: Style.Colors.gray2,
                        width: 1.0,
                         )
                       )  
                        
                      ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:const  [
                        Text("زمان",style :ReceiptDescStyling.key),
                        ToPersianDate(y:1395,m:11,d:10,style:ReceiptDescStyling.value ),
                      ]
                  ),
                )
                ,
                  Container(
                     height: 40,
                   decoration:const BoxDecoration(border:  Border(bottom: BorderSide( //                   <--- left side
                        color: Style.Colors.gray2,
                        width: 1.0,
                         )
                       )  
                        
                      ),
                      
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:const  [
                        Text("زمان",style :ReceiptDescStyling.key),
                        ToPersianDate(y:1395,m:11,d:10,style:  ReceiptDescStyling.value)
                      ]
                  ),
                ),
                   
                  Container(
                     height: 40,
                   decoration:const BoxDecoration(border:  Border(bottom: BorderSide( //                   <--- left side
                        color: Style.Colors.gray2,
                        width: 1.0,
                         )
                       )  
                        
                      ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:const  [
                        Text("انتقال دهنده",style :ReceiptDescStyling.key),
                        ToPersianDate(y:1395,m:11,d:10,style: ReceiptDescStyling.value)
                      ]
                  ),
                ),  
                 Container(
                   height: 40,
                   decoration:const BoxDecoration(border:  Border(bottom: BorderSide( //                   <--- left side
                        color: Style.Colors.gray2,
                        width: 1.0,
                         )
                       )  
                        
                      ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:const  [
                        Text("روش انتقال",style :ReceiptDescStyling.key,),
                        Text("کارت به کارت",style :ReceiptDescStyling.value)
                         ]
                  ),
                )
                ,
          ]),
        ),
    );
  }
}




class ReceiptDescStyling {
  
  const ReceiptDescStyling();

  static const  TextStyle key =   TextStyle(
                              color: Style.Colors.gray1,
                              fontSize: 9,
                              fontFamily: "IRANSansWeb"
                            );
static const  TextStyle value =   TextStyle(
                              fontSize: 9,
                            );
                              
}