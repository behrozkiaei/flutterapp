import 'package:flutter/material.dart';
import 'package:paytel/widgets/utils/addCommaText.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';

import 'package:paytel/style/theme.dart' as Style;
import 'package:shared_preferences/shared_preferences.dart';
class ChooseAmountCharge extends StatefulWidget {
  const ChooseAmountCharge({super.key});

  @override
  State<ChooseAmountCharge> createState() => _ChooseAmountChargeState();
}

class _ChooseAmountChargeState extends State<ChooseAmountCharge> {
   int? isSelected;
  _changeState(index){
    setState(() {
      isSelected = index;
    });

  }
  
  String? operator;
  String? mobile;
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child: 
      
      Container(
          padding:const  EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[

                const SizedBox(height: 20.0),
        
                   CircleAvatar(
                    backgroundColor: Style.Colors.primary,
                    foregroundColor: Style.Colors.primary,
                    
                    radius: 50.0,
                    backgroundImage: operator == "irancel" ?const  AssetImage('assets/icons/irancel.png') : 
                                     operator == "hamrah" ?  const  AssetImage('assets/icons/hamrah.png') :
                                     operator == "rightel" ?const  AssetImage('assets/icons/hamrah.png'): 
                                     const AssetImage('assets/icons/user.png')   ,
                    ),
                
            const SizedBox(height: 20.0),
            const Text("ایرانسل", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            Text(mobile ?? '', style:const TextStyle(fontSize: 14.0,color: Style.Colors.gray1)),
            const SizedBox(height: 5.0),
            const  AddComma(value: "540000", textStyle: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold) ),
            const Text("مبلغ شارژ + مالیات", style: TextStyle(fontSize: 14.0,color: Style.Colors.gray1)),
            const SizedBox(height: 20.0),
            
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: StyledElevatedButton.buttonTinyStyle(isSelected == 0),
                      child: AddComma(value: "1000", textStyle: ButtonStyleCustom.textStyle(isSelected == 0)),
                      onPressed: () { _changeState(0);},
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      style:  StyledElevatedButton.buttonTinyStyle(isSelected == 1),
                      child: AddComma(value: "2000", textStyle: ButtonStyleCustom.textStyle(isSelected == 1)),
                      onPressed: () { _changeState(1);},
                    ),
                  ),
                   const SizedBox(width: 8.0),
                    Expanded(
                    child: ElevatedButton(
                      style:  StyledElevatedButton.buttonTinyStyle(isSelected == 2),
                      child: AddComma(value: "50000", textStyle: ButtonStyleCustom.textStyle(isSelected == 2)),
                      onPressed: () { _changeState(2);},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style:  StyledElevatedButton.buttonTinyStyle(isSelected == 3),
                                           child: AddComma(value: "100000", textStyle: ButtonStyleCustom.textStyle(isSelected == 3)),
                      onPressed: () { _changeState(3);},
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      style: StyledElevatedButton.buttonTinyStyle(isSelected == 4),
                      child: AddComma(value: "200000", textStyle: ButtonStyleCustom.textStyle(isSelected == 4)),
                      onPressed: () { _changeState(4);},
                    ),
                  ),
                   const SizedBox(width: 8.0),
                  Expanded(
                    child: ElevatedButton(
                      style: StyledElevatedButton.buttonTinyStyle(isSelected == 5),
                       child: AddComma(value: "500000", textStyle: ButtonStyleCustom.textStyle(isSelected == 5)),
                      onPressed: () { 
                        _changeState(5);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

               StyledElevatedButton(
                            width:double.maxFinite ,
                            icon : Icons.check_box  ,
                            text : "ادامه" ,
                            textColor: Style.Colors.white,
                            onPressed:  () { 
                              if(isSelected != null){

                              Navigator.pushNamed(context, "/home");  
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
    );
  }
}

class ButtonStyleCustom{
  bool? isActive;
  
 

 static TextStyle textStyle(isActive){
  return  TextStyle(color: isActive ? Style.Colors.white: Style.Colors.gray1 , fontSize: 12);
 }
}