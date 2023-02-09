import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytell/widgets/panels/transactions.dart';
import 'package:paytell/widgets/receipe.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  final panelController =  PanelController();
   @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SlidingUpPanel(
        
        controller: panelController,
        minHeight:height*0.2 ,
        maxHeight:height*0.9 ,
        parallaxEnabled: true,
        parallaxOffset:1.3,
        borderRadius:const BorderRadius.vertical(top:Radius.circular(10)),
        body: const Receipt(),
        panelBuilder: (controller) => TransactionsPanel(
          scrollController: controller,
          panelController: panelController,
        ),
      ),
    );
  }
}