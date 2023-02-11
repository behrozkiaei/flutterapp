import 'package:flutter/material.dart';
import 'package:paytel/presentations/auth/enterPhone.dart';
import 'package:paytel/presentations/auth/otpWidget.dart';
import 'package:paytel/presentations/home/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => EnterPhone());
    case '/home':
      return MaterialPageRoute(builder: (_) => HomePage());
    case '/otp':
       final args = settings.arguments as OtpWidget;
       if(args.phoneNumber is String){
          return MaterialPageRoute(builder: (_) => OtpWidget(phoneNumber:args.phoneNumber));
       }else{
           return MaterialPageRoute(builder: (_) => HomePage()); 
       }
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}