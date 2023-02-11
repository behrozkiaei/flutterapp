import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:paytell/widgets/utils/elevateButton.style.dart';
import 'package:paytell/widgets/utils/inputDecoration.dart';
import 'package:paytell/style/theme.dart' as Style;
import 'package:persian_tools/persian_tools.dart';

class EnterAmountBottomSheet {
  static void show(BuildContext context,Function(String result) callback ,userCode) {
   String? amount;
   showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 700,
          decoration:const  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(padding: const EdgeInsets.all(10),
           child :Column(
            children: <Widget>[
              const CircleAvatar(
                    radius: 50.0,
                    backgroundImage:  AssetImage(
                      'assets/icons/user.png',
                    ) ,
            ),
              const Text("نامشخص"),
              const SizedBox(height: 20,),
              InputDecorationStyle(
                icon: Icons.money,
                type: "money",
                label: "مبلغ به ریال",
                onSave : (value){},
                validate: (value){
                  if (!RegExp(r'^\d{9}$').hasMatch(value!)) {
                              return 'شماراه وارد شده صحیح نیست';
                            }
                            return null;
                },
                initialValue: "",
                autofocus: true,
                onChange: (value){
                  amount = value;
                  return addCommas(value);
                },
              ),
              Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: 
                    LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        final parentWidth = constraints.maxWidth;
                        return StyledElevatedButton(
                            width:parentWidth ,
                            icon : Icons.check_box ,
                            text :"تایید",
                            textColor: Style.Colors.white,
                            onPressed: () async {
                                if(amount != null ){
                                  Navigator.pop(context, amount);
                                }else{
                                  Navigator.pop(context, null);
                                }
                              }
                            );
                          }
                        )
                       )
                  ],
            ),
          )
        );
      },
    ).then((value) => callback(value));
  }
}