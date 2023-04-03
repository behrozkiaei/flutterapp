import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.event.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.state.dart';
import 'package:paytel/widgets/utils/AmountBottomSheet.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';

class AddPaymentRequest extends StatefulWidget {
  const AddPaymentRequest({super.key});

  @override
  State<AddPaymentRequest> createState() => _AddPaymentRequestState();
}

class _AddPaymentRequestState extends State<AddPaymentRequest> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentRequestBloc, PaymentRequestState>(
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
          if (state is PaymentRequestSuccess) {
            BlocProvider.of<PaymentRequestListBloc>(context)
                .add(const GetAllPaymentRequestButtonPressed());
          }
        }),
      ],
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            alignment: Alignment.bottomCenter,
            child: StyledElevatedButton(
                icon: Icons.add,
                isLoading: loading,
                disabled: loading,
                onPressed: () async {
                  //open bottomSehhet add amount
                  final value = await AmountBottomSheet.show(context);
                  print(value);
                  if (value != null) {
                    try {
                      if (!mounted) {
                        return;
                      }
                      BlocProvider.of<PaymentRequestBloc>(context)
                          .add(PaymentRequestButtonPressed(amount: value));
                    } catch (e) {
                      throw Exception('Could not launch');
                    }
                  } else {}
                },
                width: 170,
                text: "درخواست تسویه")),
      ),
    );
  }
}
