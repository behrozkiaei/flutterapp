import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytel/presentations/auth/otpWidget.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/simcard/chooseOperator.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EnterBillId extends StatefulWidget {
  const EnterBillId({super.key});

  @override
  State<EnterBillId> createState() => _EnterBillIdState();
}

class _EnterBillIdState extends State<EnterBillId> {

  // final _storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  String? _billid;
  String? mode ; //   "internet , charge , bill"
    @override
    void initState() {
      super.initState();
      _getMode();
    }

    void _getMode() async {
      // final prefs = await SharedPreferences.getInstance();
      // // final _mode =  prefs.getString("mode");
      // setState(() {
      //   // mode : _mode;
      // });
  }

  // void _addPhoneInStorage(String mobile) async {
  //     final prefs = await SharedPreferences.getInstance();
  //     // prefs.setString("mobile", mobile);
  // }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Style.Colors.white,
               leading:  IconButton(
                icon: const Icon(Icons.arrow_back , color: Style.Colors.primary),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body:SafeArea(child:  Container(
              height: double.infinity,
              child: 
                Padding(
                  padding:const  EdgeInsets.symmetric(horizontal: 10),
                  child : Form(
                    key: _formKey,
                    child: 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        const Text("شناسه قبض خود را وارد کنید", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        InputDecorationStyle(
                          textInputType :TextInputType.number,
                          label: "شناسه قبض",
                          icon:  CupertinoIcons.doc,
                          onChange: (value){

                          },
                          onSave: (value){
                            (value) { 
                              _billid = convertArToEn(value!);
                              // _addPhoneInStorage(value);
                            };
                          },
                          // type: "number",
                         
                        ),
                      
                        const SizedBox(height: 15),
                        Expanded(child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                           StyledElevatedButton(
                            width:double.maxFinite ,
                            icon : Icons.check_box  ,
                            text : "ادامه" ,
                            textColor: Style.Colors.white,
                            onPressed:  () async  { 
                              if (_formKey.currentState!.validate()) {
                                final value =await  ChooseOperatorBottomSheet.show(context);
                                      if(value !=null ){
                                        if(!mounted){
                                          return;
                                        }
                                        Navigator.pushNamed(context, "/charge-amount");
                                      }
                                    
                              }
                          },  
                        )
                        ],))
                       
                        
                      ],
                    )
                  )
                )
            ,) ,)
          );
  }
}