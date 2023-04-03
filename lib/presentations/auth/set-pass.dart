import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/auth/ressetPass/resset-pass.bloc.dart';
import 'package:paytel/blocs/auth/ressetPass/resset-pass.event.dart';
import 'package:paytel/blocs/auth/ressetPass/resset-pass.state.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetPass extends StatefulWidget {
  const SetPass({super.key});

  @override
  State<SetPass> createState() => _SetPassState();
}

class _SetPassState extends State<SetPass> {
  bool loading = false;
  String pass = '';
  String repass = '';

  final _formKey = GlobalKey<FormState>();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (pass == repass && pass.length > 5) {
        if (!mounted) {
          return;
        }
        BlocProvider.of<RessetPassBloc>(context)
            .add(RessetPassButtonPressed(password: pass));
      }
      if (pass != repass) {
        if (!mounted) {
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("رمز با یکدیگر یکسان نیست",
              style: TextStyle(color: Style.Colors.gray2)),
          backgroundColor: Style.Colors.fail,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RessetPassBloc, RessetPassState>(
            listener: (context, state) async {
          if (state is RessetPassFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("ثبت رمز عبور ناموفق بود",
                    style: TextStyle(color: Style.Colors.gray2)),
                backgroundColor: Style.Colors.fail,
              ),
            );
            setState(() {
              loading = false;
            });
          }
          if (state is RessetPassLoading) {
            setState(() {
              loading = true;
            });
          }
          if (state is RessetPassSuccess) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString("password", convertArToEn(convertFaToEn(pass)));
            if (!mounted) {
              return;
            }
            Navigator.pushReplacementNamed(context, "/home");
          }
        }),
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
                        child: Image.asset(
                          "assets/icons/logo/p-logo-primary.png",
                          scale: 1,
                        ),
                      ),
                      const SizedBox(height: 90),
                      const Text("یک رمز عبور انتخاب کنید"),
                      const SizedBox(height: 10),
                      InputDecorationStyle(
                          label: "رمز عبور",
                          textInputType: TextInputType.text,
                          icon: Icons.security,
                          onChange: (value) {
                            if (value != null) {
                              setState(() {
                                pass = convertArToEn(convertFaToEn(value));
                              });
                            }
                          },
                          onSave: (value) {
                            setState(() {
                              pass = convertArToEn(convertFaToEn(value));
                            });
                          },
                          type: "text",
                          validate: (value) {
                            if (value!.length < 6) {
                              return 'Please enter some text';
                            }
                            return null;
                          }),
                      const SizedBox(height: 10),
                      InputDecorationStyle(
                          label: "تکرار رمز عبور",
                          textInputType: TextInputType.text,
                          icon: Icons.security,
                          onChange: (value) {
                            if (value != null) {
                              setState(() {
                                repass = convertArToEn(convertFaToEn(value));
                              });
                            }
                          },
                          onSave: (value) {
                            if (value != null) {
                              setState(() {
                                repass = convertArToEn(convertFaToEn(value));
                              });
                            }
                          },
                          type: "text",
                          validate: (value) {
                            if (value!.length < 6) {
                              return 'Please enter some text';
                            }
                            return null;
                          }),
                      const SizedBox(height: 10),
                      StyledElevatedButton(
                          disabled: (pass.length < 6 || pass != repass)
                              ? true
                              : false,
                          width: double.maxFinite,
                          icon: Icons.check_box,
                          text: "تایید",
                          textColor: Style.Colors.white,
                          onPressed: _submitForm)
                    ],
                  ))),
        ),
      ),
    );
  }
}
