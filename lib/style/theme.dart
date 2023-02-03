import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Colors {
  
  const Colors();

  static const Color primary =Color.fromARGB(255, 126, 87, 194 );
  static const Color secondary =Color.fromARGB(255, 183, 181, 187);
  static const Color background = Color.fromARGB(255, 255, 255, 255);
  static const Color backgroundLight = Color.fromARGB(255, 255, 255, 255);
  static const Color loginGradientStart = const Color(0xFF59499E);
  static const Color loginGradientEnd = const Color(0xFF59499E);
  static const Color successGreen =const Color(0xFF32CD32);
  static const Color secondaryColor = const Color(0xFFffa302);
  static const Color thirdColor = const Color(0xFFFFD684);
  static const Color fourthColor = const Color(0xFF8FDCFF);
  static const Color elementBack = const Color(0xfff1efef);
  static const Color titleColor = const Color(0xFF061857);
  static const Color subTitle = const Color(0xFFa4adbe);
  static const Color textMain = const Color(0xFF848484);
  static const Color greyBack = const Color(0xFFced4db); 
  static const Color grey = const Color(0xFFb4bdce);
  static const Color greyForm = const Color(0xFFcaced4); 
  static const Color red = Color.fromARGB(255, 8, 4, 4); 
  static const Color orange = const Color(0xFFff6348);
  static const Color strongGrey = const Color(0xFFced4db);
  static const Color secondBlack = const Color(0xFF515C6F);
  static const Color facebookBlue = const Color(0xFF1877f2);
  
  // static const primaryGradient = const LinearGradient(
  //   colors: const [ Color(0xFF5BC0FF), Color(0xFF0063FF)],
  //   stops: const [0.0, 1.0],
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  // );
  // static const cardGradient = const LinearGradient(
  //   colors: const [ Color(0xFF1e3c72), Color(0xFF2a5298)],
  //   stops: const [0.0, 1.0],
  //   begin: Alignment.topLeft,
  //   end: Alignment.bottomRight,
  // );


}

class TextStyling {
  
  const TextStyling();

  static const  TextStyle primaryTextStyle = const  TextStyle(
                              color:Colors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "IRANSansWeb"
                            );

}