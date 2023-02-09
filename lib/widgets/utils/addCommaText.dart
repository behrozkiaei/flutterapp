import 'package:flutter/cupertino.dart';
import 'package:persian_tools/persian_tools.dart';

class AddComma extends StatelessWidget {
  final String value;
  final String currency;
  final TextStyle textStyle;
  const AddComma({super.key,required this.value, required this.textStyle , this.currency="ریال"});

  @override
  Widget build(BuildContext context) {
    return Text('${addCommas(value)} ریال ' ,style: textStyle);
  }
}