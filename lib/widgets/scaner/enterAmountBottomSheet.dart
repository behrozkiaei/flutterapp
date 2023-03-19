import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/app-state/app-state.bloc.dart';
import 'package:paytel/blocs/app-state/app-state.event.dart';
import 'package:paytel/blocs/auth/me/me.bloc.dart';
import 'package:paytel/blocs/auth/me/me.event.dart';
import 'package:paytel/blocs/transaction/get-user-info-by-code/get-user-by-code.bloc.dart';
import 'package:paytel/blocs/transaction/get-user-info-by-code/get-user-by-code.state.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.bloc.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.event.dart';
import 'package:paytel/blocs/transaction/wallet-to-wallet-transfer/wallet2wallet.state.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:paytel/widgets/utils/little-avatar-title.dart';
import 'package:persian_tools/persian_tools.dart';

class EnterAmountBottomSheet {

  static void show(BuildContext context ) async {
   String? amount;
   return await showModalBottomSheet(
    useSafeArea: true,
      context: context,
      builder: (_) {
        return BlocProvider.value(
         value: BlocProvider.of<UserByCodeBloc>(context),
         child:BlocProvider.value(
         value: BlocProvider.of<MeBloc>(context),
         child: BlocProvider.value(
         value: BlocProvider.of<Wallet2WalletBloc>(context),
         child: BlocListener<Wallet2WalletBloc, Wallet2WalletState>(
          listener: (context, state) {
          if (state is Wallet2WalletFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("انتقال ناموفق بود",style :TextStyle(color: Style.Colors.gray2)),
                  backgroundColor: Style.Colors.fail,

                ),
              );
              //  Navigator.pop(context, false);
            }
            if(state is Wallet2WalletSuccess){
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("انتقال موفق بود",style :TextStyle(color: Style.Colors.gray2)),
                  backgroundColor: Style.Colors.success,
                ),

              );
              BlocProvider.of<MeBloc>(context).add(StartFetchMe());
              BlocProvider.of<AppStateBloc>(context).add(const PageIndex(pageIndex: 2));
              Navigator.pop(context, "");
            }
      },
      child:
         Container(
          height: 700,
          decoration:const  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(padding: const EdgeInsets.all(10),
           child :Column(
            children: <Widget>[
              BlocBuilder<UserByCodeBloc, UserByCodeState>(
              builder: (context, state) {
                if (state is UserByCodeSuccess){
                  // return const SizedBox(width: 5);
                 
                  return AvatarTitle(avatar: state.user.avatar ??"",title: state.user.username?? "");
                }else{
                  return const SizedBox(width: 5);
                }
              }),
              const SizedBox(height: 10),
              InputDecorationStyle(
                icon: Icons.money,
                type: "money",
                label: "مبلغ به ریال",
                onSave : (value){},
                initialValue: "",
                autofocus: true,
                onChange: (value){
                  amount = value;
                  return addCommas(value);
                },
              ),
              Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: 
                    LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        final parentWidth = constraints.maxWidth;
                        return BlocBuilder<Wallet2WalletBloc, Wallet2WalletState>(
                         builder: (context, walletState) {
                           return BlocBuilder<UserByCodeBloc, UserByCodeState>(
                           builder: (context, state) {
                            if (state is UserByCodeSuccess){
                              return StyledElevatedButton(
                              isLoading: walletState is Wallet2WalletLoading ? true :false ,
                              disabled: walletState is Wallet2WalletLoading ? true :false ,
                              width:parentWidth ,
                              icon : Icons.check_box ,
                              text :"تایید",
                              textColor: Style.Colors.white,
                              onPressed: () async {

                                  if(amount != null ){
                                    final String amountWithoutComma = amount!.replaceAll(",", "");
                                    BlocProvider.of<Wallet2WalletBloc>(context).add(Wallet2WalletButtonPressed(walletCode: state.user.code!, amount: amountWithoutComma));
                                    
                                  }else{
                                    Navigator.pop(context, 1);
                                  }
                                }
                              );
                            }else{
                              return const  SizedBox(height: 2,);
                            }
                          }
                          );
                         }
                        );
                      }),
                    ),
                  ],
            ),
          ),
          ),
          ),
          ),
          ),
        );
      },
    );
  }
}