import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/auth/login/login.bloc.dart';
import 'package:paytel/blocs/auth/login/login.state.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPass extends StatefulWidget {
  const SetPass({super.key});

  @override
  State<SetPass> createState() => _SetPassState();
}

class _SetPassState extends State<SetPass> {
    bool loading= false;
    String pass = '';
    String repass = '';

    final _formKey = GlobalKey<FormState>();

     void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if(pass == repass && pass.length> 5){
          final prefs = await SharedPreferences.getInstance();
          prefs.setString("pass", pass);
            if (!mounted) {
            return;
             }
          Navigator.pushReplacementNamed(context, "/app-login");
      }
      if(pass != repass ){
            if (!mounted) {
            return;
             }
          ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("رمز با یکدیگر یکسان نیست",style :TextStyle(color: Style.Colors.gray2)),
                  backgroundColor: Style.Colors.fail,

                )
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
                        listeners: [  
                          BlocListener<LoginBloc, LoginState>(
                            listener: (context, state) {
                                if (state is LoginFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("ورود ناموفق بود",style :TextStyle(color: Style.Colors.gray2)),
                                      backgroundColor: Style.Colors.fail,

                                    ),
                                  );
                                  setState(() {
                                    loading = false;
                                  });
                                }
                                if(state is LoginLoading){
                                  setState(() {
                                    loading = true;
                                  });
                                } 
                                if(state is LoginSuccess){
                                    Navigator.pushReplacementNamed(context, "/app-login");
                                } 
                            }
                            
                          ),
                        ], 
                        child : Scaffold(
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
                                      if(value!= null){
                                        setState(() {
                                          repass= value;
                                        });
                                      }
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
                                      disabled: (pass.length <6 || pass !=repass) ? true :false,
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
                      ,) ,
          );
  }
}