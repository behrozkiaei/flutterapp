import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Colors {
  
  const Colors();

  static const Color primary =Color.fromARGB(255, 126, 87, 194 );
  static const Color secondary =Color.fromARGB(255, 183, 181, 187);
  static const Color tertiary = Color.fromARGB(255, 33, 32, 32);
  static const Color accent = Color.fromARGB(255, 84, 0, 252);
  static const Color gray1 = Color.fromARGB(255, 113,142, 156);
  static const Color gray2 = Color.fromARGB(255, 241, 245, 246);
  static const Color black = Color.fromARGB(255, 241, 245, 246);

  static const Color primaryDark =Color.fromARGB(255, 126, 87, 194 );
  static const Color secondaryDark =Color.fromARGB(255, 183, 181, 187);
  static const Color tertiaryDark = Color.fromARGB(255, 239, 237, 237);
  static const Color accentDark = Color.fromARGB(255, 84, 0, 252);
  static const Color background = Color.fromARGB(255, 255, 255, 255);

  static const Color fail= Color.fromARGB(255, 244, 33, 33);
  static const Color success  = Color.fromARGB(255, 10, 147, 42);
  static const Color white  = Color.fromARGB(255, 255, 255, 255);
  static const Color alert  = Color.fromARGB(255, 247, 227, 10);
}

class TextStyling {
  
  const TextStyling();

  static const  TextStyle primaryTextStyle =   TextStyle(
                              color: Colors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "IRANSansWeb"
                            );
  static const  TextStyle secondaryTextStyle =   TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontFamily: "IRANSansWeb"
                            );

}