import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPageIcons extends StatelessWidget {
  final double iconSize;
  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String text;
  final double textSize;
  final Color textColor;
  const MainPageIcons(
      {super.key,
      required this.iconSize,
      required this.iconColor,
      required this.icon,
      required this.iconBackgroundColor,
      required this.text,
      required this.textSize,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(alignment: Alignment.center, children: [
          Container(
            width: iconSize + 30,
            height: iconSize + 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(
                  71, 255, 255, 255), // set white color with 50% opacity
            ),
          ),
          Center(
              child: Container(
            width: iconSize,
            height: iconSize,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: iconBackgroundColor),
            child: Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ))
        ]),
        const SizedBox(height: 10),
        Text(text,
            style: TextStyle(
                color: textColor,
                fontSize: textSize,
                fontFamily: "IRANSansWeb"))
      ],
    );
  }
}
