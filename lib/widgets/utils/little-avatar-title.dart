import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paytel/const.dart';
import 'package:paytel/style/theme.dart' as Style;
class AvatarTitle extends StatelessWidget {
  final String avatar ;
  final String title ;
   AvatarTitle({super.key, required this.avatar, required this.title}){
    print('$baseUrl/$avatar');
  }
  static const String baseUrl = Config.baseUrl;
  @override
  Widget build(BuildContext context) {
    return  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                      margin:const EdgeInsets.all(4),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Style.Colors.gray1,
                          width: 1
                        ),
                      ),
                        child:
                        avatar != null ? 
                        CircleAvatar(
                            radius: 50.0,
                            backgroundImage:NetworkImage('$baseUrl/$avatar')) : 
                            const  CircleAvatar(
                    backgroundColor: Style.Colors.primary,
                    foregroundColor: Style.Colors.primary,
                    radius: 50.0,
                    backgroundImage:  AssetImage('assets/icons/user.png')   
                    ),
                   ),
                    Text(title ?? "نامشخص")
                ],
        
    );
  }
}