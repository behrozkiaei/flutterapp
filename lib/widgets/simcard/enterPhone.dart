import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paytel/blocs/services/internet-packages/internet-packages.bloc.dart';
import 'package:paytel/blocs/services/internet-packages/internet-packages.event.dart';
import 'package:paytel/blocs/services/internet-packages/internet-packages.state.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/simcard/chooseOperator.dart';
import 'package:paytel/widgets/simcard/chooseSimTypeBottomSheet.dart';
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EnterPhoneSim extends StatefulWidget {
  const EnterPhoneSim({super.key});

  @override
  State<EnterPhoneSim> createState() => _EnterPhoneSimState();
}

class _EnterPhoneSimState extends State<EnterPhoneSim> {

  // final _storage = const FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  String? _phoneNumber;
  String? mode ; //   "internet , charge , bill"
    @override
    void initState() {
      super.initState();
      _getMode();
    }

    void _getMode() async {
      final prefs = await SharedPreferences.getInstance();
      final _mode =  prefs.getString("type");
       setState(() { mode = _mode ; }); 
      if(prefs.getString("type") == 'internet'){
        if(!mounted){
          return;
        }
        BlocProvider.of<InternetPackagesBloc>(context).add(const InternetPackagesButtonPressed());
      }
  }
 void setOperator(value) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("operator", value);
  }
  void _addPhoneInStorage(String mobile) async {
    setState(() {
      _phoneNumber=mobile;
    });
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("mobile");
      prefs.setString("mobile", mobile);
  }

  @override
  Widget build(BuildContext context) {
        final double height = MediaQuery.of(context).size.height;

    return  BlocListener<InternetPackagesBloc, InternetPackagesState>(
          listener: (context, state) {
          if (state is InternetPackagesInitial) {
            BlocProvider.of<InternetPackagesBloc>(context).add(const InternetPackagesButtonPressed());
           }
          },
      child: Scaffold(
             appBar: AppBar(
              // backgroundColor: Style.Colors.white,
              elevation: 0,
               leading:  IconButton(
                icon: const Icon(Icons.arrow_back , color: Style.Colors.primary),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body:SafeArea(
              child:  SizedBox(
                     height:height,
                     child: Padding(
                       padding: const  EdgeInsets.all(10),
                       child : Form(
                            key: _formKey,
                            child: 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:  CrossAxisAlignment.start,
                              children: <Widget>[
                                const SizedBox(height: 10),
                                const Text("شماره سیم کارت  را وارد کنید", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 15),
                                InputDecorationStyle(
                                  label: "شماره تلفن",
                                  icon:  CupertinoIcons.person,
                                  onChange: (value){
                                    setState(() {
                                      _phoneNumber = convertArToEn(value);
                                    });
                                  },
                                  onSave: (value){
                                    (value) {
                                      final mobile = convertArToEn(value!);
                                      _addPhoneInStorage(mobile);
                                    };
                                  },
                                  type: "phone",
                                  textInputType : TextInputType.number,
                                
                                ),
                                const SizedBox(height: 15),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                   StyledElevatedButton(
                                    width:double.maxFinite ,
                                    icon : Icons.check_box  ,
                                    text : "ادامه" ,
                                    textColor: Style.Colors.white,
                                    onPressed:  () async  { 
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                       final value = await  ChooseOperatorBottomSheet.show(context); 
                                          _addPhoneInStorage(_phoneNumber!);
                                        if(value != null && mode =="charge" && _phoneNumber != null ){
                                          setOperator(value);
                                            if(!mounted){
                                              return;
                                            }
                                            Navigator.pushNamed(context, "/charge-amount");
                                        }
                                        if(value != null && mode =="internet" && _phoneNumber != null){
                                           setOperator(value);
                                            if(!mounted){
                                              return;
                                            }
                                           final sim_type = await ChooseSimTypeBottomSheet.show(context);
                                            if(sim_type!= null){
                                                if(!mounted){
                                                  return;
                                                }
                                                Navigator.pushNamed(context, "/internet-packages");
                                            }
                                        }
                                            
                                      }
                                  },  
                                ),
                                ],
                                ),
                                ),
                              ],
                            ),
                          ),
                ),
            ) ,
            ),
            ),
          );
      }
}