import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/app-state/app-state.bloc.dart';
import 'package:paytel/blocs/app-state/app-state.event.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/bill/chooseBilBootomSheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/enums.dart';

class HomePanelWidget extends StatelessWidget {
  const HomePanelWidget({super.key, required this.scrollController});

  final ScrollController scrollController;

  void _setMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("type", mode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          InkWell(
            onTap: () async {
              _setMode("charge");
              Navigator.pushNamed(context, "/sim-enter-phone");
            },
            child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    // color:Style.Colors.background ,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Style.Colors.primary)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/sim.png",
                      scale: 2,
                    ),
                    const SizedBox(height: 2),
                    const Text("خرید شارژ",
                        style: Style.TextStyling.primaryTextStyle)
                  ],
                )),
          ),
          InkWell(
            onTap: () async {
              // _setMode(Mode.internet.toString());
              final prefs = await SharedPreferences.getInstance();
              prefs.setString("type", 'internet');
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, "/sim-enter-phone");
            },
            child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Style.Colors.primary)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/internet.png", scale: 1.5),
                    const Text("خرید اینترنت",
                        style: Style.TextStyling.primaryTextStyle)
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              _setMode(Mode.bill.toString());
              ChooseBillType.show(context, (value) {
                if (value != null && value == BillType.mobile.toString()) {
                  Navigator.pushNamed(context, "/sim-enter-phone");
                }
                if (value != null && value == BillType.service.toString()) {
                  Navigator.pushNamed(context, "/bill-enter-id");
                }
              });
            },
            child: Stack(children: [
              Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Style.Colors.primary)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/bill.png",
                        scale: 10,
                      ),
                      const Text("پرداخت قبوض",
                          style: Style.TextStyling.primaryTextStyle)
                    ],
                  )),
              Positioned(
                top: 1,
                right: 1,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "به زودی",
                    style:
                        TextStyle(fontSize: 8, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ]),
          ),
        ]),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/payment-requests");
            },
            child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Style.Colors.primary)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/cashback.png",
                      scale: 1.75,
                    ),
                    const Text("درخواست تسویه",
                        style: TextStyle(
                            color: Style.Colors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            fontFamily: "IRANSansWeb"))
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<AppStateBloc>(context)
                  .add(const PageIndex(pageIndex: 1));
            },
            child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Style.Colors.primary)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/taxi.png",
                      scale: 1.5,
                    ),
                    const Text("پرداخت تاکسی",
                        style: TextStyle(
                            color: Style.Colors.primary,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            fontFamily: "IRANSansWeb"))
                  ],
                )),
          ),
          const SizedBox(
            width: 80,
            height: 80,
          ),
        ]),
      ]),
    );
  }
}
