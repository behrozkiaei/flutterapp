import 'package:flutter/material.dart';
import 'package:paytel/presentations/auth/Login.dart';
import 'package:paytel/presentations/auth/enterPhone.dart';
import 'package:paytel/presentations/auth/intro_screen.dart';
import 'package:paytel/presentations/auth/otpWidget.dart';
import 'package:paytel/presentations/auth/set-pass.dart';
import 'package:paytel/presentations/auth/splash.dart';
import 'package:paytel/presentations/home/home.dart';
import 'package:paytel/widgets/Auth/biometricWidget.dart';
import 'package:paytel/widgets/profile/regiserStepper.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const EnterPhone());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/otp':

         return MaterialPageRoute(builder: (_) => const OtpWidget()); 
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterStepper()); 
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen()); 
      case '/app-login':
        return MaterialPageRoute(builder: (_) => const AppLogin()); 
      case '/intro':
        return MaterialPageRoute(builder: (_) => const IntroPage()); 
      case '/set-pass':
        return MaterialPageRoute(builder: (_) => const SetPass()); 
      case '/biometric':
        return MaterialPageRoute(builder: (_) =>  FingerprintLoginScreen()); 

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}