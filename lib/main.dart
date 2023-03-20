import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paytel/blocs/app-state/app-state.bloc.dart';
import 'package:paytel/blocs/auth/check-pass/check-pass.bloc.dart';
import 'package:paytel/blocs/auth/login/login.bloc.dart';
import 'package:paytel/blocs/auth/me/me.bloc.dart';
import 'package:paytel/blocs/auth/ressetPass/resset-pass.bloc.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.bloc.dart';
import 'package:paytel/blocs/services/buyCharge/buy-charge.bloc.dart';
import 'package:paytel/blocs/services/buyInternet/buy-internet.bloc.dart';
import 'package:paytel/blocs/services/internet-packages/internet-packages.bloc.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.bloc.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.bloc.dart';
import 'package:paytel/blocs/user/update-avtar/update-avatar.bloc.dart';
import 'package:paytel/blocs/user/update-bank-data/update-user.bloc.dart';
import 'package:paytel/blocs/user/update-identity-image/update-identity.bloc.dart';
import 'package:paytel/blocs/user/update-national-card/update-avatar.bloc.dart';
import 'package:paytel/blocs/user/update-user/update-user.bloc.dart';
import 'package:paytel/models/app-state.model.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:paytel/repositories/transactions.repository.dart';
import 'package:paytel/router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'firebase_options.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Received FCM message in background: ${message.data}");
// }

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final userRepository = UserRepository();
  final transactionRepo = TransactionRepo();

  runApp(MultiBlocProvider(
      providers: [
          BlocProvider<SendOtpBloc>(create: (BuildContext context) => SendOtpBloc(userRepository: userRepository),),
          BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc(userRepository: userRepository),),
          BlocProvider<MeBloc>( create: (BuildContext context) => MeBloc( userRepository: userRepository),),
          BlocProvider<MyTransactionsBloc>( create: (BuildContext context) => MyTransactionsBloc( transactionRepository: transactionRepo)),
          BlocProvider<InternetPackagesBloc>( create: (BuildContext context) => InternetPackagesBloc( transactionRepository: transactionRepo)),
          BlocProvider<BuyInternetBloc>(create: (BuildContext context) => BuyInternetBloc(transactionRepository: transactionRepo),),
          BlocProvider<BuyChargeBloc>(create: (BuildContext context) => BuyChargeBloc(transactionRepository: transactionRepo),),
          BlocProvider<UpdateAvatar>(create: (BuildContext context) => UpdateAvatar(userRepository: userRepository),),
          BlocProvider<UpdateNationalCard>(create: (BuildContext context) => UpdateNationalCard(userRepository: userRepository),),
          BlocProvider<UpdateBankr>(create: (BuildContext context) => UpdateBankr(userRepository: userRepository),),
          BlocProvider<UpdateUser>(create: (BuildContext context) => UpdateUser(userRepository: userRepository),),
          BlocProvider<UpdateIdentityImage>(create: (BuildContext context) => UpdateIdentityImage(userRepository: userRepository),),
          BlocProvider<CheckPassBloc>(create: (BuildContext context) => CheckPassBloc(userRepository: userRepository),),
          BlocProvider<RessetPassBloc>(create: (BuildContext context) => RessetPassBloc(userRepository: userRepository),),
          BlocProvider<AppStateBloc>(create: (BuildContext context) => AppStateBloc()),
          BlocProvider<Wallet2WalletBloc>(create: (BuildContext context) => Wallet2WalletBloc( transactionRepository: transactionRepo),),

      ], 
      child:MyApp(),
      )
      );
}
class MyApp extends StatelessWidget {
  MyApp({super.key})  {
    initializeFirebase();

  }

  initializeFirebase() async {
    try{
      final String? fcmToken = await FirebaseMessaging.instance.getToken();
      if(fcmToken != null){
        print(fcmToken);
        final share = await SharedPreferences.getInstance();
        share.setString('fcmToken', fcmToken);
      }
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("Received FCM message");
      });
    }catch(e){
      print("token not founded");
    }
  }

  @override
  Widget build(BuildContext context) {
    return   SkeletonTheme(
        shimmerGradient: Style.Colors.lightLinearGradient,
        darkShimmerGradient:Style.Colors.darkLinearGradient,
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
          theme:Style.Colors.themeData,
          darkTheme: Style.Colors.darkTheme,
          initialRoute: '/splash', 
          debugShowCheckedModeBanner  : false,
          onGenerateRoute: generateRoute,
        ),
    );
  }
}
