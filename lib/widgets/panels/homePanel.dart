import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:paytel/style/theme.dart' as Style;
class HomePanelWidget extends StatelessWidget {
  final ScrollController scrollController;
  const HomePanelWidget({super.key , required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.start,
        children:  [
         const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:  [
              Container(
                    width: 80,
                    height: 80,
                    decoration:  BoxDecoration(
                        // color:Style.Colors.background ,
                        borderRadius:BorderRadius.circular(10.0) , 
                        border:  Border.all(color: Style.Colors.primary)
                      ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/icons/sim.png",scale: 10,),
                        const Text("خرید شارژ" ,style:Style.TextStyling.primaryTextStyle)
                    ],) 
              ),
              Container(
              width: 80,
              height: 80,
              decoration:  BoxDecoration(
                  // color:Style.Colors.background ,
                  borderRadius:BorderRadius.circular(10.0) , 
                  border:  Border.all(color: Style.Colors.primary)
                ),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                        Image.asset("assets/icons/internet.png",scale:10,),
                        const Text("خرید اینترنت" ,style:Style.TextStyling.primaryTextStyle)
                    ],) 
              ),
              Container(
              width: 80,
              height: 80,
              decoration:  BoxDecoration(
                  // color:Style.Colors.background ,
                  borderRadius:BorderRadius.circular(10.0) , 
                  border:  Border.all(color: Style.Colors.primary)
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                        Image.asset("assets/icons/bill.png",scale: 10,),
                        const Text("پرداخت قبوض" ,style:Style.TextStyling.primaryTextStyle)
                    ],) 
              ),
            ]
            )
        ]
      ),
    );
  }
}