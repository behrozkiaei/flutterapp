import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paytel/style/theme.dart' as Style;


class ChooseOperatorBottomSheet {

  
  static  show(BuildContext context) async{

      void _registerOperator(String operator) async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("operator", operator);

      }

      return await showModalBottomSheet(context: context,
          builder: (_) {
            return
            SizedBox(
              height: 300,
              child:   
              Padding(padding: const EdgeInsets.all(10),
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
                    _registerOperator("MCI");
                    Navigator.pop(context, "MCI");
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
                                    backgroundImage:  AssetImage('assets/icons/MCI.png'),
                                    ),
                            ), SizedBox(width: 10),
                            Text("همراه اول"),
                    ],
                  )
                ),          const SizedBox(height: 10),

                  InkWell(
                  onTap: (){
                    _registerOperator("MTN");
                    Navigator.pop(context, "MTN");
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
                                    backgroundImage:  AssetImage('assets/icons/MTN.png'),
                                    ),
                            ),SizedBox(width: 10),
                            Text("ایرانسل"),
                    ],
                  ),

                ),
                const SizedBox(height: 10),
                  InkWell(
                  onTap: (){
                    _registerOperator("RTL");
                    Navigator.pop(context, "RTL");
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
                                    backgroundImage:  AssetImage('assets/icons/RTL.png'),
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
        );
      }
}