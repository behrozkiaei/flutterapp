import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:paytel/blocs/app-state/app-state.bloc.dart';
import 'package:paytel/blocs/app-state/app-state.event.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.bloc.dart';
import 'package:paytel/blocs/transaction/my-transaction/my-transactions.event.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.bloc.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.event.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.state.dart';
import 'package:paytel/models/transaction/my-transactions.dart';
import 'package:paytel/models/transaction/users-by-code-model.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/AmountBottomSheet.dart';
import 'package:paytel/widgets/utils/avatar-title-sub.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/network-image-provider.dart';
import 'package:paytel/widgets/utils/paymentType.dart';
import 'package:paytel/widgets/utils/receiptDetail.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const.dart' as conf;

class TransferPrereceipt extends StatefulWidget {
  final UserByCode toUser;
  final String amount;
  const TransferPrereceipt(
      {super.key, required this.amount, required this.toUser});
  @override
  State<TransferPrereceipt> createState() => _TransferPrereceipt();
}

class _TransferPrereceipt extends State<TransferPrereceipt> {
  List<Desc> descList = [];
  bool loading = false;
  String? amount;
  bool? isWallet;

  @override
  void initState() {
    setState(() {
      amount = widget.amount;
    });
    setState(() {
      descList = [
        Desc(key: "شماره ولت کاربر", value: widget.toUser.code),
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<Wallet2WalletBloc, Wallet2WalletState>(
            listener: (context, state) async {
          if (state is Wallet2WalletFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("مشکل در انتقال رخ داده است",
                    style: TextStyle(color: Style.Colors.gray2)),
                backgroundColor: Style.Colors.fail,
              ),
            );
          }
          if (state is Wallet2WalletLoading) {
            setState(() {
              loading = true;
            });
          } else {
            setState(() {
              loading = false;
            });
          }
          if (state is Wallet2WalletSuccess) {
            if (state.RedirectURL != null) {
              try {
                await launchUrl(Uri.parse(state.RedirectURL!),
                    mode: LaunchMode.externalApplication);
              } catch (e) {
                throw Exception('Could not launch');
              }
            } else {
              BlocProvider.of<MyTransactionsBloc>(context)
                  .add(const MyTransactionsButtonPressed(page: 0));
              await Future.delayed(const Duration(seconds: 1));
              if (!mounted) {
                return;
              }
              Navigator.pushNamed(context, "/home");
              BlocProvider.of<AppStateBloc>(context)
                  .add(const PageIndex(pageIndex: 2));
            }
          }
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Style.Colors.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20.0),
                AvatarTitleSub(
                    avatarUrl: widget.toUser.avatar != null
                        ? NetworkImageProvider(
                            '${conf.Config.baseUrl}/${widget.toUser.avatar!}',
                            cacheManager: DefaultCacheManager())
                        : const AssetImage('assets/icons/user.png'),
                    title: widget.toUser.name ?? 'نامشخص',
                    subTitle: 'مبلغ انتقال: ${addCommas(amount!)}'),
                const SizedBox(height: 15.0),
                TextButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith((states) {
                    return Style.Colors.background;
                  }), textStyle: MaterialStateProperty.resolveWith((states) {
                    return const TextStyle(
                        color: Style.Colors.primary, fontFamily: "IRANSansWeb");
                  })),
                  onPressed: () async {
                    String amountNew = await AmountBottomSheet.show(context);
                    if (amountNew != "") {
                      setState(() {
                        amount = amountNew;
                      });
                    }
                  },
                  child: const Text("تغییر مبلغ",
                      style: TextStyle(color: Style.Colors.primary)),
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  height: descList.length * 40,
                  child: ReceiptDetail(list: descList),
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 160,
                      child: PaymentTypeChooser(),
                    ),
                    const SizedBox(height: 10.0),
                    StyledElevatedButton(
                      width: double.maxFinite,
                      icon: Icons.check_box,
                      text: "تایید انتقال",
                      isLoading: loading,
                      disabled: loading,
                      textColor: Style.Colors.white,
                      onPressed: () async {
                        if (amount != null) {
                          final String amountWithoutComma =
                              amount!.replaceAll(",", "");
                          final prefs = await SharedPreferences.getInstance();
                          final fromWallet = prefs.getBool("isWallet") ?? true;
                          if (!mounted) {
                            return;
                          }
                          BlocProvider.of<Wallet2WalletBloc>(context).add(
                              Wallet2WalletButtonPressed(
                                  walletCode: widget.toUser.code!,
                                  fromWallet: fromWallet,
                                  amount: amountWithoutComma));
                        }
                      },
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonStyleCustom {
  bool? isActive;

  static TextStyle textStyle(isActive) {
    return TextStyle(
        color: isActive ? Style.Colors.white : Style.Colors.gray1,
        fontSize: 12);
  }
}
