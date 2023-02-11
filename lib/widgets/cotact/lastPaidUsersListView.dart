import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytel/style/theme.dart' as Style;
class LastPaid extends StatelessWidget {
  const LastPaid({super.key});

  @override
  Widget build(BuildContext context) {


    return 
      ListView(
      scrollDirection: Axis.horizontal,
        physics:  const BouncingScrollPhysics(),

       children: List.generate(20, (index) {
        return Column(
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
                        child: CachedNetworkImage(
                            imageUrl: 'https://picsum.photos/200?random=$index',
                            imageBuilder: (context, imageProvider) => Container(
                            width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                             progressIndicatorBuilder: (context, url, downloadProgress) => 
                              CircularProgressIndicator(value: downloadProgress.progress,color: Style.Colors.gray2,strokeWidth :1.0),
                            errorWidget: (context, url, error) =>const Icon(Icons.error),
                      ),
                    ),
                     Text('User$index')
                ],
        );
       
      })
    ); 
  }

}