import 'package:flutter/material.dart';
import 'package:paytel/models/internet-packages-model.model.dart';
import 'package:paytel/presentations/auth/Login.dart';
import 'package:paytel/presentations/auth/enterPhone.dart';
import 'package:paytel/presentations/auth/intro_screen.dart';
import 'package:paytel/presentations/auth/otpWidget.dart';
import 'package:paytel/presentations/auth/set-pass.dart';
import 'package:paytel/presentations/auth/splash.dart';
import 'package:paytel/presentations/home/home.dart';
import 'package:paytel/widgets/bill/enterBillid.dart';
import 'package:paytel/widgets/profile/regiserStepper.dart';
import 'package:paytel/widgets/profile/themConfig.dart';
import 'package:paytel/widgets/simcard/buyInternetPreReceipt.dart';
import 'package:paytel/widgets/simcard/chooseChargeAmount.dart';
import 'package:paytel/widgets/simcard/enterPhone.dart';
import 'package:paytel/widgets/simcard/internetPackages.dart';

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
      case '/sim-enter-phone':
        return MaterialPageRoute(builder: (_) =>const  EnterPhoneSim()); 
      case '/bill-enter-id':
        return MaterialPageRoute(builder: (_) =>const  EnterBillId()); 
      case '/charge-amount':
        return MaterialPageRoute(builder: (_) =>const  ChooseAmountCharge()); 
      case '/internet-packages':
              return MaterialPageRoute(builder: (_) =>const  IntertetPackages());
      case '/internet-prereceipt':
              final Value product = settings.arguments as Value;
              return MaterialPageRoute(builder: (_) =>  InternetPreReceipt( product: product));
      case '/theme':
          return MaterialPageRoute(builder: (_) =>const  ThemeConfig());
          default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}