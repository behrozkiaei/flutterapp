import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/services/buyInternet/buy-internet.bloc.dart';
import 'package:paytel/blocs/services/buyInternet/buy-internet.event.dart';
import 'package:paytel/blocs/services/buyInternet/buy-internet.state.dart';
import 'package:paytel/models/internet-packages-model.model.dart';
import 'package:paytel/models/transaction/my-transactions.dart';
import 'package:paytel/repositories/transactions.repository.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/avatar-title-sub.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/receiptDetail.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
class InternetPreReceipt extends StatefulWidget {
  final Value product ;
  const InternetPreReceipt({super.key, required this.product});

  @override
  State<InternetPreReceipt> createState() => _InternetPreReceiptState();
}

class _InternetPreReceiptState extends State<InternetPreReceipt> {
  String? mobile;
  List<Desc> descList=[]; 
  bool loading = false;
  final transactionRepo = TransactionRepo();
 

  @override
    void initState() {
      super.initState();
        _getStoredValue();
      
     }
  _getStoredValue() async {
      final prefs = await SharedPreferences.getInstance();
      final String _mobile = prefs.getString("mobile") ?? "";
      setState(() {
      mobile = _mobile;
        descList =   [
          Desc(id: " ", key: "شماره موبایل", value: mobile?? "", orderId: " "),
          Desc(id: " ", key: "نام بسته", value: widget.product.name!, orderId: " ")
          ];
      });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BuyInternetBloc, BuyInternetState>(
          listener: (context, state) {
            if (state is BuyInternetLoading) {
             setState(() {
               loading=true;
             });
            }
          if (state is BuyInternetFailure) {
             setState(() {
               loading=false;
             });
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                  content: Text(state.error.isNotEmpty ? state.error :"خرید  ناموفق",style :const TextStyle(color: Style.Colors.gray2)),
                  backgroundColor: Style.Colors.fail,
                ),
              );
            }
            if(state is BuyInternetSuccess){
              ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                  content: Text("خرید  موفق",style : TextStyle(color: Style.Colors.gray2)),
                  backgroundColor: Style.Colors.fail,
                ),
              );
              setState(() {
               loading=false;
             });
              Navigator.pushReplacementNamed(
                                    context,
                                    "/home",
                                   
                                    );
            }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
            leading:  IconButton(
            icon: const Icon(Icons.arrow_back , color: Style.Colors.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      body:SafeArea(
        child:Container(
          padding:const  EdgeInsets.only(bottom: 16,right: 16,left: 16),
          child: Column(
            children: <Widget>[

            const SizedBox(height: 20.0),
                      AvatarTitleSub(avatarUrl: widget.product.valueOperator == "MTN" ? const  AssetImage('assets/icons/MTN.png') : 
                                     widget.product.valueOperator == "MCI" ?  const  AssetImage('assets/icons/MCI.png') :
                                     widget.product.valueOperator == "RTL" ?const  AssetImage('assets/icons/MCI.png'): 
                                     const AssetImage('assets/icons/user.png')  ,title:widget.product.valueOperator == "MTN" ? "ایرانسل" :widget.product.valueOperator == "MCI" ? "همراه اول" :widget.product.valueOperator == "RTL" ?"رایتل" : "-" , subTitle: '${addCommas(widget.product.amountRial.toString())} ریال '),
                       const SizedBox(height: 20.0),
                       SizedBox(
                        height: descList.length*40,
                        child: ReceiptDetail(  
                          list:  descList
                        ),
                       ),
                       
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  
                 StyledElevatedButton(
                            width:double.maxFinite ,
                            icon : Icons.check_box  ,
                            text : "تایید خرید" ,
                            isLoading: loading,
                            disabled: loading,
                            textColor: Style.Colors.white,
                            onPressed:  () { 
                         
                                  BlocProvider.of<BuyInternetBloc>(context).add(BuyInternetButtonPressed(
                                        productId: widget.product.productId!, 
                                        InternetPayloadOperator : widget.product.valueOperator!,
                                        mobile : mobile!,
                                        simType: widget.product.simType!,
                                        fromWallet:true,
                                       ));

                          },  
                        )
                  ],
                )
              )
            ],
          ),
        ),
      ) ,
      ) ,
    );
  }
}

class ButtonStyleCustom{
  bool? isActive;

 static TextStyle textStyle(isActive){
  return  TextStyle(color: isActive ? Style.Colors.white: Style.Colors.gray1 , fontSize: 12);
 }
}