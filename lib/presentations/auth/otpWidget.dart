
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:paytel/presentations/auth/enterPhone.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:shared_preferences/shared_preferences.dart';
class OtpWidget extends StatefulWidget {
  const OtpWidget({super.key});



  @override
  _OtpWidgetState createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  final _formKey = GlobalKey<FormState>();
  late String _otp;
  String storedValue = "";
  OtpFieldController otpController = OtpFieldController();


 
  @override
  void initState() {
    super.initState();
    _getStoredValue();
    startTimer();
  }
  late Timer _timer;
  int  duration = 60 ; 
  int _start = 60;
  bool loading = false ;
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
      print(value);
      setState(() { storedValue = value ; });     
  }
  var spinkit = const SpinKitRotatingCircle(
        color: Colors.white,
        size: 50.0,
      );
  @override
  Widget build(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Style.Colors.background,
      body: 
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
                          //print("Changed: " + pin);
                        },
                        onCompleted: (pin) {
                           if(_start == 0){
                                
                              
                            }
                            if(_start >0){
                              //request for aprove
                            }
                        })
                  ),  
                  const SizedBox(height:25),   
                  ElevatedButton(
                      onPressed: () async {
                          if(_start == 0 ){
                            setState(() {_start=duration;});
                            startTimer();
                             setState(() { loading = false; });
                          }else{
                            loading = true;
                            //event emit to bloc
                            Navigator.pushReplacementNamed(context, "/set-pass");
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
                                      builder: (context) => EnterPhone(),
                                    ),
                                  );
                      },
                      child: const Text("ویرایش شماره تلفن" ,style : TextStyle(color: Style.Colors.primary)),
                    ),
                    const SizedBox(height:20),
                    Text("$_start"),
                  ],
                )
              
          )
          )
        ,
      )

    );
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
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

}