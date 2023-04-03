import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.event.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.state.dart';
import 'package:paytel/models/payment-requests-model.dart';
import 'package:paytel/widgets/utils/confirmBottomSheet.dart';
import 'package:paytel/widgets/utils/enums.dart';
import 'package:paytel/widgets/utils/increaseAmountBottomSheet.dart';
import 'package:paytel/widgets/utils/timeUtil.dart';
import 'package:paytel/widgets/utils/toPersianDate.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:paytel/style/theme.dart' as Style;

class PaymentRequestListView extends StatefulWidget {
  const PaymentRequestListView({super.key});

  @override
  State<PaymentRequestListView> createState() => _PaymentRequestListViewState();
}

class _PaymentRequestListViewState extends State<PaymentRequestListView> {
  bool loading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PaymentRequestListBloc>(context)
        .add(const GetAllPaymentRequestButtonPressed());
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentRequestListBloc, PaymentRequestState>(
            listener: (context, state) async {
          if (state is PaymentRequestLoading) {
            setState(() {
              loading = true;
            });
          } else {
            setState(() {
              loading = false;
            });
          }
        }),
        BlocListener<DeletePaymentRequestBloc, PaymentRequestState>(
            listener: (context, state) async {
          if (state is PaymentRequestSuccess) {
            BlocProvider.of<PaymentRequestListBloc>(context)
                .add(const GetAllPaymentRequestButtonPressed());
          }
          if (state is PaymentRequestLoading) {
            setState(() {
              loading = true;
            });
          } else {
            setState(() {
              loading = false;
            });
          }
        }),
      ],
      child: Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: BlocBuilder<PaymentRequestListBloc, PaymentRequestState>(
                builder: (context, state) {
              return (state is PaymentRequestListSuccess)
                  ? (state.paymentRequests.isNotEmpty)
                      ? ListView(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          children: List.generate(state.paymentRequests.length,
                              (index) {
                            PaymentRequestModel value =
                                state.paymentRequests[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/internet-prereceipt',
                                      arguments: value);
                                },
                                child: SizedBox(
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 60,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Style.Colors.gray2),
                                        child: const Icon(
                                          Icons.credit_card,
                                          color: Style.Colors.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${addCommas(value.amount.toString())} ریال",
                                              style: const TextStyle(
                                                  fontSize: 13.0)),
                                          ToPersianDate(
                                            y: DateUtil.getYear(value.date!),
                                            m: DateUtil.getMonth(value.date!),
                                            d: DateUtil.getDay(value.date!),
                                            style: const TextStyle(
                                                color: Style.Colors.gray1,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 70,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                      .all(
                                                                  Radius.circular(
                                                                      10)),
                                                          color: value.state ==
                                                                  CashbackState
                                                                      .PENDING
                                                                      .name
                                                              ? Style
                                                                  .Colors.alert
                                                              : value.state ==
                                                                      CashbackState
                                                                          .DONE
                                                                          .name
                                                                  ? Style.Colors
                                                                      .success
                                                                  : Style.Colors
                                                                      .fail),
                                                      child: Center(
                                                        child: Text(
                                                          value.state ==
                                                                  CashbackState
                                                                      .PENDING
                                                                      .name
                                                              ? 'در انتظار'
                                                              : value.state ==
                                                                      CashbackState
                                                                          .DONE
                                                                          .name
                                                                  ? "انجام شد"
                                                                  : 'رد شده ',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Style
                                                                      .Colors
                                                                      .gray2),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        final bool res =
                                                            await ConfirmBottomSheet
                                                                .show(context);
                                                        if (res) {
                                                          try {
                                                            if (!mounted) {
                                                              return;
                                                            }
                                                            BlocProvider.of<
                                                                        DeletePaymentRequestBloc>(
                                                                    context)
                                                                .add(DeletePaymentRequestButtonPressed(
                                                                    id: value
                                                                        .id!));
                                                          } catch (e) {
                                                            throw Exception(
                                                                'Could not launch');
                                                          }
                                                        } else {}
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color:
                                                            Style.Colors.gray1,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ]),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }))
                      : const SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                              heightFactor: 20,
                              child: Text('هیچ درخواستی وجود ندارد')))
                  : const SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                          child: SpinKitThreeBounce(
                        color: Style.Colors.primary,
                        size: 12.0,
                      )));
            }),
          ),
        ),
      ),
    );
  }
}
