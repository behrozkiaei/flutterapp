import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/app-state/app-state.bloc.dart';
import 'package:paytel/blocs/app-state/app-state.event.dart';
import 'package:paytel/blocs/app-state/app-state.state.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.bloc.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.event.dart';
import 'package:paytel/widgets/home/receipe.dart';
import 'package:paytel/widgets/panels/transactions.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}


class _TransactionsState extends State<Transactions> {
  final panelController =  PanelController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AppStateBloc? _appStateBloc;

   @override
  void initState() {
    super.initState();
    BlocProvider.of<MyTransactionsBloc>(context).add(const MyTransactionsButtonPressed( page: 0));
  }
   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appStateBloc = BlocProvider.of<AppStateBloc>(context);
  }

  @override
  void dispose() {
    _appStateBloc?.add(const ChangeTransactionPanelState(isTransactionPanelOpen: false));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: BlocBuilder<AppStateBloc, AppStateState>(
        builder: (context, state) {
        return 
          SlidingUpPanel(
          controller: panelController,
          minHeight:height*0.2 ,
          maxHeight:height*0.7 ,
          defaultPanelState: state.transactionPanelStateIsOpen== true ?  PanelState.OPEN: PanelState.CLOSED,
          parallaxEnabled: true,
          parallaxOffset:1.3,
          borderRadius:const BorderRadius.vertical(top:Radius.circular(10)),
          body: const Receipt(),
          panelBuilder: (controller) => TransactionsPanel(
            scrollController: controller,
            panelController: panelController,
          ),
      );
      } 
    ),
    );
  }
}