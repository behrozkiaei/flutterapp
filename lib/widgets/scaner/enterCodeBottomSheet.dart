import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/transaction/get-user-info-by-code/get-user-by-code.bloc.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:paytel/style/theme.dart' as Style;

class ScannerBottomSheets {
  static  dynamic show(BuildContext context) async {
   String? Code;
  return await showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return BlocProvider.value(
         value: BlocProvider.of<UserByCodeBloc>(context),
         child:  Container(
          height: 600,
          decoration:const  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(padding: const EdgeInsets.all(10),
           child :Column(
            children: <Widget>[
              
              const SizedBox(height: 20,),
              const Text("کد کاربر را وارد کنید"),
              const SizedBox(height: 10,),

              InputDecorationStyle(
                type: "code",
                icon: Icons.keyboard_backspace_outlined,
                label: "کد کاربر",
                onSave : (value){},
                initialValue: "",
                autofocus: true,
                onChange: (value){
                  print(value);
                  Code = value;
                },
              ),
              Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: 
                    LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        final parentWidth = constraints.maxWidth;
                        return StyledElevatedButton(
                            width:parentWidth ,
                            icon : Icons.check_box ,
                            text :"تایید",
                            textColor: Style.Colors.white,
                            onPressed: () async {
                                if(Code != null ){
                                  Navigator.pop(context, Code);
                                }else{
                                  Navigator.pop(context, null);
                                }
                              }
                            );
                          }
                        )
                       )
                  ],
            ),
          ),
          ),
        );
      },
    );
    // then((value) {
    //   print(1);
    //   callback(value ? value: "-");
    // });
  }
}