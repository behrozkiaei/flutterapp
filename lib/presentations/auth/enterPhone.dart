import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.bloc.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.event.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.state.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EnterPhone extends StatefulWidget {
  const EnterPhone({super.key});

  @override
  State<EnterPhone> createState() => _EnterPhoneState();
}

class _EnterPhoneState extends State<EnterPhone> {
  final userRepository = UserRepository();

  final _formKey = GlobalKey<FormState>();
  String _phoneNumber = "09";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getStoredValue();
  }

  _getStoredValue() async {
    final prefs = await SharedPreferences.getInstance();
    final String? value = prefs.getString("mobile");
    setState(() {
      _phoneNumber = value ?? "09";
    });
  }

  void _addPhoneInStorage(String mobile) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("mobile", mobile);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SendOtpBloc, SendOtpState>(
      listener: (context, state) {
        if (state is SendOtpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("ورود ناموفق",
                  style: TextStyle(color: Style.Colors.gray2)),
              backgroundColor: Style.Colors.fail,
            ),
          );
        }
        if (state is SendOtpSuccess) {
          Navigator.pushReplacementNamed(
            context,
            "/otp",
            arguments: _phoneNumber,
          );
        }
      },
      child: Scaffold(
          body: Container(
        height: double.infinity,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 100),
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/icons/logo/p-logo-primary.png",
                        scale: 1,
                      ),
                    ),
                    const SizedBox(height: 100),
                    InputDecorationStyle(
                      label: "شماره تلفن",
                      icon: CupertinoIcons.phone,
                      onChange: (value) {
                        if (value != null) {
                          _phoneNumber = convertArToEn(value!);
                        }
                      },
                      onSave: (value) {
                        (value) {
                          _phoneNumber = convertArToEn(value!);
                        };
                      },
                      type: "phone",
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(height: 15),
                    BlocBuilder<SendOtpBloc, SendOtpState>(
                        builder: (context, state) {
                      return StyledElevatedButton(
                        isLoading: state is SendOtpLoading ? true : false,
                        disabled: state is SendOtpLoading ? true : false,
                        width: double.maxFinite,
                        icon: Icons.check_box,
                        text: "ادامه",
                        textColor: Style.Colors.white,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            _addPhoneInStorage(_phoneNumber);
                            BlocProvider.of<SendOtpBloc>(context).add(
                                SendOtpButtonPressed(mobile: _phoneNumber));
                          }
                        },
                      );
                    }),
                  ],
                ))),
      )),
    );
  }
}

class ScreenArguments {
  ScreenArguments(this.mobile);

  final String mobile;
}
