import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytel/style/theme.dart' as Style;

class AvatarTitleSub extends StatelessWidget {

  final ImageProvider avatarUrl ;
  final String subTitle ;
  final String title ;

  const AvatarTitleSub({super.key, required this.avatarUrl, required this.title, required this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Column(children:[
      CircleAvatar(
        backgroundImage: avatarUrl,
        radius: 50.0,
      ),
      const SizedBox(height: 20.0),
      Text(title ,style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10.0),
      Text(subTitle ?? '-', style:const TextStyle(fontSize: 14.0,color: Style.Colors.gray1)),
      ]
    );
  }
}
                 