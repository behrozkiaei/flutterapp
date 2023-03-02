import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.bloc.dart';
import 'package:paytel/blocs/user/payment-request/payment-request.state.dart';

class PaymentRequestListView extends StatefulWidget {
  const PaymentRequestListView({super.key});

  @override
  State<PaymentRequestListView> createState() => _PaymentRequestListViewState();
}

class _PaymentRequestListViewState extends State<PaymentRequestListView> {
  bool loading =false;
  @override
  Widget build(BuildContext context) {
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
      child:const Scaffold(

      body: SafeArea(child: 
      SizedBox.shrink(
        child: SizedBox.shrink(),
        //  ListView(
                //             scrollDirection: Axis.vertical,
                //             physics:  const BouncingScrollPhysics(),
                //             children:
                //             List.generate(state.internetPackages[selectedIndex].value!.length, (index) {
                //             Value value = state.internetPackages[selectedIndex].value![index];
                //             bool shouldInclude = (value.valueOperator == operator && value.simType == sim_type);
                //             if(shouldInclude){
                //               return Padding(padding:const  EdgeInsets.symmetric(vertical: 5),
                //                 child: InkWell(
                //                   onTap: (){
                //                     Navigator.pushNamed(context, '/internet-prereceipt', arguments:value );
                //                   },
                //                   child: Row(
                //                   mainAxisAlignment:  MainAxisAlignment.start,
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children:  [
                //                    Padding(padding: const EdgeInsets.only(right: 10),
                //                    child:
                //                     Container(
                //                         width: 50,
                //                         height: 60,
                //                         decoration: const BoxDecoration( shape: BoxShape.circle,    
                //                             color: Style.Colors.gray2                                      
                //                           ),
                //                         child:Image.asset("assets/icons/internet.png",scale:10,), 
                //                       ),),
                //                     const SizedBox(width: 10),
                //                     SizedBox(
                //                       width: width*0.6,
                //                       child:
                //                       Column(
                //                       mainAxisAlignment: MainAxisAlignment.start,
                //                       crossAxisAlignment: CrossAxisAlignment.start,
                //                       children: [
                                  
                //                         Text( '${value.name} ${value.volume} ${value.unit}',
                //                                   style: const TextStyle(fontFamily: 'IRANSansWeb'), ), 
                //                         Text("${addCommas(value.amount.toString())} ریال", style:const  TextStyle(fontSize: 14.0,color: Style.Colors.gray1)),
                                      
                //                     ],),
                //                     ),
                //                     Expanded(
                //                       child:Container(
                //                         margin: const EdgeInsets.only(left: 10),
                //                           alignment: Alignment.centerLeft,
                //                           child: 
                //                             const Icon(Icons.arrow_forward),
                //                           ),
                //                         ), 
                //                   ],
                //                 ),
                //                 ),
                //               );    
                //             }else{
                //               return SizedBox(height: 0);
                //             }
                //           })
                // ):const  Center(child: Text("هیچ بسته ای نیست")),
      )
      ),
      ),
      
      );
  }
}