import 'package:flutter/material.dart';
import 'package:paytell/router.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme:  ThemeData(fontFamily: "IRANSansWeb"),
      initialRoute: '/',
      debugShowCheckedModeBanner  : false,
      onGenerateRoute: generateRoute,
    );
  }
}
