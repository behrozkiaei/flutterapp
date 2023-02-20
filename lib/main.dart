import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paytel/blocs/auth/login/login.bloc.dart';
import 'package:paytel/blocs/auth/me/me.bloc.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.bloc.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.bloc.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:paytel/repositories/transactions.repository.dart';
import 'package:paytel/router.dart';
import 'package:skeletons/skeletons.dart';

void main()   {
  WidgetsFlutterBinding.ensureInitialized();


  runApp(  MyApp(),
    );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
    final userRepository = UserRepository();
  final transactionRepo = TransactionRepo();
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
          BlocProvider<SendOtpBloc>(create: (BuildContext context) => SendOtpBloc(userRepository: userRepository),),
          BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc(userRepository: userRepository),),
          BlocProvider<MeBloc>( create: (BuildContext context) => MeBloc( userRepository: userRepository),),
          BlocProvider<MyTransactionsBloc>( create: (BuildContext context) => MyTransactionsBloc( transactionRepository: transactionRepo)),
      ], 
      child: SkeletonTheme(
    // themeMode: ThemeMode.light,
    shimmerGradient: const LinearGradient(
         colors:  [
          Color(0xFFD8E3E7),
          Color(0xFFC8D5DA),
          Color(0xFFD8E3E7),
        ],
        stops: [
          0.1,
          0.5,
          0.9,
        ],
      ),
      darkShimmerGradient:const LinearGradient(
        colors: [
          Color(0xFF222222),
          Color(0xFF242424),
          Color(0xFF2B2B2B),
          Color(0xFF242424),
          Color(0xFF222222),
        ],
        stops: [
          0.0,
          0.2,
          0.5,
          0.8,
          1,
        ],
        begin: Alignment(-2.4, -0.2),
        end: Alignment(2.4, 0.2),
        tileMode: TileMode.clamp,
      ),
        child: MaterialApp(
      themeMode: ThemeMode.light,
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
                    scaffoldBackgroundColor: Colors.white,
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
             darkTheme: ThemeData(
               brightness: Brightness.dark,
               fontFamily: "IRANSansWeb",
               primaryColor: Colors.deepPurple[800],
                textTheme: const TextTheme(
                displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,color:  Colors.white),
                titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic,color:  Colors.white),
                bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'IRANSansWeb',color:  Colors.white),
              ),
            ),
      initialRoute: '/home', 
      debugShowCheckedModeBanner  : false,
      onGenerateRoute: generateRoute,
    ),
    ),
    );
  }
}
