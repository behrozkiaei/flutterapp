import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
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
  final LocalAuthentication auth = LocalAuthentication();
  String _inputText = '';
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }
 void _openFingerPrint(){
  _authenticate();
 }

 Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'ورود با اثر انگشت',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    if(authenticated){
        Navigator.pushNamed(context, "/home");

    }
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
                            child:    _inputText.isNotEmpty ?
                             Image.asset("assets/icons/pass.png",scale: 2,):Image.asset("assets/icons/finger-primary.png",scale: 2,),

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