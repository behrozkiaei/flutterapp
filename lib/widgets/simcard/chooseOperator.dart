import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paytel/style/theme.dart' as Style;


class ChooseOperatorBottomSheet {
  static void show(BuildContext context,Function(String result) callback) {
  //  String? Code;

  void _registerOperator(String operator) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("operator", operator);

  }

    showModalBottomSheet(context: context,
      builder: (BuildContext context) {
        return
        Container(
          height: 300,
          child:   
          Padding(padding: EdgeInsets.all(10),
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            const SizedBox(height: 10,),
            const Text("اپراتور", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            const Text("درصورت ترابرد، اپراتور خود را انتخاب کنید", style: TextStyle(fontSize: 14.0,color: Style.Colors.gray1)),
            const SizedBox(height: 10,),

            InkWell(
              onTap: (){
                _registerOperator("hamrah");
                Navigator.pop(context, "hamrah");
              },
              child :
              Row(
                mainAxisAlignment:  MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                    
                        SizedBox(width: 60,height: 60,child: 
                            CircleAvatar(
                                backgroundColor: Style.Colors.primary,
                                foregroundColor: Style.Colors.primary, 
                                radius: 50.0,
                                backgroundImage:  AssetImage('assets/icons/hamrah.png'),
                                ),
                        ), SizedBox(width: 10),
                        Text("همراه اول"),
                ],
              )
            ),          const SizedBox(height: 10),

              InkWell(
              onTap: (){
                _registerOperator("irancel");
                Navigator.pop(context, "irancel");
              },
              child :
              Row(
                mainAxisAlignment:  MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                    
                        SizedBox(width: 60,height: 60,child: 
                            CircleAvatar(
                                backgroundColor: Style.Colors.primary,
                                foregroundColor: Style.Colors.primary, 
                                radius: 50.0,
                                backgroundImage:  AssetImage('assets/icons/irancel.png'),
                                ),
                        ),SizedBox(width: 10),
                        Text("ایرانسل"),
                ],
              ),

            ),
            const SizedBox(height: 10),
              InkWell(
              onTap: (){
                _registerOperator("rightel");
                Navigator.pop(context, "rightel");
              },
              child :
              Row(
                mainAxisAlignment:  MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                    
                        SizedBox(width: 60,height: 60,child: 
                            CircleAvatar(
                                backgroundColor: Style.Colors.primary,
                                foregroundColor: Style.Colors.primary, 
                                radius: 50.0,
                                backgroundImage:  AssetImage('assets/icons/rightel.png'),
                                ),
                        ),SizedBox(width: 10), 
                        Text("رایتل"),
                ],
              )
              ),
          ],)
          ,)
        );
      }
    ).then((value) => callback(value));
  }
}