import 'package:flutter/material.dart';
import 'package:paytel/router.dart';
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
      theme:  
            ThemeData(
              fontFamily: "IRANSansWeb",
              brightness: Brightness.light,
              primaryColor: Colors.deepPurple[600],
              buttonTheme:ButtonThemeData(buttonColor : Colors.deepPurple[600]) ,
  
                    primarySwatch: Colors.deepPurple,
                    colorScheme:  ColorScheme.light(
                      primary: Colors.deepPurple.shade400,
                    ),
              textTheme: const TextTheme(
                displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'IRANSansWeb'),
              ),
            ),
      initialRoute: '/app-login',
      debugShowCheckedModeBanner  : false,
      onGenerateRoute: generateRoute,
    );
  }
}
