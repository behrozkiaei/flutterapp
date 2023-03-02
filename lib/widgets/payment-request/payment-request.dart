import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.state.dart';
import 'package:paytel/blocs/user/update-national-card/update-avatar.bloc.dart';
import 'package:paytel/blocs/user/update-national-card/update-avatar.state.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:paytel/repositories/transactions.repository.dart';
import 'package:paytel/widgets/payment-request/addPagePaymentRequest.dart';
import 'package:paytel/widgets/payment-request/payment-request-list-view.dart';

class PaymentRequest extends StatefulWidget {
  const PaymentRequest({super.key});

  @override
  State<PaymentRequest> createState() => _PaymentRequestState();
}

class _PaymentRequestState extends State<PaymentRequest> {

  final transactionRepo = TransactionRepo();
  bool loading =false;
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
          BlocProvider<PaymentRequestBloc>(create: (BuildContext context) => PaymentRequestBloc( transactionRepo: transactionRepo)),
          BlocProvider<PaymentRequestListBloc>(create: (BuildContext context) => PaymentRequestListBloc(transactionRepo: transactionRepo),),
          BlocProvider<DeletePaymentRequestBloc>(create: (BuildContext context) => DeletePaymentRequestBloc(transactionRepo: transactionRepo),),
          ],
          
      child : Scaffold(
      body: SafeArea(child: 
      Stack(
        children : [
          const PaymentRequestListView(),
          Column(children: const [
            AddPaymentRequest()
          ],)
          ]
         ),
       ),
      ),
    );
  }
}