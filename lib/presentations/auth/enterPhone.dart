import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytel/presentations/auth/otpWidget.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:shared_preferences/shared_preferences.dart';
class EnterPhone extends StatefulWidget {
  const EnterPhone({super.key});

  @override
  State<EnterPhone> createState() => _EnterPhoneState();
}

class _EnterPhoneState extends State<EnterPhone> {

  // final _storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber="09";
   
    @override
    void initState() {
      super.initState();
      _getStoredValue();
    }

   _getStoredValue() async {
      final prefs = await SharedPreferences.getInstance();
      final String? value = prefs.getString("mobile");
      setState(() { _phoneNumber = value ?? "09"; });  
  }
  
  void _addPhoneInStorage(String mobile) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("mobile", mobile);
  }
  
  @override
  Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width;
        return  Scaffold(
            backgroundColor:Style.Colors.background,
            body: Container(
              height: 500,
              child: 
                Padding(
                  padding:const  EdgeInsets.all(10),
                  child : Form(
                    key: _formKey,
                    child: 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:  CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 100),
                        TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          style:const TextStyle(
                            fontSize: 14.0,
                            color: Style.Colors.primary,
                            fontWeight: FontWeight.bold
                          ),
                          initialValue: _phoneNumber ,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11)
                          ],
                          validator: (value) {
                            if (!RegExp(r'^09\d{9}$').hasMatch(value!)) {
                              return 'شماراه وارد شده صحیح نیست';
                            }
                            return null;
                          },
                          onSaved: (value) => _phoneNumber = value!,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              prefixIcon:const Icon(EvaIcons.phone, color:Style.Colors.primary),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:  const BorderSide(color: Style.Colors.primary),
                                  borderRadius: BorderRadius.circular(10.0)
                                  ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Style.Colors.primary),
                                  borderRadius: BorderRadius.circular(10.0)),
                              contentPadding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              labelText: "شماره تماس",
                              hintStyle:const TextStyle(
                                  fontSize: 12.0,
                                  color: Style.Colors.primary,
                                  fontWeight: FontWeight.bold),
                              labelStyle:const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:MaterialStateProperty.resolveWith((states) {
                               return  Style.Colors.primary;
                            }),
                            textStyle:MaterialStateProperty.resolveWith((states) {
                               return Style.TextStyling.primaryTextStyle;
                            }),
                            elevation:MaterialStateProperty.resolveWith((states) {
                              return 0;
                            }),
                            minimumSize:MaterialStateProperty.resolveWith((states) {
                              return Size(width, 50);
                            }), 
                            maximumSize:MaterialStateProperty.resolveWith((states) {
                              return Size(width, 50);
                            }),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)
                                )
                              )
                          ),
                          onPressed:  () { 
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _addPhoneInStorage(_phoneNumber);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpWidget(phoneNumber: _phoneNumber ),
                                ),
                              );
                            }
                          },
                          child: const Text('ارسال پیامک فعال‌سازی'),
                        )
                      ],
                    )
                  )
                )
            ,) 
          );
      }
     
      
    }
