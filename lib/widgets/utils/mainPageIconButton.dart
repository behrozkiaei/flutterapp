import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainPageIcons extends StatelessWidget {
  final double  iconSize  ;
  final IconData  icon ;
  final Color iconColor ; 
  final Color iconBackgroundColor;
  final String text ;
  final double  textSize;
  final Color  textColor;
  const MainPageIcons({super.key , 
                        required this.iconSize ,
                        required this.iconColor,
                        required this.icon,
                        required this.iconBackgroundColor,
                        required this.text,
                        required this.textSize,
                        required this.textColor
                  });

  @override
  Widget build(BuildContext context) {
    return  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: iconSize,
                                      height: iconSize,
                                      decoration:  BoxDecoration(shape: BoxShape.circle , color: iconBackgroundColor),
                                      child:  Icon(icon,color: iconColor , size:iconSize ,),
                                    ),
                                    const SizedBox( height:10),
                                     Text(text ,style: TextStyle(color: textColor ,fontSize: textSize, fontFamily: "IRANSansWeb"))
                                  ],
                                );
  }
}