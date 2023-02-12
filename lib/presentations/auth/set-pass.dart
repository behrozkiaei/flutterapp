import 'package:flutter/material.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:flutter/cupertino.dart';

class SetPass extends StatefulWidget {
  const SetPass({super.key});

  @override
  State<SetPass> createState() => _SetPassState();
}

class _SetPassState extends State<SetPass> {

    final _formKey = GlobalKey<FormState>();
String pass = '';
String repass = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Input text: $pass');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                         InputDecorationStyle(
                          label: "رمز عبور",
                          textInputType : TextInputType.text,
                          icon:  Icons.security,
                          onChange: (value){
                            if(value!= null){
                              setState(() {
                                pass= value;
                              });

                            }
                          },
                          onSave: (value){},
                          type: "text",
                          validate :(value){
                                if (value!.length < 6 ) {
                                      return 'Please enter some text';
                                    }
                              return null ;
                          }
                        ),const SizedBox(height: 10),
                        InputDecorationStyle(
                          label: "تکرار رمز عبور",
                          textInputType : TextInputType.text,
                          icon:  Icons.security,
                          onChange: (value){
                            
                          },
                          onSave: (value){
                          if(value!= null){
                              setState(() {
                                repass= value;
                              });

                            }

                          },
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
                            icon : Icons.check_box ,
                            text :"تایید",
                            textColor: Style.Colors.white,
                            onPressed: _submitForm  
                        )
                      ],
                    )
                  )
                )
            ,) 
          );
  }
}