import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends StatefulWidget{
  const Avatar({super.key});

  @override
  State<Avatar> createState() => _AvatarState();
  
}

class _AvatarState extends State<Avatar> {
   late File _selectedImage;
   final ImagePicker _picker = ImagePicker();


  Future<void> getLostData() async {
    final LostDataResponse response =
        await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.files != null) {
      for (final XFile file in response.files) {

        // _handleFile(file);
      }
    } else {
      return ; 
      // _handleError(response.exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: _selectedImage != null
                  ? FileImage(_selectedImage)
                  :  NetworkImage('https://www.example.com/image.jpg'),
            ),
          ),
        ),
       const  SizedBox(height: 10),
        TextButton(
          onPressed: getLostData,
          child: const Text('Choose Image'),
        ),
      ],
    );
  }

}