import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/services/buyCharge/buy-charge.bloc.dart';
import 'package:paytel/blocs/services/buyCharge/buy-charge.event.dart';
import 'package:paytel/blocs/services/buyCharge/buy-charge.state.dart';
import 'package:paytel/blocs/services/buyInternet/buy-internet.bloc.dart';
import 'package:paytel/repositories/transactions.repository.dart';
import 'package:paytel/widgets/utils/addCommaText.dart';
import 'package:paytel/widgets/utils/avatar-title-sub.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';

import 'package:paytel/style/theme.dart' as Style;
import 'package:persian_tools/persian_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ChooseAmountCharge extends StatefulWidget {
  const ChooseAmountCharge({super.key});
  @override
  State<ChooseAmountCharge> createState() => _ChooseAmountChargeState();
}

class _ChooseAmountChargeState extends State<ChooseAmountCharge> {
   bool loading = false;
   int? isSelected;
  _changeState(index){
    setState(() {
      isSelected = index;
    });

  }
  
  String? operator;
  String? mobile;
  List<String> amounts = ['20000','50000','100000','200000','500000','1000000'] ;
  _getStoredValue() async {
      final prefs = await SharedPreferences.getInstance();
      final String _operator = prefs.getString("operator") ?? "";
      final String _mobile = prefs.getString("mobile") ?? "";
      setState(() { operator = _operator ;mobile = _mobile; });     
  }
  @override
    void initState() {
      super.initState();
      _getStoredValue();
    }

 final transactionRepo = TransactionRepo();
  @override
  Widget build(BuildContext context) {
    return BlocListener<BuyChargeBloc, BuyChargeState>(
          listener: (context, state) {
           if (state is BuyChargeLoading) {
              setState(() {
                loading =true;
              });
            } 
          if (state is BuyChargeFailure) {
             setState(() {
                loading =false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(
                  content: Text(state.error.isNotEmpty ? state.error :"خرید  ناموفق",style :const TextStyle(color: Style.Colors.gray2)),
                  backgroundColor: Style.Colors.fail,
                ),
              );
            }
            if(state is BuyChargeSuccess){
               setState(() {
                loading =false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                  content: Text("خرید  موفق",style : TextStyle(color: Style.Colors.gray2)),
                  backgroundColor: Style.Colors.fail,
                ),
              );
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
                      AvatarTitleSub(avatarUrl: operator == "MTN" ? const  AssetImage('assets/icons/MTN.png') : 
                                     operator == "MCI" ?  const  AssetImage('assets/icons/MCI.png') :
                                     operator == "RTL" ?const  AssetImage('assets/icons/MCI.png'): 
                                     const AssetImage('assets/icons/user.png')  ,title:operator == "MTN" ? "ایرانسل" :operator == "MCI" ? "همراه اول" :operator == "RTL" ?"رایتل" : "-" , subTitle: '${addCommas("540000")} ریال '),
            const SizedBox(height: 20.0),
                  Text(mobile??"", style:const TextStyle(fontSize: 14.0,color: Style.Colors.gray1)),

            Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: amounts.asMap().entries.map((entry) {
                      int index = entry.key;
                      String number = entry.value;

                      return SizedBox(
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        child: ElevatedButton(
                      style:  StyledElevatedButton.buttonTinyStyle(isSelected == index),
                      child: AddComma(value: number, textStyle: ButtonStyleCustom.textStyle(isSelected == index)),
                      onPressed: () { _changeState(index);},
                    ),
        
                        
                      );
                    }).toList(),
                  ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  
                 StyledElevatedButton(
                            isLoading: loading,
                            disabled: loading,
                            width:double.maxFinite ,
                            icon : Icons.check_box  ,
                            text : "ادامه" ,
                            textColor: Style.Colors.white,
                            onPressed:  () { 
                              if(isSelected != null && isSelected != null && operator!=null){
                                  BlocProvider.of<BuyChargeBloc>(context).add(BuyChargeButtonPressed( chargeType:"",
                                       chargePayloadOperator:operator!,
                                        mobile:mobile!,
                                        amount:amounts[isSelected!],
                                        fromWallet:true));

                              }
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
  return  TextStyle(color: isActive ? Style.Colors.white: Style.Colors.gray1 , fontSize: 12 ,fontFamily: "IRANSansWeb");
 }
}