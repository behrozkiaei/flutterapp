import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytell/presentations/auth/otpWidget.dart';
import 'package:paytell/style/theme.dart' as Style;
class EnterPhone extends StatefulWidget {
  const EnterPhone({super.key});

  @override
  State<EnterPhone> createState() => _EnterPhoneState();
}

class _EnterPhoneState extends State<EnterPhone> {
 

  final _formKey = GlobalKey<FormState>();
  late String _phoneNumber;

  @override
  Widget build(BuildContext context) {
        return  Scaffold(
            body: Container(
              height: 500,
              child: 
                Padding(
                  padding: EdgeInsets.all(10),
                  child : Form(
                    key: _formKey,
                    child: 
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:  CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 100),
                        TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          style:const TextStyle(
                            fontSize: 14.0,
                            color: Style.Colors.titleColor,
                            fontWeight: FontWeight.bold
                          ),
                          initialValue: '09',
                          inputFormatters: [
                            // FilteringTextInputFormatter.allow(RegExp(r'^09\d{9}$')),
                            LengthLimitingTextInputFormatter(11)
                          ],
                          validator: (value) {
                            if (!RegExp(r'^09\d{9}$').hasMatch(value!)) {
                              return 'Invalid phone number';
                            }
                            return null;
                          },
                          onSaved: (value) => _phoneNumber = value!,
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              prefixIcon: Icon(EvaIcons.phone, color: Colors.black26),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(30.0)
                                  ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: new BorderSide(color: Style.Colors.mainColor),
                                  borderRadius: BorderRadius.circular(30.0)),
                              contentPadding: EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              labelText: "شماره تماس",
                              hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Style.Colors.grey,
                                  fontWeight: FontWeight.w500),
                              labelStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpWidget(phoneNumber: _phoneNumber ),
                                ),
                              );
                            }
                          },
                          child: Text('ارسال کد',
                                 style: TextStyle(fontFamily: "IRANSansWeb"),
                          ),
                        )
                      ],
                    )
                  )
                )
            ,) 
          );
      }
    }
