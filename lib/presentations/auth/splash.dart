import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paytel/blocs/auth/me/me.bloc.dart';
import 'package:paytel/blocs/auth/me/me.event.dart';
import 'package:paytel/blocs/auth/me/me.state.dart';

import 'package:paytel/style/theme.dart' as Style;
import 'package:shared_preferences/shared_preferences.dart';
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
     final prefs = await SharedPreferences.getInstance();
     final String? token = prefs.getString("token");
    if(token != null){
        if (!mounted) {
            return;
             }
      BlocProvider.of<MeBloc>(context).add( StartFetchMe());
    }else{
        if (!mounted) {
            return;
             }
      Navigator.pushReplacementNamed(context, "/intro");

    }
  }
  @override
  Widget build(BuildContext context) {
    return   MultiBlocListener(
      listeners: [
      BlocListener<MeBloc,MeState >(
            listener: (context, state) async {
              
              if(state is MeSuccess){
                      Navigator.pushReplacementNamed(context, "/home");
              }
              if(state is MeFailure){
                  final prefs = await SharedPreferences.getInstance();
                  final String? mobile = prefs.getString("mobile");
                if(mobile != null){
                  if (!mounted) {
                    return;
                  }                  
                  Navigator.pushReplacementNamed(context, "/intro");
                }else{
                    if (!mounted) {
            return;
             }
                  await  Navigator.pushReplacementNamed(context, "/");
                }
              }
              
              
        })],child:
      Scaffold(
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
      ),
    );
  }
}