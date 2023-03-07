import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paytel/style/theme.dart' as Style;


class ConfirmBottomSheet {
  static  show(BuildContext context) async{

      void _registerOperator(String operator) async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("operator", operator);

      }

      return await showModalBottomSheet(context: context,
          builder: (_) {
            return
            SizedBox(
              height: 230,
              child:   
              Padding(padding: const EdgeInsets.all(10),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                const SizedBox(height: 10,),
                const Text("تایید", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                const Text("آیا از انتخاب خود مطمئن هستید؟", style: TextStyle(fontSize: 14.0,color: Style.Colors.gray1)),
                const SizedBox(height: 10,),

                InkWell(
                  onTap: (){
                    Navigator.pop(context, true);
                  },
                  child :
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                        
                            SizedBox(width: 30,height: 50,child: 
                                CircleAvatar(
                                    radius: 50.0,
                                    child: Icon(Icons.check),
                                    ),
                            ), SizedBox(width: 10),
                            Text("بله"),
                    ],
                  )
                ),          const SizedBox(height: 10),

                  InkWell(
                  onTap: (){
                    Navigator.pop(context, false);
                  },
                  child :
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                        
                            SizedBox(width: 30,height: 50,child: 
                                CircleAvatar(
                                    radius: 50.0,
                                    child: Icon(Icons.cancel),
                                    ),
                            ),SizedBox(width: 10),
                            Text("خیر"),
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