import 'package:flutter/material.dart';

import 'package:paytel/style/theme.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/simcard/chooseChargeAmount.dart';
import 'package:paytel/widgets/utils/addCommaText.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
class IntertetPackages extends StatefulWidget {
  const IntertetPackages({super.key});

  @override
  State<IntertetPackages> createState() => _IntertetPackagesState();
}

class _IntertetPackagesState extends State<IntertetPackages> {
   int? isSelected;

  _changeState(index){
    setState(() {
      isSelected = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Column(
        children: [
           ListView(
              scrollDirection: Axis.horizontal,
              physics:  const BouncingScrollPhysics(),
              children: List.generate(20, (index) {
              return Padding(
              padding:const  EdgeInsets.all(5),
              child: Container(
                            margin:const EdgeInsets.all(4),
                            height: 80,
                            width: 80,
                            child: ElevatedButton(
                                style:  StyledElevatedButton.buttonTinyStyle(false),
                                child: Text("50000", style: ButtonStyleCustom.textStyle(false)),
                                onPressed: () { _changeState(2);},
                          ),
                      ),
                  );
            }),
          ),
           const SizedBox(height: 20,),
            ListView(
              scrollDirection: Axis.vertical,
              physics:  const BouncingScrollPhysics(),
              children: List.generate(20, (index) {
               return Padding(padding: EdgeInsets.all(5),
                 child: 
                      Row(
                          mainAxisAlignment:  MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                              SizedBox(width: 60,height: 60,child: 
                                  CircleAvatar(
                                      backgroundColor: Style.Colors.primary,
                                      foregroundColor: Style.Colors.primary, 
                                      radius: 50.0,
                                      backgroundImage:  AssetImage('assets/icons/hamrah.png'),
                                      ),
                              ),
                              SizedBox(width: 10),
                              Text("همراه اول"),
                          ],
                      )
               );
            }),
          ),
        ],
      )
      ),
    );
  }
}