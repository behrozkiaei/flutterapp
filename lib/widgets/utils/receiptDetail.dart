import 'package:flutter/material.dart';
import 'package:paytel/models/transaction/my-transactions.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/timeUtil.dart';
import 'package:paytel/widgets/utils/toPersianDate.dart';
import 'package:persian_tools/persian_tools.dart';

class ReceiptDetail extends StatelessWidget{
  const ReceiptDetail({super.key, required this.list});
  final List<Desc> list; 
  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty ? 
    ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            if(list.isEmpty){
              return const SizedBox(height: 0,);
            }
            final item = list[index];

            return  Container(
                  height: 40,
                   decoration:const BoxDecoration(border:  Border(bottom: BorderSide( //                   <--- left side
                        color: Style.Colors.gray2,
                        width: 1.0,
                         )
                       )  
                        
                      ),
                    child:item.key == 'زمان' ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: 
                      [Text(item.key!,style :ReceiptDescStyling.key),
                        Row(children: [
                              ToPersianDate(y: DateUtil.getYear(item.value!),m:DateUtil.getMonth(item.value!),d:DateUtil.getDay(item.value!),style:  const TextStyle(color: Style.Colors.gray1,fontSize: 12),),
                              Text( DateUtil.getTime(item.value!),style:  const TextStyle(color: Style.Colors.gray1,fontSize: 12),),]),
                      ]):item.key == 'مبلغ' ?
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  
                        [Text(item.key!,style :ReceiptDescStyling.key),
                        Text('${addCommas(item.value!)} ریال',style: ReceiptDescStyling.value) 
                      ]):Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  
                        [
                        Text(item.key!,style :ReceiptDescStyling.key),
                        Text(item.value!,style: ReceiptDescStyling.value) ,
                      ],),     
                  );
          },
        ):const SizedBox.shrink();
  }
}

class ReceiptDescStyling {
  
  const ReceiptDescStyling();

  static const  TextStyle key =   TextStyle(
                              color: Style.Colors.gray1,
                              fontSize: 12,
                              fontFamily: "IRANSansWeb"
                            );
static const  TextStyle value =   TextStyle(
                              fontSize: 12,
                            );
                              
}