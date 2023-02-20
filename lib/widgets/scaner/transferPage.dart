import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/transaction/get-user-info-by-code/get-user-by-code.bloc.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.bloc.dart';
import 'package:paytel/repositories/transactions.repository.dart';
import 'package:paytel/widgets/scaner/qrPanel.dart';
import 'package:paytel/widgets/scaner/scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
class Transfer extends StatelessWidget {
  final panelController =  PanelController();
  final transactionRepo = TransactionRepo();
  Transfer({super.key});
  // const Transfer({super.key});
  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    return  MultiBlocProvider(
      providers: [
          BlocProvider<UserByCodeBloc>(create: (BuildContext context) => UserByCodeBloc(transactionRepository: transactionRepo),),
          BlocProvider<Wallet2WalletBloc>(create: (BuildContext context) => Wallet2WalletBloc( transactionRepository: transactionRepo),),
     ], 
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        controller: panelController,
        minHeight:height*0.3 ,
        maxHeight:height*0.8 ,
        parallaxEnabled: true,
        parallaxOffset:1,
        borderRadius:const BorderRadius.vertical(top:Radius.circular(10)),
        body: const ScannerPage(),
        panelBuilder: (controller) => QrPanel(
          scrollController: controller,
          panelController: panelController,
        ),
      ),
      ),
    );
  }
}