import 'package:flutter/cupertino.dart';
import 'package:shamsi_date/shamsi_date.dart';

class ToPersianDate extends StatelessWidget {
  final int y ;
  final int m ;
  final int d ;
  final TextStyle style ;
  const ToPersianDate({super.key , required this.y , required this.m , required this.d,required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(format1(Jalali(y,m,d)) , style : style);
  }

  String format1(Date d) {
    final f = d.formatter;

    return '${f.wN} ${f.d} ${f.mN} ${f.yyyy}';
  }

}