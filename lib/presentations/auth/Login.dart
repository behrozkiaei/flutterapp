import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
class AppLogin extends StatefulWidget {
  const AppLogin({super.key});

  @override
  State<AppLogin> createState() => _AppLoginState();
}

class _AppLoginState extends State<AppLogin> {
  final _formKey = GlobalKey<FormState>();
String _inputText = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
 void _openFingerPrint(){
  Navigator.pushNamed(context, "/biometric");
 }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            body: Container(
              height: double.infinity,
              child: 
                Padding(
                  padding:const  EdgeInsets.all(10),
                  child : Form(
                    key: _formKey,
                    child: 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:  CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 100),
                         SizedBox(
                            height: 150,
                            width: double.infinity,
                            child:   Image.asset("assets/icons/logo/p-logo-primary.png",scale: 1,),

                          ),
                        const SizedBox(height: 100),
                        //  const Text("پسورد خود را وارد کنید"),
                         InputDecorationStyle(
                          label: "رمز عبور",
                          textInputType : TextInputType.text,
                          icon:  Icons.security,
                          onChange: (value){
                            setState(() {
                              _inputText=value;
                            });
                          },
                          onSave: (value){},
                          type: "text",
                          validate :(value){
                                if (value!.length < 6 ) {
                                      return 'Please enter some text';
                                    }
                              return null ;
                          }
                        ),
                        const SizedBox(height: 10),
                       StyledElevatedButton(
                            width:double.maxFinite ,
                            icon : Icons.check_box  ,
                            text : _inputText.isNotEmpty ? "ورود با رمز عبور" :"ورود با اثر انگشت" ,
                            textColor: Style.Colors.white,
                            onPressed: _inputText.isNotEmpty ? _submitForm : _openFingerPrint  
                        )
                      ],
                    )
                  )
                )
            ,) 
          );
  }
}