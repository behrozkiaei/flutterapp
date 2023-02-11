import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytell/widgets/scaner/qrPanel.dart';
import 'package:paytell/widgets/scaner/scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Transfer extends StatelessWidget {
  final panelController =  PanelController();

  Transfer({super.key});
  // const Transfer({super.key});
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
    );
  }
}