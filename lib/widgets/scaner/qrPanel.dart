import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Column(
      children: [
      // const Padding(padding:EdgeInsets.symmetric(horizontal : 20)),
      const  SizedBox(height: 10),
      draggableButton(),
      const  SizedBox(height: 15),
      const  Text("کد QR برای انتقال به کیف پول شما"),
      const  SizedBox(height: 10),
      Center(
                  child:  PrettyQr(
                    image:const AssetImage('assets/icons/logo/p-logo-primary-boxed.png'),
                    typeNumber: 3,
                    size: 200,
                    data: '123345665',
                    errorCorrectLevel: QrErrorCorrectLevel.M,
                    roundEdges: true,
                  ),
        ),
        const  SizedBox(height: 15),
        const  Text("کد انتقال شما : 12873987587"),
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

