import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.state.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';

class AddPaymentRequest extends StatefulWidget {
  const AddPaymentRequest({super.key});

  @override
  State<AddPaymentRequest> createState() => _AddPaymentRequestState();
}

class _AddPaymentRequestState extends State<AddPaymentRequest> {
  bool loading =false;

  @override
  Widget build(BuildContext context) {
    return    MultiBlocListener(
      listeners: [
      BlocListener<PaymentRequestBloc,PaymentRequestState >(
            listener: (context, state) async {
                if(state is PaymentRequestLoading){
                  setState(() {
                    loading=true;
                  });
                } else{
                    setState(() {
                    loading=false;
                  });
                }
            }
      ),
      ],
      child: SizedBox.shrink(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StyledElevatedButton(
            isLoading: loading,
            disabled: loading,
            onPressed: (){

            //open mount bottom sheeet


            //trigger payment request



          }, width: 50, text: "درخواست تسویه")
        ],
      ),
      ),
    );
  }
}

