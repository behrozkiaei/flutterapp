import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paytell/presentations/auth/enterPhone.dart';

class OtpWidget extends StatefulWidget {
  final String? phoneNumber;

  OtpWidget({Key? key,  this.phoneNumber}) ;

  @override
  _OtpWidgetState createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
final _formKey = GlobalKey<FormState>();
  late String _otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      Center(
        child: 
          Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text('Enter OTP for ${widget.phoneNumber}'),
              TextFormField(
                validator: (value) {
                  if (value!.length != 4) {
                    return 'Invalid OTP';
                  }
                  return null;
                },
                onSaved: (value) => _otp = value!,
                decoration: InputDecoration(labelText: 'OTP'),
              ),
              ElevatedButton(
                onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Send request to server to login with phone number and OTP
                      // For example, using the http package:
                      // var response = await http.post
                    }
                  },
                  child: Text("click"),
                ),
                ElevatedButton(
                onPressed: ()  {
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EnterPhone(),
                                ),
                              );
                  },
                  child: Text("Edit phone"),
                )
              ],
            )
          )
        ,
      )

    );
  }

   void _submitOtp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Send request to server to login with phone number and OTP
      // For example, using the http package:
      // var response = await http.post(...);
    }
  }
}