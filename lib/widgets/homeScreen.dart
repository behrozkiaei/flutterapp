import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytell/widgets/SendReceiveBox.dart';
import 'package:paytell/widgets/panels/homePanel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: SlidingUpPanel(
        body: const SendReceivePage(),
        panelBuilder: (controller) => HomePanelWidget(
          scrollController: controller,
        ),
      ),
    );
  }
}

