import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/auth/me/me.bloc.dart';
import 'package:paytel/blocs/auth/me/me.event.dart';
import 'package:paytel/blocs/transaction/increase-wallet/increase-wallet.bloc.dart';
import 'package:paytel/repositories/transactions.repository.dart';
import 'package:paytel/widgets/home/SendReceiveBox.dart';
import 'package:paytel/widgets/panels/homePanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  final transactionRepo = TransactionRepo();

  @override
  void initState() {
   BlocProvider.of<MeBloc>(context).add( StartFetchMe());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    final double height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
          BlocProvider<IncreaseWalletBloc>(create: (BuildContext context) => IncreaseWalletBloc(transactionRepository: transactionRepo),),
     ], 
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        minHeight:height/2 ,
        body: const SendReceivePage(),
        panelBuilder: (controller) => HomePanelWidget(
          scrollController: controller,
        ),
      ),
      ),
    );
  }
}

