import 'package:flutter/material.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentTypeChooser extends StatefulWidget {
  const PaymentTypeChooser({super.key});
  @override
  State<PaymentTypeChooser> createState() => _PaymentTypeChooserState();
}

class _PaymentTypeChooserState extends State<PaymentTypeChooser> {
  int  selectedIndex = 0 ;
 setPaymentModeWallet(value) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool("isWallet",value) ;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: 
      Padding(padding: const EdgeInsets.all(0),
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration : BoxDecoration(
                border: Border.all(
                  // color: Style.Colors.gray1,
                  color: selectedIndex == 0 ? Style.Colors.primary : Style.Colors.gray2,
                  width: 1
                ),
              borderRadius: BorderRadius.circular(10)
            ),
            child:  InkWell(
                  onTap: (){
                    setState(() {
                      selectedIndex= 0;
                    });
                    setPaymentModeWallet(true);
                  },
                  child :
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                        
                            SizedBox(width: 60,height: 60,child: 
                             activeCircleAvatarForWallet(selectedIndex==0,Icons.wallet)
                          ),
                          const SizedBox(width: 10),
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:   [
                              const Text("پرداخت از اعتبار کیف پول"),
                              RichText(text:
                              const TextSpan(
                                  style:  TextStyle(fontSize: 11 , fontFamily: "IRANSansWeb",color: Style.Colors.gray1),
                                  children:  <TextSpan>[
                                     TextSpan(text: ' موجودی :'),
                                    TextSpan(text: "20,000",style:   TextStyle(fontWeight: FontWeight.bold , color: Style.Colors.primary)),
                                     TextSpan(text:  " ریال"  ),
                                    ],
                                  ),
                              ),
                            ]
                          ),
                    ]),
                ),
                ),
          const SizedBox(height: 8,),
          Container(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  decoration : BoxDecoration(
                     border: Border.all(
                  // color: Style.Colors.gray1,
                  color: selectedIndex == 1 ? Style.Colors.primary : Style.Colors.gray2,
                  width: 1
                ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child:
                InkWell(
                  onTap: (){
                      setState(() {
                      selectedIndex= 1;
                    });
                    setPaymentModeWallet(false);
                    // _registerOperator("MCI");
                    // Navigator.pop(context, "MCI");
                  },
                  child :
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                        
                            SizedBox(width: 60,height: 60,child: 
                               activeCircleAvatarForCredit(selectedIndex==1,Icons.card_membership)
                            ),
                          const SizedBox(width: 10),
                           Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:   [
                              const Text("پرداخت با کارت بانکی"),
                              RichText(text:
                              const TextSpan(
                                  style:  TextStyle(fontSize: 11 , fontFamily: "IRANSansWeb",color: Style.Colors.gray1),
                                  children:  <TextSpan>[
                                     TextSpan(text: ' کارمزد :'),
                                    TextSpan(text: "کارمزد درگاه بانکی",style:   TextStyle(fontWeight: FontWeight.bold , color: Style.Colors.primary)),
                                    ],
                                  ),
                              ),
                            ]
                          ),
                    ]),
                )
                )
                ],
            ),
            ),
      );
                
  }
  Widget activeCircleAvatarForWallet(isActive,icon){
    return  isActive ? const CircleAvatar(
                                backgroundColor: Style.Colors.gray2,
                                    radius: 50.0,
                                child:  Icon(Icons.check_box ,color: Style.Colors.primary ,),
                              ):const CircleAvatar(
                                backgroundColor: Style.Colors.gray2,
                                    radius: 50.0,
                                child:  Icon(Icons.mobile_friendly,color: Style.Colors.gray1),
                              );
                            
  }
  Widget activeCircleAvatarForCredit(isActive,icon){
    return  isActive ? const CircleAvatar(
                                backgroundColor: Style.Colors.gray2,
                                    radius: 50.0,
                                child:  Icon(Icons.check_box ,color: Style.Colors.primary ,),
                              ):const CircleAvatar(
                                backgroundColor: Style.Colors.gray2,
                                    radius: 50.0,
                                child:  Icon(Icons.credit_card,color: Style.Colors.gray1),
                              );
                            
  }
}