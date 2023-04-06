import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/app-state/app-state.bloc.dart';
import 'package:paytel/blocs/app-state/app-state.event.dart';
import 'package:paytel/blocs/app-state/app-state.state.dart';
import 'package:paytel/blocs/transaction/get-user-info-by-code/get-user-by-code.bloc.dart';
import 'package:paytel/repositories/transactions.repository.dart';
import 'package:paytel/widgets/scaner/qrPanel.dart';
import 'package:paytel/widgets/scaner/scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
class Transfer extends StatefulWidget {
  const Transfer({super.key});

  @override
  State<Transfer> createState() => _Transfer();
}

class _Transfer extends State<Transfer>  {
  final panelController =  PanelController();
  final transactionRepo = TransactionRepo();
  AppStateBloc? _appStateBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appStateBloc = BlocProvider.of<AppStateBloc>(context);
  }

  @override
  void dispose() {
    _appStateBloc?.add(const ChangeScannerPanelState(isScannerPanelOpen: false));
    super.dispose();
  }

  // const Transfer({super.key});
  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    return  MultiBlocProvider(
      providers: [
          BlocProvider<UserByCodeBloc>(create: (BuildContext context) => UserByCodeBloc(transactionRepository: transactionRepo),),
     ], 
      child: Scaffold(
      resizeToAvoidBottomInset: true,
      body:BlocBuilder<AppStateBloc, AppStateState>(
        builder: (context, state) {
        return  SlidingUpPanel(
        controller: panelController,
        minHeight:height*0.3 ,
        defaultPanelState: state.scannerPanelStateIsOpen== true ?  PanelState.OPEN: PanelState.CLOSED,
        maxHeight:height*0.8 ,
        parallaxEnabled: true,
        parallaxOffset:1,
        borderRadius:const BorderRadius.vertical(top:Radius.circular(10)),
        body: const ScannerPage(),
        panelBuilder: (controller) => QrPanel(
          scrollController: controller,
          panelController: panelController,
        ),
      );
        }
      ),
      ),
    );
  }
}