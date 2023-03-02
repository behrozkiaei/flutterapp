import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paytel/style/theme.dart' as Style;


class ChooseSimTypeBottomSheet {

  
  static  show(BuildContext context) async{

      void _registerSimType(String sim_type) async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("sim_type", sim_type);

      }

      return await showModalBottomSheet(context: context,
          builder: (_) {
            return
            SizedBox(
              height: 200,
              child:   
              Padding(padding: const EdgeInsets.all(10),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const SizedBox(height: 10,),
                const Text("انتخاب نوع سیم کارت", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                const Text("نوع سیم کارت خود را انتخاب کنید", style: TextStyle(fontSize: 14.0,color: Style.Colors.gray1)),
                const SizedBox(height: 20,),

                InkWell(
                  onTap: (){
                    _registerSimType("permanent");
                    Navigator.pop(context, "permanent");
                  },
                  child :
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                        
                            SizedBox(width: 10),
                            Text("سیم کارت دائمی",style:  TextStyle(fontSize: 16)),
                    ],
                  )
                ),          const SizedBox(height: 30),

                  InkWell(
                  onTap: (){
                    _registerSimType("credit");
                    Navigator.pop(context, "credit");
                  },
                  child :
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                            SizedBox(width: 10),
                            Text("سیم کارت اعتباری",style:  TextStyle(fontSize: 16)),
                    ],
                  ),

                ),
              ],)
              ,)
            );
          }
        );
      }
}