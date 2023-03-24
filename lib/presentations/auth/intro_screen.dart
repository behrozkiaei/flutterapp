
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
         const Text('انتقال وجه', style: TextStyle(
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
      body: "انتقال سریع و آسان وجه  به دوستان",
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
          const Text('پرداخت آسان با اسکن بارکد', 
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
      body: "با اسکن بارکد به راحتی و بدون کارمزد انتقال وجه انجام دهید",
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
          const Text('خرید شارژ، اینترنت و پرداخت قبوض', style: TextStyle(
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
      body: "شما همچنین می‌توانید از طریق کارت بانکی و کیف پول خود شارژ و بسته اینترنت تهیه کنید.",
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
      skip: const Text('رد شدن', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey)),
      next: const Icon(Icons.navigate_next),
      done: const Text("تمام", style: TextStyle(fontWeight: FontWeight.w600)),
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