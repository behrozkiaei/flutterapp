import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paytel/blocs/services/internet-packages/internet-packages.bloc.dart';
import 'package:paytel/blocs/services/internet-packages/internet-packages.event.dart';
import 'package:paytel/blocs/services/internet-packages/internet-packages.state.dart';
import 'package:paytel/models/internet-packages-model.model.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/simcard/chooseChargeAmount.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntertetPackages extends StatefulWidget {
  const IntertetPackages({super.key});

  @override
  State<IntertetPackages> createState() => _IntertetPackagesState();
}

class _IntertetPackagesState extends State<IntertetPackages> {
  List<InternetPackagesModel>? internetPackages;
  String? operator;
  String? sim_type;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _getStoredValue();
  }

  _changeState(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  _getStoredValue() async {
    final prefs = await SharedPreferences.getInstance();
    final String _operator = prefs.getString("operator") ?? "";
    final String _sim_type = prefs.getString("sim_type") ?? "";
    setState(() {
      operator = _operator;
      sim_type = _sim_type;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return BlocListener<InternetPackagesBloc, InternetPackagesState>(
      listener: (context, state) {
        if (state is InternetPackagesInitial) {
          BlocProvider.of<InternetPackagesBloc>(context)
              .add(const InternetPackagesButtonPressed());
        }
        if (state is InternetPackagesSuccess) {
          internetPackages = state.internetPackages;
        }
      },
      child: Scaffold(
          body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          child: BlocBuilder<InternetPackagesBloc, InternetPackagesState>(
              builder: (context, state) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                      width: width,
                      height: 30,
                      child: (state is InternetPackagesSuccess)
                          ? ListView(
                              scrollDirection: Axis.horizontal,
                              children: state.internetPackages != null
                                  ? List.generate(state.internetPackages.length,
                                      (index) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        height: 30,
                                        width: 90,
                                        child: ElevatedButton(
                                          style: StyledElevatedButton
                                              .buttonTinyStyle(
                                                  selectedIndex == index),
                                          child: Text(
                                              state.internetPackages[index]
                                                      .key ??
                                                  "",
                                              style:
                                                  ButtonStyleCustom.textStyle(
                                                      selectedIndex == index)),
                                          onPressed: () {
                                            _changeState(index);
                                          },
                                        ),
                                      );
                                    })
                                  : [const SizedBox.shrink()],
                            )
                          : const Center(child: Text("بسته ای موجود نیست"))),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: (state is InternetPackagesLoading)
                        ? const SpinKitThreeBounce(
                            color: Style.Colors.primary,
                            size: 12.0,
                          )
                        : (state is InternetPackagesSuccess)
                            ? state.internetPackages[selectedIndex] != null &&
                                    state.internetPackages[selectedIndex].value!
                                        .isNotEmpty
                                ? ListView(
                                    scrollDirection: Axis.vertical,
                                    physics: const BouncingScrollPhysics(),
                                    children: List.generate(
                                        state.internetPackages[selectedIndex]
                                            .value!.length, (index) {
                                      Value value = state
                                          .internetPackages[selectedIndex]
                                          .value![index];
                                      bool shouldInclude =
                                          (value.valueOperator == operator &&
                                              value.simType == sim_type);
                                      if (shouldInclude) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  '/internet-prereceipt',
                                                  arguments: value);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Container(
                                                    width: 50,
                                                    height: 60,
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Style
                                                                .Colors.gray2),
                                                    child: Image.asset(
                                                      "assets/icons/internet.png",
                                                      scale: 2,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                SizedBox(
                                                  width: width * 0.6,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${value.name} ${value.volume} ${value.unit}',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'IRANSansWeb'),
                                                      ),
                                                      Text(
                                                          "${addCommas(value.amount.toString())} ریال",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  color: Style
                                                                      .Colors
                                                                      .gray1)),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: const Icon(
                                                        Icons.arrow_forward),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return SizedBox(height: 0);
                                      }
                                    }))
                                : const Center(child: Text("هیچ بسته ای نیست"))
                            : const Center(
                                child: Text('خطا در برقراری سرویس رخ داده است'),
                              ),
                  ),
                ]);
          }),
        ),
      )),
    );
  }
}
