import 'package:flutter/material.dart';
import 'package:paytell/router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      themeMode: ThemeMode.dark,
      localizationsDelegates:const  [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      supportedLocales: const [
          Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
      locale:const Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales,
      theme:  ThemeData(fontFamily: "IRANSansWeb"),
      initialRoute: '/home',
      debugShowCheckedModeBanner  : false,
      onGenerateRoute: generateRoute,
    );
  }
}
