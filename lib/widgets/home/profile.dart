
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paytel/blocs/user/update-avtar/update-avatar.bloc.dart';
import 'package:paytel/repositories/auth.repository.dart';
import 'package:paytel/widgets/profile/regiserStepper.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:shared_preferences/shared_preferences.dart';
class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  File? file;
  final userRepository = UserRepository();

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async{
    try{
        final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
        if(image == null) return;
        File? temp =  File(image.path);
        temp = await cropImage(imageFile: temp);
             setState(() {
          file = temp;
        });
    }catch(e){  
      return;  
    }
  }

  Future<File?> cropImage({required  File imageFile}) async{
   try{
    CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: imageFile.path,aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],);
      if(croppedFile == null)  return null ;
      return File(croppedFile.path); 

   }catch(e){
    return null;
   }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
          BlocProvider<UpdateAvatar>(create: (BuildContext context) => UpdateAvatar(userRepository: userRepository),),
     ], 
      child: Scaffold(
      
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const SizedBox(height: 20.0),
            InkWell(
              onTap:  pickImage,
              child: Stack(
                children: <Widget>[
                    CircleAvatar(
                    backgroundColor: Style.Colors.primary,
                    foregroundColor: Style.Colors.primary,
                    
                    radius: 50.0,
                    backgroundImage: file != null ?
                        FileImage(file!) as ImageProvider
                    : const AssetImage(
                      'assets/icons/user.png',
                    ),
                  ),
                    
                      Container(
                      width: 28,
                      height: 28,
                      alignment: Alignment.center,
                      decoration:const  BoxDecoration(shape: BoxShape.circle , color: Style.Colors.primary) ,
                      child : IconButton(
                            icon: const  Icon(Icons.edit ,color: Style.Colors.white,size: 14,),
                      onPressed: () {
                        // Code to open image library and crop image
                        pickImage();
                      },
                    ),
                    ),
                  
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const Text("بهروز کیایی", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            const Text("09116264382", style: TextStyle(fontSize: 14.0,color: Style.Colors.gray1)),
            const SizedBox(height: 20.0),
            
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              padding:const  EdgeInsets.only(right: 10,bottom: 10),
              child:
               const Text("تنظیمات", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
            
            SizedBox(
              height:70,
              width: double.infinity,
              child: 
              InkWell(
                onTap: () => {  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterStepper(),
                                ),
                              )},
                child: 
                  Row(
                  children: [
                   const SizedBox(
                      width: 40,
                      height: 60,
                      child:  CircleAvatar(child:  Icon(Icons.person),)),
                       const SizedBox( width:10,) ,
                    Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children :const [
                                Text("حساب کاربری", style: TextStyle(fontSize: 14.0)),
                                Text("اطلاعات بانکی و شخصی", style: TextStyle(fontSize: 10.0,color: Style.Colors.gray1)),
                            ]
                                  ,
                              ),
                        Expanded(
                            child:
                            Container(
                              alignment: Alignment.centerLeft,
                              child: 
                                const Icon(Icons.arrow_forward),
                            ) 
                        )
                      ],
                    ),  
              
              )
            ),
            SizedBox(
              height:70,
              width: double.infinity,
              child: 
              InkWell(child: 
              Row(
                  children: [
                   const SizedBox(
                      width: 40,
                      height: 60,
                      child:  CircleAvatar(child:  Icon(Icons.security_outlined),)),
                       const SizedBox( width:10,) ,
                    Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children :const [
                                Text("امنیت", style: TextStyle(fontSize: 14.0)),
                                Text("نحوه ورود به اپلیکیشن", style: TextStyle(fontSize: 10.0,color: Style.Colors.gray1)),
                            ]
                                  ,
                              ),
                        Expanded(
                            child:
                            Container(
                              alignment: Alignment.centerLeft,
                              child: 
                                const Icon(Icons.arrow_forward),
                            ) 
                        )
                      ],
                    ),  
              
              )
            ),
            SizedBox(
              height:70,
              width: double.infinity,
              child: 
              InkWell(
                  onTap: () => {  Navigator.pushNamed(context,"/theme")},
                child: 
              Row(
                  children: [
                   const SizedBox(
                      width: 40,
                      height: 60,
                      child:  CircleAvatar(child:  Icon(Icons.brush_outlined),)),
                       const SizedBox( width:10,) ,
                    Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children :const [
                                Text("نمایش", style: TextStyle(fontSize: 14.0)),
                                Text("تنظیمات صفحه نمایش", style: TextStyle(fontSize: 10.0,color: Style.Colors.gray1)),
                            ]
                                  ,
                              ),
                        Expanded(
                            child:
                            Container(
                              alignment: Alignment.centerLeft,
                              child: 
                                const Icon(Icons.arrow_forward),
                            ) 
                        )
                      ],
                    ),  
              
              )
            )
            ,SizedBox(
              height:70,
              width: double.infinity,
              child: 
              InkWell(
                  onTap: () async   { 
                      final pref = await SharedPreferences.getInstance();
                      await pref.remove("token");
                        if (!mounted) {
                          return;
                        }
                      Navigator.pushNamed(context,"/splash");
                    },
                child: 
              Row(
                  children: [
                    const SizedBox(
                      width: 40,
                      height: 60,
                      child:  CircleAvatar(child:  Icon(Icons.exit_to_app),)),
                    const SizedBox( width:10,) ,
                    Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children :const [
                                Text("خروج", style: TextStyle(fontSize: 14.0)),
                                Text("خروج از حساب کاربری", style: TextStyle(fontSize: 10.0,color: Style.Colors.gray1)),
                            ]
                                  ,
                              ),
                        Expanded(
                            child:
                            Container(
                              alignment: Alignment.centerLeft,
                              child:const SizedBox(width: 10,), 
                                // const Icon(Icons.arrow_forward),
                            ) 
                        )
                      ],
                    ),  
              
              )
            )
               
         ],
        ),
      )
      )
    );
  }
}
