import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.bloc.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.state.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/addCommaText.dart';
import 'package:paytel/widgets/utils/receiptDetail.dart';
class Receipt extends StatelessWidget {
  const Receipt({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea (child: 
    Container(
      child:Padding(padding:const EdgeInsets.all(10),
          child: 
           BlocBuilder<MyTransactionsBloc, MyTransactionsState>(
        builder: (context, state) {
          return 
          (state is MyTransactionsSuccess  ) ?
          (state.myTransactions.isNotEmpty) ?
                       
          Column(children: [
              const SizedBox(height: 10,),
              Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.only(right: 3),
                        decoration:  const BoxDecoration(shape: BoxShape.circle , color: Style.Colors.gray2),
                        child:const Icon( CupertinoIcons.person,color: Style.Colors.gray1 , size:20 ,)
                  ),
              const SizedBox(height: 10,),
              Text(state.myTransactions[state.index].title,style:const  TextStyle(fontSize: 12)),
              const SizedBox(height: 10,),
               Text(state.myTransactions[state.index].subTitle,style:const  TextStyle(color: Style.Colors.gray1,fontSize: 8)),
              const SizedBox(height: 10,),
              AddComma(value:state.myTransactions[state.index].amount.toString() ,textStyle:const  TextStyle(fontSize: 18)),
              const SizedBox(height: 10,),
               Container(
                        width: 100,
                        height: 40,
                        padding: const EdgeInsets.only(right: 3),
                        decoration:BoxDecoration(borderRadius: BorderRadius.circular(10.0)  , 
                        color:state.myTransactions[state.index].isPaid  ? Style.Colors.success :Style.Colors.fail ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                          Icon( state.myTransactions[state.index].isPaid  ? CupertinoIcons.checkmark_circle_fill : Icons.cancel  ,color: Style.Colors.gray2 , size:20 ),
                          const SizedBox(width: 5,),
                          Text(state.myTransactions[state.index].isPaid  ? 'موفق' : 'ناموفق' , style: const TextStyle(fontSize: 10,color: Style.Colors.gray2),)
                        ]),
                        
                  ),
                  ReceiptDetail(list: state.myTransactions[state.index].desc)
          ])
          :const Center(child :Text("تراکنشی وجود ندارد"))
          :const Center(child : SpinKitRotatingCircle(
                color:Style.Colors.primary,
                size: 50.0,
            ),
          );
        }
        ),
     ),
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