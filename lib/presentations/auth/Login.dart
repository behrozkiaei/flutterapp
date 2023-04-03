import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:paytel/blocs/auth/check-pass/check-pass.bloc.dart';
import 'package:paytel/blocs/auth/check-pass/check-pass.event.dart';
import 'package:paytel/blocs/auth/check-pass/check-pass.state.dart';
import 'package:paytel/blocs/auth/me/me.bloc.dart';
import 'package:paytel/blocs/auth/me/me.event.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.bloc.dart';
import 'package:paytel/blocs/auth/sed-otp/send-otp.event.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLogin extends StatefulWidget {
  const AppLogin({super.key});

  @override
  State<AppLogin> createState() => _AppLoginState();
}

class _AppLoginState extends State<AppLogin> {
  final LocalAuthentication auth = LocalAuthentication();
  String? errorMessage;
  bool loading = false;

  String _authorized = 'Not Authorized';
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  bool _isAuthenticating = false;

  void gotoMainPage() {
    BlocProvider.of<MeBloc>(context).add(StartFetchMe());
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final prefs = await SharedPreferences.getInstance();
      if (!mounted) {
        return;
      }
      BlocProvider.of<CheckPassBloc>(context)
          .add(CheckPassButtonPressed(password: _inputText));
    }
  }

  void _openFingerPrint() {
    _authenticate();
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'ورود با اثر انگشت',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    if (authenticated) {
      final prefs = await SharedPreferences.getInstance();
      final tempPass = prefs.getString("password") ?? "";
      if (tempPass.isEmpty) {
        setState(() {
          errorMessage = "لطفا یک بار با رمز عبور وارد شوید";
        });
      } else {
        if (!mounted) {
          return;
        }
        BlocProvider.of<CheckPassBloc>(context)
            .add(CheckPassButtonPressed(password: tempPass));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CheckPassBloc, CheckPassState>(listener: (context, state) {
          if (state is CheckPassFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("مشکل در دریافت اطلاعات رخ داده است",
                    style: TextStyle(color: Style.Colors.gray2)),
                backgroundColor: Style.Colors.fail,
              ),
            );
          }
          if (state is CheckPassSuccess) {
            gotoMainPage();
          }
          if (state is CheckPassLoading) {
            setState(() {
              loading = true;
            });
          } else {
            setState(() {
              loading = false;
            });
          }
        })
      ],
      child: Scaffold(
        body: SizedBox(
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
                        child: _inputText.isNotEmpty
                            ? Image.asset(
                                "assets/icons/pass.png",
                                scale: 2,
                              )
                            : Image.asset(
                                "assets/icons/finger-primary.png",
                                scale: 2,
                              ),
                      ),
                      const SizedBox(height: 100),
                      //  const Text("پسورد خود را وارد کنید"),
                      InputDecorationStyle(
                          label: "رمز عبور",
                          textInputType: TextInputType.text,
                          icon: Icons.security,
                          onChange: (value) {
                            setState(() {
                              // _inputText=value ;
                              _inputText = convertArToEn(convertFaToEn(value));
                            });
                          },
                          onSave: (value) {},
                          type: "text-en",
                          validate: (value) {
                            if (value!.length < 6) {
                              return 'Please enter some text';
                            }
                            return null;
                          }),
                      const SizedBox(height: 10),
                      BlocBuilder<CheckPassBloc, CheckPassState>(
                          builder: (context, state) {
                        return StyledElevatedButton(
                            isLoading: state is CheckPassLoading ? true : false,
                            disabled: state is CheckPassLoading ? true : false,
                            width: double.maxFinite,
                            icon: Icons.check_box,
                            text: _inputText.isNotEmpty
                                ? "ورود با رمز عبور"
                                : "ورود با اثر انگشت",
                            textColor: Style.Colors.white,
                            onPressed: _inputText.isNotEmpty
                                ? _submitForm
                                : _openFingerPrint);
                      }),
                      Center(
                          child: (errorMessage != null)
                              ? Text(errorMessage!)
                              : const SizedBox(
                                  height: 10,
                                )),
                      TextButton(
                        style: ButtonStyle(backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          return Style.Colors.background;
                        }), textStyle:
                            MaterialStateProperty.resolveWith((states) {
                          return const TextStyle(
                              color: Style.Colors.primary,
                              fontFamily: "IRANSansWeb");
                        })),
                        onPressed: () async {
                          BlocProvider.of<SendOtpBloc>(context)
                              .add(const SendOtpRessetPassButtonPressed());
                          Navigator.pushReplacementNamed(context, "/");
                        },
                        child: const Text("رمز عبور خود را فراموش کرده ام",
                            style: TextStyle(color: Style.Colors.primary)),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
