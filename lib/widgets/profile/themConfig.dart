import 'package:flutter/material.dart';
import 'package:paytel/style/theme.dart' as Style;
class ThemeConfig extends StatefulWidget {
  const ThemeConfig({super.key});


  @override
  State<ThemeConfig> createState() => _ThemeConfigState();
}

class _ThemeConfigState extends State<ThemeConfig> {
   bool darkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,leading:  IconButton( icon: const Icon(Icons.arrow_back , color: Style.Colors.primary),onPressed: () => Navigator.of(context).pop(),),),
        body:Padding(padding:const  EdgeInsets.all(10),child: 
          Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("حالت تاریک"),
                  Switch(
                    value: darkMode,
                    activeColor: Style.Colors.primary,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        darkMode = value;
                      });
                    },
                )
                ],
              )
            ]
         ),) ,
      );
    } 
}