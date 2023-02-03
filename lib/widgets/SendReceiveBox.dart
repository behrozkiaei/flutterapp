import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytell/style/theme.dart' as Style;
class SendReceivePage extends StatelessWidget {
  const SendReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: 500,
      decoration: const BoxDecoration(color:Style.Colors.primary) ,
      child: Row(children: 
        const [
         Text("send"),
         Text("receive"),
         Text("cashback"),
      ]),
    );
  }
}