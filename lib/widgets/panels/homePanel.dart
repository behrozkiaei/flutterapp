import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePanelWidget extends StatelessWidget {
  final ScrollController scrollController;
  const HomePanelWidget({super.key , required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: const [
          Text("hi") ,
          Text("hi") ,
          Text("hi") ,
          Text("hi") ,
      ]),
    );
  }
}