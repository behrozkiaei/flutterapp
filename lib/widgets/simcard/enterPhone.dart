import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytel/presentations/auth/otpWidget.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/simcard/chooseOperator.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EnterPhoneSim extends StatefulWidget {
  const EnterPhoneSim({super.key});

  @override
  State<EnterPhoneSim> createState() => _EnterPhoneSimState();
}

class _EnterPhoneSimState extends State<EnterPhoneSim> {

  // final _storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  String? _phoneNumber;
   
    @override
    void initState() {
      super.initState();
    }

  
  void _addPhoneInStorage(String mobile) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("mobile", mobile);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body:SafeArea(child:  Container(
              height: double.infinity,
              child: 
                Padding(
                  padding:const  EdgeInsets.all(10),
                  child : Form(
                    key: _formKey,
                    child: 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        const Text("شماره سیم کارت اعتباری را وارد کنید", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        InputDecorationStyle(
                          label: "شماره تلفن",
                          icon:  CupertinoIcons.person,
                          onChange: (value){

                          },
                          onSave: (value){
                            (value) { 
                              _phoneNumber = convertArToEn(value!);
                              _addPhoneInStorage(value);
                            };
                          },
                          type: "phone",
                          textInputType : TextInputType.number,
                         
                        ),
                      
                        const SizedBox(height: 15),
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                           StyledElevatedButton(
                            width:double.maxFinite ,
                            icon : Icons.check_box  ,
                            text : "ادامه" ,
                            textColor: Style.Colors.white,
                            onPressed:  () async  { 
                              if (_formKey.currentState!.validate()) {
                                 ChooseOperatorBottomSheet.show(context,(value){
                                      if(value !=null ){
                                                Navigator.pushNamed(context, "/charge-amount");
                                      }
                                    });
                              }
                          },  
                        )
                        ],))
                       
                        
                      ],
                    )
                  )
                )
            ,) ,)
          );
  }
}