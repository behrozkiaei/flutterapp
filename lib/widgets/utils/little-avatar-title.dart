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
                        CircleAvatar(
                            radius: 50.0,
                            backgroundImage:NetworkImage('$baseUrl/$avatar'),
 
                  // ),
                      //   CachedNetworkImage(
                      //       imageUrl: '$baseUrl$avatar',
                      //       imageBuilder: (context, imageProvider) => Container(
                      //       width: 80.0,
                      //         height: 80.0,
                      //         decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           image: DecorationImage(
                      //             image: imageProvider, fit: BoxFit.cover),
                      //         ),
                      //       ),
                      //        progressIndicatorBuilder: (context, url, downloadProgress) => 
                      //         CircularProgressIndicator(value: downloadProgress.progress,color: Style.Colors.gray2,strokeWidth :1.0),
                      //       errorWidget: (context, url, error) =>const Icon(Icons.error),
                      // ),
                    ),
            ),
                     Text(title)
                ],
        
    );
  }
}