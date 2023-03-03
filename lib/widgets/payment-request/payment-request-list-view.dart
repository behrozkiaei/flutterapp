import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.state.dart';
import 'package:paytel/models/payment-requests-model.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:paytel/style/theme.dart' as Style;
class PaymentRequestListView extends StatefulWidget {
  const PaymentRequestListView({super.key});

  @override
  State<PaymentRequestListView> createState() => _PaymentRequestListViewState();
}

class _PaymentRequestListViewState extends State<PaymentRequestListView> {
  bool loading =false;

  @override
  Widget build(BuildContext context) {
      final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return  MultiBlocListener(
      listeners: [
           BlocListener<PaymentRequestListBloc,PaymentRequestState >(
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
      BlocListener<DeletePaymentRequestBloc,PaymentRequestState >(
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
      child: Scaffold(

      body: SafeArea(child: 
      SizedBox.shrink(
        child: SizedBox.shrink(
          child:BlocBuilder<PaymentRequestListBloc, PaymentRequestState>(
          builder: (context, state) {
            return 


              (state is PaymentRequestListSuccess) ?
                        ListView(
                            scrollDirection: Axis.vertical,
                            physics:  const BouncingScrollPhysics(),
                            children:
                            List.generate(state.paymentRequests.length, (index) {
                            PaymentRequestModel value = state.paymentRequests[index];
                              return
                              
                              Padding(padding:const  EdgeInsets.symmetric(vertical: 5),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, '/internet-prereceipt', arguments:value );
                                  },
                                  child: Row(
                                  mainAxisAlignment:  MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:  [
                                    Padding(padding: const EdgeInsets.only(right: 10),
                                    child:
                                    Container(
                                        width: 50,
                                        height: 60,
                                        decoration: const BoxDecoration( shape: BoxShape.circle,    
                                            color: Style.Colors.gray2                                      
                                          ),
                                        child:Image.asset("assets/icons/internet.png",scale:10,), 
                                      ),),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: width*0.6,
                                      child:
                                      Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                  
                                        Text( '${value.date}',
                                                  style: const TextStyle(fontFamily: 'IRANSansWeb'), ), 
                                        Text("${addCommas(value.amount.toString())} ریال", style:const  TextStyle(fontSize: 14.0,color: Style.Colors.gray1)),  
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child:Container(
                                    margin: const EdgeInsets.only(left: 10),
                                      alignment: Alignment.centerLeft,
                                      child: 
                                        const Icon(Icons.arrow_forward),
                                      ),
                                  ), 
                                ],
                              ),
                            ),
                          );    
                          })
                        )
                        :const  Center(child: Text("هیچ سابقه ای نیست"));
                  }),
              ),
             ),
          ),
      ),
    );
  }
}


      
       