import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paytel/blocs/auth/me/me.bloc.dart';
import 'package:paytel/blocs/auth/me/me.state.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:paytel/style/theme.dart' as Style;


class QrPanel extends StatelessWidget {
  final ScrollController scrollController;
  final PanelController panelController;
  const QrPanel({super.key , required this.scrollController , required this.panelController});
 
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
        // const Padding(padding:EdgeInsets.symmetric(horizontal : 20)),
        const  SizedBox(height: 10),
        draggableButton(),
        const  SizedBox(height: 15),
        const  Text("کد QR برای انتقال به کیف پول شما"),
        const  SizedBox(height: 10),
        BlocBuilder<MeBloc, MeState>(
          builder: (context, state) {
            return 
            (state is MeSuccess) ?
              Center(
                          child:  PrettyQr(
                            image:const AssetImage('assets/icons/logo/p-logo-primary-boxed.png'),
                            typeNumber: 3,
                            size: 200,
                            data: 'paytel/${state.me!.wallet!.walletCode}',
                            errorCorrectLevel: QrErrorCorrectLevel.M,
                            roundEdges: true,
                          ),
                ): const  SpinKitThreeBounce(
                                             color: Style.Colors.primary,
                                              size: 15.0,
                                          );
            }),
          const  SizedBox(height: 15),
          BlocBuilder<MeBloc, MeState>(
          builder: (context, state) {
            return 
              (state is MeSuccess) ? Text("کد انتقال شما : ${state.me!.wallet!.walletCode}") : const SpinKitThreeBounce(
                                             color: Style.Colors.primary,
                                              size: 15.0,
                                          );
          }),
          InkWell(
            child: 
                Container(
                    margin: const EdgeInsets.all(10),
                    child:
                      StyledElevatedButton(
                          width: 130,
                          height: 40,
                          text: "کپی کد انتقال",
                          icon: Icons.copy,
                          textSize: 12,
                          textColor: Style.Colors.white,
                          onPressed: () async {
                              await Clipboard.setData(const ClipboardData(text: "your text")).
                                then((_){ ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content:   Text('کد شما کپی شد !' ),backgroundColor: Style.Colors.success,));
                              });
                            },
                          )
                  )
               )
           
           ]
          ),
    );
    
  }



   Widget draggableButton() => GestureDetector(
          onTap: togglePanel,
          child : Center(
                      child:SizedBox(width:30 , height : 5 ,
                      child:Container(decoration:const BoxDecoration(color:Style.Colors.primary,borderRadius:  BorderRadius.all(Radius.circular(10))) )  ,)
                      ),
      ); 
     void togglePanel()=> panelController.isPanelOpen ? panelController.close() : panelController.open();
}

