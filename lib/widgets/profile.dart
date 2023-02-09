
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paytell/style/theme.dart' as Style;
class Profile extends StatefulWidget {
  const Profile({super.key});
  
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  File? file;
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
    return 
    SafeArea(child: Container(
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
                      radius: 50.0,
                      backgroundImage: file != null ?
                         FileImage(file!) as ImageProvider
                      : const NetworkImage(
                        'https://picsum.photos/200?random=4',
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      right: -8.0,
                      child: IconButton(
                        icon: const  Icon(Icons.edit ,color: Style.Colors.primary,),
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
             const Text("John Doe", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
             const Text("johndoe@example.com", style: TextStyle(fontSize: 18.0)),
             const SizedBox(height: 20.0),
              SizedBox(
                width:double.infinity,
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                        overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                        // shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(
                        //   side: Border(color: Colors.grey, width: 1),
                        // )),
                      ),
                      child: const Text("Button 1"),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                        overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent),
                        // shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(
                        //   side: BorderSide(color: Colors.grey, width: 1),
                        //   borderRadius: BorderRadius.all(Radius.circular(4)),
                        // )),
                      ),
                    child: const Text("Button 2"),  
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(0, 15, 136, 236)),
                        overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(0, 38, 22, 217)),
                        // shape: MaterialStateProperty.resolveWith((states) => const RoundedRectangleBorder(
                        //   side: BorderSide(color: Colors.grey, width: 1),
                        //   borderRadius: BorderRadius.all(Radius.circular(4)),
                        // )),
                      ),
                      child: const Text("Button 3"),
                    ),
                  ],
                )
              )
         ],
        ),
      )
    );
  }
}
