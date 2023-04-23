import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paytel/blocs/app-state/app-state.bloc.dart';
import 'package:paytel/blocs/app-state/app-state.event.dart';
import 'package:paytel/blocs/auth/me/me.bloc.dart';
import 'package:paytel/blocs/auth/me/me.state.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/increaseAmountBottomSheet.dart';
import 'package:paytel/widgets/utils/mainPageIconButton.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:url_launcher/url_launcher.dart';

class SendReceivePage extends StatelessWidget {
  const SendReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return 
      Scaffold(
        backgroundColor: Style.Colors.primary,
        body: 
        // SafeArea(
        //   child:
          
          Stack(children: [ 
                const  SizedBox.expand(
                    child:  DecoratedBox(
                      decoration:  BoxDecoration(
                        color: Style.Colors.tertiary
                      ),
                    ) ,
                  ),
          SvgPicture.asset("assets/icons/scattered-forcefields.svg",
          color: const Color.fromARGB(100, 255, 255, 255),
          height: 500, fit: BoxFit.fill, alignment: Alignment.topCenter),
           Padding( 
               padding: const EdgeInsets.symmetric(vertical: 40 , horizontal: 10),
               child: Column(children: [
                 Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: const [
                       Icon(
                         EvaIcons.home,
                         color: Style.Colors.background,
                       ),
                       Text("خانه",
                           style: TextStyle(
                               color: Style.Colors.background,
                               fontFamily: "IRANSansWeb")),
                       Icon(EvaIcons.messageCircle,
                           color: Style.Colors.background),
                     ]),
                 const SizedBox(height: 20, width: 30),
                 BlocBuilder<MeBloc, MeState>(builder: (context, state) {
                   if (state is MeSuccess) {
                     return SizedBox(
                         height: 30,
                         child: Text(
                           '${addCommas(state.me!.wallet!.amount.toString())} ریال',
                           style: const TextStyle(
                               color: Style.Colors.background,
                               fontSize: 18,
                               fontWeight: FontWeight.bold),
                         ));
                   } else {
                     return const SizedBox(
                         height: 30,
                         child: SpinKitThreeBounce(
                           color: Style.Colors.white,
                           size: 12.0,
                         ));
                   }
                 }),
                 const Text("موجودی",
                     style:  TextStyle(
                         color: Style.Colors.background, fontSize: 10)),
                 const SizedBox(height: 30, width: 15),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     InkWell(
                       onTap: () async {
                         final value =
                             await IncreaseAmountBottomSheet.show(context);
                         if (value != null) {
                           try {
                             await launchUrl(Uri.parse(value),
                                 mode: LaunchMode.externalApplication);
                           } catch (e) {
                            //  throw Exception('Could not launch');
                           }
                         } else {}
                       },
                       child: const MainPageIcons(
                           iconSize: 40,
                           iconColor: Style.Colors.primary,
                           icon: CupertinoIcons.add,
                           iconBackgroundColor: Style.Colors.background,
                           text: "افزایش موجودی",
                           textSize: 10,
                           textColor: Style.Colors.background),
                     ),
                     InkWell(
                       onTap: () async {
                         BlocProvider.of<AppStateBloc>(context)
                             .add(const PageIndex(pageIndex: 1));
                       },
                       child: const MainPageIcons(
                           iconSize: 40,
                           iconColor: Style.Colors.primary,
                           icon: CupertinoIcons.arrow_up,
                           iconBackgroundColor: Style.Colors.background,
                           text: "ارسال",
                           textSize: 10,
                           textColor: Style.Colors.background),
                     ),
                     InkWell(
                       onTap: () {
                         BlocProvider.of<AppStateBloc>(context).add(
                             const ChangeScannerPanelState(
                                 isScannerPanelOpen: true));
                         BlocProvider.of<AppStateBloc>(context)
                             .add(const PageIndex(pageIndex: 1));
                       },
                       child: const MainPageIcons(
                           iconSize: 40,
                           iconColor: Style.Colors.primary,
                           icon: CupertinoIcons.money_dollar,
                           iconBackgroundColor: Style.Colors.background,
                           text: "دریافت",
                           textSize: 10,
                           textColor: Style.Colors.background),
                     ),
                   ], 
                 )
               ])
               ),
               
          ]),
        // ), 
      );
  }
}
