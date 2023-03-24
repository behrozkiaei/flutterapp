import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paytel/blocs/auth/me/me.bloc.dart';
import 'package:paytel/blocs/auth/me/me.event.dart';
import 'package:paytel/blocs/auth/me/me.state.dart';
import 'package:paytel/blocs/user/update-bank-data/update-user.bloc.dart';
import 'package:paytel/blocs/user/update-bank-data/update-user.event.dart';
import 'package:paytel/blocs/user/update-bank-data/update-user.state.dart';
import 'package:paytel/blocs/user/update-identity-image/update-identity.bloc.dart';
import 'package:paytel/blocs/user/update-identity-image/update-identity.event.dart';
import 'package:paytel/blocs/user/update-identity-image/update-identity.state.dart';
import 'package:paytel/blocs/user/update-national-card/update-avatar.bloc.dart';
import 'package:paytel/blocs/user/update-national-card/update-avatar.event.dart';
import 'package:paytel/blocs/user/update-national-card/update-avatar.state.dart';
import 'package:paytel/blocs/user/update-user/update-user.bloc.dart';
import 'package:paytel/blocs/user/update-user/update-user.event.dart';
import 'package:paytel/blocs/user/update-user/update-user.state.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/profile/recorde-video.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:video_player/video_player.dart';

class RegisterStepper extends StatefulWidget {
  const RegisterStepper({super.key});

  @override
  State<RegisterStepper> createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
  String? base64National;
  String? base64Shenasname;
  File? cartmelli;
  bool loading = false;
  File? shenasname;
  final userRepository = UserRepository();
  final _persionalInfoFormKey = GlobalKey<FormState>();
  final _bankAccountFormKey = GlobalKey<FormState>();
  String? fname;
  String? lname;
  String? nationalCode;
  String? cardNumbers;
  String? shebaNumbers;
  bool waitingForResponse = false;
  int _index = 0;
  bool showStepper = true;
  bool verified = false;
  final ImagePicker _picker = ImagePicker();
  final picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;
  File? _pickedVideo;

  Future<void> pickImageShenasname() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      File? temp = File(image.path);
      if (temp == null) {
        return;
      }
      final croppedImageBytes = temp.readAsBytesSync();
      String base64Image = base64Encode(croppedImageBytes);
      setState(() {
        shenasname = temp;
        base64National = base64Image;
      });
    } catch (e) {
      return;
    }
  }

  Future<void> pickImageCartMelli() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) return;
      File? temp = File(image.path);
      if (temp == null) {
        return;
      }
      final croppedImageBytes = temp.readAsBytesSync();
      String base64Image = base64Encode(croppedImageBytes);
      setState(() {
        cartmelli = temp;
        base64National = base64Image;
      });
    } catch (e) {
      return;
    }
  }

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);

    if (pickedVideo != null) {
      setState(() {
        _pickedVideo = File(pickedVideo.path);
        _videoPlayerController = VideoPlayerController.file(_pickedVideo!)
          ..initialize().then((_) {
            setState(() {
              _videoPlayerController!.play();
            });
          });
      });
    } else {
      print('No video selected.');
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    BlocProvider.of<MeBloc>(context).add(StartFetchMe());
    super.initState();
  }
  //  final StepperController _controller = StepperController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UpdateNationalCard, UpdateNationalCardState>(
            listener: (context, state) async {
          if (state is UpdateNationalCardLoading) {
            setState(() {
              loading = true;
            });
          } else {
            BlocProvider.of<MeBloc>(context).add(StartFetchMe());
          }
        }),
        BlocListener<UpdateUser, UpdateUserState>(
            listener: (context, state) async {
          if (state is UpdateUserLoading) {
            setState(() {
              loading = true;
            });
          } else {
            if (state is UpdateUserSuccess) {
              BlocProvider.of<MeBloc>(context).add(StartFetchMe());
            }
          }
        }),
        BlocListener<UpdateIdentityImage, UpdateIdentityImageState>(
            listener: (context, state) async {
          if (state is UpdateBankrLoading) {
            setState(() {
              loading = true;
            });
          } else {
            BlocProvider.of<MeBloc>(context).add(StartFetchMe());
          }
        }),
        BlocListener<MeBloc, MeState>(listener: (context, state) async {
          if (state is MeSuccess) {
            if (state.me?.name == null) {
              setState(() {
                _index = 0;
              });
            } else if (state.me?.sheba == null || state.me?.card == null) {
              setState(() {
                _index = 1;
              });
            } else if (state.me?.shenasname == null ||
                state.me?.cartMelli == null) {
              setState(() {
                _index = 2;
              });
            } else if (state.me?.selfiVideo == null ) {
              setState(() {
                _index = 3;
              });
            }else if (state.me?.verifiedBank != null &&
                state.me?.verified != null) {
              if (state.me!.verifiedBank! && state.me!.verified!) {
                setState(() {
                  verified =true;
                  showStepper =false;
                });
               
              } else {
                 setState(() {
                   verified = false;
                   showStepper =false;
                });
              }
            }
            setState(() {
              loading = false;
            });
          } else {
            setState(() {
              loading = true;
            });
          }
        }),
        BlocListener<UpdateBankr, UpdateBankrState>(
            listener: (context, state) async {
          if (state is UpdateBankrLoading) {
            setState(() {
              loading = true;
            });
          } else {
            if (state is UpdateBankrSuccess) {
              setState(() {
                _index = 2;
              });
            }
            setState(() {
              loading = false;
            });
          }
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Style.Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Style.Colors.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<MeBloc, MeState>(builder: (context, state) {
            return Column(children: [
              showStepper
                  ? Stepper(
                      currentStep: _index,
                      controlsBuilder: (BuildContext context, ControlsDetails) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            StyledElevatedButton(
                              onPressed: _index < 2
                                  ? ControlsDetails.onStepContinue
                                  : null,
                              text: 'ادامه',
                              icon: Icons.check_box,
                              width: 100,
                              height: 40,
                            ),
                          ],
                        );
                      },
                      elevation: 0,
                      onStepCancel: () {
                        if (_index > 0) {
                          setState(() {
                            _index -= 1;
                          });
                        }
                      },
                      onStepContinue: () {
                        if (_index == 0 &&
                            _persionalInfoFormKey.currentState!.validate()) {
                          _persionalInfoFormKey.currentState!.save();
                          BlocProvider.of<UpdateUser>(context).add(
                              UpdateUserButtonPressed(
                                  name: '$fname $lname',
                                  nationalCode: nationalCode));
                        } else if (_index == 1 &&
                            _bankAccountFormKey.currentState!.validate()) {
                          _bankAccountFormKey.currentState!.save();
                          BlocProvider.of<UpdateBankr>(context).add(
                              UpdateBankrButtonPressed(
                                  sheba: shebaNumbers!, card: cardNumbers!));
                        }
                        if (_index == 2) {
                          setState(() {
                            _index += 1;
                          });
                        }
                      },
                      onStepTapped: (int index) {
                        setState(() {
                          _index = index;
                        });
                      },
                      steps: [
                        Step(
                          title: const Text('مشخصات فردی'),
                          content: Form(
                            key: _persionalInfoFormKey,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                InputDecorationStyle(
                                    textInputType: TextInputType.text,
                                    label: "نام",
                                    autofocus :false,
                                    icon: CupertinoIcons.person,
                                    onChange: (value) {
                                      setState(() {
                                        fname = value;
                                      });
                                      return value;
                                    },
                                    onSave: (value) {},
                                    type: "string",
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputDecorationStyle(
                                    label: "نام خانوادگی",
                                    icon: CupertinoIcons.person,
                                    onChange: (value) {
                                      setState(() {
                                        lname = value;
                                      });
                                    },
                                     autofocus :false,
                                    onSave: (value) {},
                                    type: "string",
                                    textInputType: TextInputType.text,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputDecorationStyle(
                                    label: "کد ملی",
                                    icon: CupertinoIcons.person,
                                     autofocus :false,
                                    onChange: (value) {
                                      setState(() {
                                        nationalCode = convertArToEn(value
                                            .toString()
                                            .replaceAll("-", ""));
                                      });
                                    },
                                    onSave: (value) {},
                                    textInputType: TextInputType.number,
                                    type: "nationalCode",
                                    validate: (value) {
                                      if (value!.length != 10) {
                                        return 'کد ملی را به درستی وارد کنید';
                                      }
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          isActive: _index >= 0,
                        ),
                        Step(
                          title: const Text('اطلاعات بانکی'),
                          isActive: _index >= 1,
                          content: Form(
                              key: _bankAccountFormKey,
                              child: Column(children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                InputDecorationStyle(
                                    textInputType: TextInputType.number,
                                    label: "شماره کارت",
                                    icon: CupertinoIcons
                                        .rectangle_on_rectangle_angled,
                                    onChange: (value) {
                                      return value;
                                    },
                                    onSave: (value) {
                                      setState(() {
                                        cardNumbers = convertArToEn(value
                                            .toString()
                                            .replaceAll("-", ""));
                                      });
                                    },
                                    type: "card",
                                    validate: (value) {
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                InputDecorationStyle(
                                    label: "شماره شبا",
                                    textInputType: TextInputType.number,
                                    icon: CupertinoIcons
                                        .rectangle_on_rectangle_angled,
                                    onChange: (value) {},
                                    onSave: (value) {
                                      setState(() {
                                        shebaNumbers =
                                            'IR${convertArToEn(value.toString())}';
                                      });
                                    },
                                    type: "sheba",
                                    validate: (value) {
                                      return null;
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                              ])),
                        ),
                        Step(
                          title: const Text('ارسال مدارک'),
                          content: Row(children: [
                            InkWell(
                              onTap: () async {
                                await pickImageCartMelli();
                                if (base64National != null && mounted) {
                                  BlocProvider.of<UpdateNationalCard>(context)
                                      .add(UpdateNationalCardButtonPressed(
                                          cartMelli: base64National!));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Style.Colors.primary,
                                          style: BorderStyle.solid),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: cartmelli != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(9.0),
                                            child: Image.file(
                                              cartmelli!,
                                              fit: BoxFit.cover,
                                            ))
                                        : const Icon(CupertinoIcons.plus,
                                            color: Style.Colors.primary),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "بارگذاری کارت ملی ",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                await pickImageShenasname();
                                if (base64National != null && mounted) {
                                  BlocProvider.of<UpdateIdentityImage>(context)
                                      .add(UpdateIdentityImageButtonPressed(
                                          shenasname: base64National!));
                                }
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Style.Colors.primary,
                                          style: BorderStyle.solid),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: shenasname != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(9.0),
                                            child: Image.file(
                                              shenasname!,
                                              fit: BoxFit.cover,
                                            ))
                                        : const Icon(CupertinoIcons.plus,
                                            color: Style.Colors.primary),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "بارگذاری شناسنامه",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          isActive: _index >= 2,
                        ),
                        Step(
                          title: const Text('بارگذاری ویدئو'),
                          content: Row(children: [
                            InkWell(
                              onTap: () async {
                                final cameras = await availableCameras();
                                if (!mounted) {
                                  return;
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoRecorderWidget(
                                          cameras: cameras)),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Style.Colors.primary,
                                          style: BorderStyle.solid),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: _pickedVideo == null
                                        ? const Text('No video')
                                        : AspectRatio(
                                            aspectRatio: _videoPlayerController!
                                                .value.aspectRatio,
                                            child: VideoPlayer(
                                                _videoPlayerController!),
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "تایید هویت",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          isActive: _index >= 2,
                        ),
                      ],
                    )
                  : (verified)
                      ? SizedBox(
                          height: 500,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Center(
                                    child: Text(
                                  " اکانت شما تائید شده است",
                                  style: TextStyle(fontSize: 16),
                                )),
                                Center(
                                    child: Text(
                                  "اکنون می توانید عملیات برداشت را انجام دهید",
                                  style: TextStyle(fontSize: 14),
                                )),
                              ]))
                      : SizedBox(
                          height: 500,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Center(
                                    child: Text(
                                  " در انتظار تایید مدارک...",
                                  style: TextStyle(fontSize: 16),
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                    child: Text(
                                  " فرایند ممکن است تا 24 ساعت به طول انجامد",
                                  style: TextStyle(fontSize: 14),
                                )),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                    child: SpinKitThreeBounce(
                                  color: Style.Colors.primary,
                                  size: 12.0,
                                ))
                              ]),
                        ),
              Container(
                  child: loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: Center(
                              child: SpinKitThreeBounce(
                            color: Style.Colors.primary,
                            size: 12.0,
                          )))
                      : const SizedBox.shrink()),
            ]);
          }),
        ),
      ),
    );
  }
}
