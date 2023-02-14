import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:paytel/style/theme.dart' as Style;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _getThingsOnStartup();
    super.initState();
  }
  Future _getThingsOnStartup() async {
    await Future.delayed(const  Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, "/intro");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        const SizedBox(
          height: 200,
        ),
        SizedBox(
          height: 200,
          width: double.infinity,
          child:   Image.asset("assets/icons/logo/p-logo-primary.png",scale: 1,),

        ),
         Expanded(
         child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const[
             Text("لطفا چند لحظه صبر کنید"),
            SizedBox(width: 80,
                height: 20 ,
                child: SpinKitThreeBounce(
                            color: Style.Colors.primary,
                            size: 20.0,
                        )) ,
            SizedBox(
                  height: 100,
                ),
          ],)
        )
      ]),
    );;
  }
}