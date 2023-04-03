import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paytel/widgets/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:paytel/style/theme.dart' as Style;

class ChooseBillType {
  static void show(BuildContext context, Function(String result) callback) {
    //  String? Code;

    void _chooseBillType(String billType) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("billType", billType);
    }

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("قبض",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    const Text("نوع قبض مورد نظر را انتخاب کنید",
                        style: TextStyle(
                            fontSize: 14.0, color: Style.Colors.gray1)),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          _chooseBillType(BillType.service.toString());
                          Navigator.pop(context, BillType.service.toString());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: Icon(CupertinoIcons.doc),
                            ),
                            SizedBox(width: 5),
                            Text("قبوض خدماتی"),
                          ],
                        )),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        _chooseBillType(BillType.mobile.toString());
                        Navigator.pop(context, BillType.mobile.toString());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Icon(CupertinoIcons.phone),
                          ),
                          SizedBox(width: 5),
                          Text("تلفن همراه"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ));
        }).then((value) => callback(value));
  }
}
