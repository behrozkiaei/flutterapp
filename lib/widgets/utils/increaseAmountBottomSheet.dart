import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/transaction/increase-wallet/increase-wallet.bloc.dart';
import 'package:paytel/blocs/transaction/increase-wallet/increase-wallet.event.dart';
import 'package:paytel/blocs/transaction/increase-wallet/increase-wallet.state.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';

class IncreaseAmountBottomSheet {
  static show(BuildContext context) async {
    String? amount;
    return await showModalBottomSheet(
        useSafeArea: true,
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: BlocProvider.of<IncreaseWalletBloc>(context),
            child: BlocListener<IncreaseWalletBloc, IncreaseWalletState>(
              listener: (context, state) async {
                if (state is IncreaseWalletFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("انتقال ناموفق بود",
                          style: TextStyle(color: Style.Colors.gray2)),
                      backgroundColor: Style.Colors.fail,
                    ),
                  );
                }
                if (state is IncreaseWalletSuccess) {
                  Navigator.pop(context, state.bankUrl.redirectUrl);
                }
              },
              child: Container(
                height: 700,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 10),
                      InputDecorationStyle(
                        icon: Icons.money,
                        type: "money",
                        label: "مبلغ به ریال",
                        onSave: (value) {},
                        initialValue: "",
                        autofocus: true,
                        onChange: (value) {
                          amount = value;
                          return (value);
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          final parentWidth = constraints.maxWidth;
                          return BlocBuilder<IncreaseWalletBloc,
                              IncreaseWalletState>(builder: (context, state) {
                            return StyledElevatedButton(
                                isLoading: state is IncreaseWalletLoading
                                    ? true
                                    : false,
                                disabled: state is IncreaseWalletLoading
                                    ? true
                                    : false,
                                width: parentWidth,
                                icon: Icons.check_box,
                                text: "تایید",
                                textColor: Style.Colors.white,
                                onPressed: () async {
                                  if (amount != null) {
                                    final String amountWithoutComma =
                                        amount!.replaceAll(",", "");
                                    BlocProvider.of<IncreaseWalletBloc>(context)
                                        .add(IncreaseWalletButtonPressed(
                                            amount: amountWithoutComma));
                                  } else {
                                    Navigator.pop(context, 1);
                                  }
                                });
                          });
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
