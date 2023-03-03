
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:paytel/blocs/auth/login/login.bloc.dart';
import 'package:paytel/blocs/auth/login/login.event.dart';
import 'package:paytel/blocs/auth/login/login.state.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.bloc.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.event.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.state.dart';
import 'package:paytel/presentations/auth/enterPhone.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OtpWidget extends StatefulWidget {
  const OtpWidget({super.key});

  @override
  _OtpWidgetState createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  int  duration = 120 ; 
  bool loading = false ;
  OtpFieldController otpController = OtpFieldController();
  var spinkit = const SpinKitRotatingCircle(
        color: Colors.white,
        size: 50.0,
      );

  String storedValue = "";

  final _formKey = GlobalKey<FormState>();
  String? _otp;
  int _start = 120;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getStoredValue();
    startTimer();
  }

  void startTimer() {
    const oneSec =  Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
           setState(() { loading = false; });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  _getStoredValue() async {
      final prefs = await SharedPreferences.getInstance();
      final String value = prefs.getString("mobile") ?? "";
      setState(() { storedValue = value ; });     
  }

   void _submitOtp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Send request to server to login with phone number and OTP
      // For example, using the http package:
      // var response = await http.post(...);
    }
  }

  @override
  Widget build(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:  MultiBlocListener(
                        listeners: [
                          BlocListener<SendOtpBloc, SendOtpState>(
                            listener: (context, state) {
                                if (state is SendOtpFailure) {
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
                                  if (state is SendOtpLoading) {
                                  setState(() {
                                    loading = true;
                                  });
                                }
                                
                                if(state is SendOtpSuccess){
                                  setState(() {_start=duration;});
                                  startTimer();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("رمز یکبار مصرف  ارسال شد",style :TextStyle(color: Style.Colors.gray2)),
                                      backgroundColor: Style.Colors.success,
                                    )
                                    );
                                } 
                            },
                          ),
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

                                  if(state.otpType == OtpType.Login.name){
                                    Navigator.pushReplacementNamed(context, "/app-login");
                                  }else if(state.otpType == OtpType.RessetPass.name){
                                    Navigator.pushReplacementNamed(context, "/set-pass");
                                  }else{
                                  }
                                } 
                            },
                          ),
                        ],
      child:
      Center(
        child: 
          Form(
          key: _formKey,
          child:Padding(padding:const EdgeInsets.all(15),
            child: Column(
            children: <Widget>[
              const  SizedBox(height:100),
              RichText(
                text: TextSpan(
                  style:const TextStyle(fontSize: 11 , fontFamily: "IRANSansWeb",color: Style.Colors.gray1),
                  children: <TextSpan>[
                    const TextSpan(text: ' یک پیامک به شماره '),
                    TextSpan(text: storedValue,style:const  TextStyle(fontWeight: FontWeight.bold , color: Style.Colors.primary)),
                    const TextSpan(text:  " ارسال شده است "  ),
                  ],
                ),
              ),
              const SizedBox(height:20), 
              // ignore: avoid_unnecessary_containers
              Container(
                child:const  Text("کد فعال‌سازی را وارد کنید" ,style : TextStyle(fontWeight: FontWeight.normal , fontSize: 10 )),
                ),
              const SizedBox(height:20), 
              Directionality( // add this
                textDirection: TextDirection.ltr, 
                child:
                OTPTextField(
                    controller: otpController,
                    length: 4,
                    width: width/2,
                    textFieldAlignment: MainAxisAlignment.spaceBetween,
                    fieldWidth: 40,
                    fieldStyle: FieldStyle.underline,
                    otpFieldStyle:OtpFieldStyle(borderColor: Style.Colors.primary) ,
                    outlineBorderRadius: 15,
                    style:const TextStyle(fontSize: 17 , color: Style.Colors.primary),
                    onChanged: (pin) {
                     
                    },
                    onCompleted: (pin) {
                        setState(() {
                        _otp =pin;
                      });
                    })
              ),  
              const SizedBox(height:25),   
              ElevatedButton(
                  onPressed: () async {
                      if(_start == 0 ){
                          BlocProvider.of<SendOtpBloc>(context).add(SendOtpButtonPressed(mobile: storedValue));
                      }else{
                        if(_otp?.length == 4){
                            BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(mobile: storedValue,password: _otp!));
                        }
                      }
                    
                  },
                  style: ElevatedButton.styleFrom(
                          backgroundColor: Style.Colors.primary,
                          elevation: 0,
                          minimumSize:Size(width/2,50), 
                          maximumSize:Size(width/2,50), 
                          textStyle: const TextStyle(
                            color:Style.Colors.primary,
                            fontSize: 12,
                            fontFamily: "IRANSansWeb",
                            fontWeight: FontWeight.bold
                          )
                        ),
                  child:
                      (() {
                        if(loading ){
                        return  const SizedBox(width: 20,height: 20 ,child: SpinKitThreeBounce(
                                          color: Colors.white,
                                          size: 12.0,
                                      ));
                        }else{
                            return   Text(_start > 0 ? "تایید" : "ارسال مجدد کد");
                        }
                      }())
                ),
                const SizedBox(height:20),
              TextButton(
                style :ButtonStyle(
                  backgroundColor:MaterialStateProperty.resolveWith((states) {
                  return  Style.Colors.background;
                  }),
                  textStyle:MaterialStateProperty.resolveWith((states) {
                  return const TextStyle(color: Style.Colors.primary , fontFamily: "IRANSansWeb");
                  }
                )
                ),
                onPressed: ()  {
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>const EnterPhone(),
                                ),
                              );
                  },
                  child:  const Text("ویرایش شماره تلفن" ,style : TextStyle(color: Style.Colors.primary)),
                ),
                const SizedBox(height:20),
                Text("$_start"),
                  
             
              ],
            )
          )
          )
        ,
      ),
      ),
    );
  }
}