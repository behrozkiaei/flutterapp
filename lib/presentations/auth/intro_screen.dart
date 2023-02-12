
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:paytel/presentations/auth/enterPhone.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/presentations/home/home.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});


  
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  _IntroPageState();
  bool clicked = false;
  void afterIntroComplete (){
    
    setState(() {
      clicked = true;
    });
  }



  final List<PageViewModel> pages = [


    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
         const Text('FREE GIFT', style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600
          ),),
          const SizedBox(height: 8,),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              color: Style.Colors.primary,
              borderRadius: BorderRadius.circular(10)
            ),
          )
        ],
      ),
      body: "Free gifts with purchase. Offer free gifts like a gift wrap, gift card, or any free product.",
      image: Center(
        child: SvgPicture.asset("assets/icons/gift.svg")
      ),

      decoration: const PageDecoration(
        pageColor: Colors.white,
        bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 16,),
        imagePadding: EdgeInsets.all(20)
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          const Text('PAYMENT INTEGRATION', 
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600,
          ),),
          const SizedBox(height: 8,),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              color: Style.Colors.primary,
              borderRadius: BorderRadius.circular(10)
            ),
          )
        ],
      ),
      body: "A payment gateway as a merchant service that processes credit card payments for ecommerce sites and traditional brick and mortar stores.",
      image: Center(
        child: SizedBox(
          width: 450.0,
          child: SvgPicture.asset("assets/icons/payment.svg"),
        )
      ),

      decoration: const PageDecoration(
        pageColor: Colors.white,
        bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 16,),
        imagePadding: EdgeInsets.all(20)
      ),
    ),
    PageViewModel(
      titleWidget: Column(
        children: <Widget>[
          const Text('CALL CENTER', style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w600
          ),),
          const SizedBox(height: 8,),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              color: Style.Colors.primary,
              borderRadius: BorderRadius.circular(10)
            ),
          )
        ],
      ),
      body: "Call center gives a small business a big business feel. 24-hour sales, order entry, payment processing, billing inquiries, and more.",
      image: Center(
        child: SizedBox(
          width: 450.0,
          child: SvgPicture.asset("assets/icons/call.svg"),
        )
      ),

      decoration: const PageDecoration(
        pageColor: Colors.white,
        bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 16,),
        imagePadding: EdgeInsets.all(20)
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return clicked ?const  EnterPhone() : IntroductionScreen(
      pages: pages,
      onDone: () {
        afterIntroComplete();
      },
      onSkip: () {
        afterIntroComplete();
      },
      showSkipButton: true,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
      next: const Icon(Icons.navigate_next),
      done: const Text("DONE", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(7.0),
          activeSize: const Size(20.0, 5.0),
          activeColor: Style.Colors.primary,
          color: Colors.black12,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0))),
    );
  }
}