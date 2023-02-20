import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paytel/blocs/user/update-bank-data/update-user.bloc.dart';
import 'package:paytel/blocs/user/update-identity-image/update-identity.bloc.dart';
import 'package:paytel/blocs/user/update-national-card/update-avatar.bloc.dart';
import 'package:paytel/blocs/user/update-user/update-user.bloc.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';

import 'package:paytel/style/theme.dart' as Style;
class RegisterStepper extends StatefulWidget {
  const RegisterStepper({super.key});

  @override
  State<RegisterStepper> createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
  int _index = 0;
  File? shenasname;
  File? cartmelli;
  final ImagePicker _picker = ImagePicker();
  final userRepository = UserRepository();

  //  final StepperController _controller = StepperController();

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
          BlocProvider<UpdateNationalCard>(create: (BuildContext context) => UpdateNationalCard(userRepository: userRepository),),
          BlocProvider<UpdateBankr>(create: (BuildContext context) => UpdateBankr(userRepository: userRepository),),
          BlocProvider<UpdateUser>(create: (BuildContext context) => UpdateUser(userRepository: userRepository),),
          BlocProvider<UpdateIdentityImage>(create: (BuildContext context) => UpdateIdentityImage(userRepository: userRepository),),
     ], 
      child:Scaffold(

      body: SafeArea(child: 
      
      SizedBox(
        height: double.infinity,
        child:
         Stepper(
           currentStep: _index,
            controlsBuilder: (BuildContext context, ControlsDetails) {
              return  Row(
                mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StyledElevatedButton(
                    onPressed: ControlsDetails.onStepContinue,
                    text: 'ادامه', icon: Icons.check_box, width: 100,height: 40,
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
                if (_index <= 1) {
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
                  content:Column(children: [
                        const SizedBox(height: 10,),
                        InputDecorationStyle(
                          textInputType : TextInputType.text,
                          label: "نام",
                          icon:  CupertinoIcons.person,
                          onChange: (value){
                              return value;
                          },
                          // onSave: (value){},
                          type: "string",
                          validate :(value){
                                  if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                              return null ;
                          }
                        ),
                        const SizedBox(height: 10,),
                         InputDecorationStyle(
                          label: "نام خانوادگی",
                          icon:  CupertinoIcons.person,
                          onChange: (value){},
                          onSave: (value){},
                          type: "string",
                          textInputType : TextInputType.text,
                          validate :(value){
                                if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                              return null ;
                          }
                        ),
                         const SizedBox(height: 10,),
                         InputDecorationStyle(
                          label: "کد ملی",
                          icon:  CupertinoIcons.person,
                          onChange: (value){},
                          onSave: (value){},
                          textInputType : TextInputType.number,
                          type: "nationalCode",
                          validate :(value){
                                if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                              return null ;
                          }
                        ),
                      const SizedBox(height: 10,),
                  ],)
                  ,
                  isActive: _index >= 0,
                ),
              Step(
                title:const  Text('اطلاعات بانکی'),
                isActive: _index >= 1,
                content:Column(children: [
                        const SizedBox(height: 10,),
                        InputDecorationStyle(
                          textInputType : TextInputType.number,
                          label: "شماره کارت",
                          icon:  CupertinoIcons.rectangle_on_rectangle_angled,
                          onChange: (value){
                              return value;
                          },
                          // onSave: (value){},
                          type: "card",
                          validate :(value){
                                  if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                              return null ;
                          }
                        ),
                        const SizedBox(height: 10,),
                         InputDecorationStyle(
                          label: "شماره شبا",
                          textInputType : TextInputType.number,
                          icon:  CupertinoIcons.rectangle_on_rectangle_angled,
                          onChange: (value){
                            
                          },
                          onSave: (value){},
                          type: "sheba",
                          validate :(value){
                                if (value!.isEmpty) {
                                      return 'Please enter some text';
                                    }
                              return null ;
                          }
                        ),
                      const SizedBox(height: 10,),
                ])
              ),
              Step(
                title:const  Text('ارسال مدارک'),
                content:
                  Row(children: [
                    InkWell(
                      onTap: pickImageCartMelli,
                      child: 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration :   BoxDecoration(
                                      border:  Border.all(color:Style.Colors.primary ,style :BorderStyle.solid),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: cartmelli != null ?
                                     ClipRRect(
                                          borderRadius: BorderRadius.circular(9.0),
                                          child:Image.file(cartmelli!,
                                          fit: BoxFit.cover,
                                        ))
                                      :
                                      const Icon(CupertinoIcons.plus,color: Style.Colors.primary) ,
                                    
                                  ),
                                  const SizedBox(height: 10,),
                                  const Text("بارگذاری کارت ملی ", style: TextStyle(fontSize: 12),),
                                  const SizedBox(height: 10,),
                            ],
                          )
                      ,),
                      const SizedBox(width: 10,),
                      InkWell(
                        onTap: pickImageShenasname,
                        child: 
                            Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration :   BoxDecoration(
                                      border:  Border.all(color:Style.Colors.primary ,style :BorderStyle.solid),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: shenasname != null ?
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(9.0),
                                          child:Image.file(shenasname!,
                                          fit: BoxFit.cover,
                                        ))
                                      :
                                      const Icon(CupertinoIcons.plus,color: Style.Colors.primary) ,
                                     ),
                                  const SizedBox(height: 10,),
                                const Text("بارگذاری شناسنامه", style: TextStyle(fontSize: 12),),
                                const SizedBox(height: 10,),
                            ],
                          ),
            
                      ),
                  ])
                ,
                isActive: _index >= 2,
              ),
        ],
             
            ),
      
    ),
      )
      )
    );
    
  }

    Future<void> pickImageShenasname() async{
    try{
        final XFile? image = await _picker.pickImage(source: ImageSource.camera);
        if(image == null) return;
        File? temp =  File(image.path);
        setState(() {
          shenasname = temp;
        });
    }catch(e){
      return;
    }
  }
    Future<void> pickImageCartMelli() async{
    try{
        final XFile? image = await _picker.pickImage(source: ImageSource.camera);
        if(image == null) return;
        File? temp =  File(image.path);
        // temp = await cropImage(imageFile: temp);
        setState(() {
          cartmelli = temp;
        });
    }catch(e){
      return;
    }
  }
}
