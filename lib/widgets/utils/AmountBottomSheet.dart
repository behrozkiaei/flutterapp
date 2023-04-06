import 'package:flutter/material.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:paytel/widgets/utils/elevateButton.style.dart';
import 'package:paytel/widgets/utils/inputDecoration.dart';

class AmountBottomSheet {
  static show(BuildContext context) async {
    String? amount;
    return await showModalBottomSheet(
        useSafeArea: true,
        context: context,
        builder: (_) {
          return Container(
            height: 350,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  InputDecorationStyle(
                    icon: Icons.money,
                    type: "money",
                    label: "مبلغ به ریال",
                    onSave: (value) {},
                    initialValue: "",
                    autofocus: true,
                    onChange: (value) {
                      amount = value.toString().replaceAll(',', '');
                      return value;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      final parentWidth = constraints.maxWidth;
                      return StyledElevatedButton(
                          width: parentWidth,
                          icon: Icons.check_box,
                          text: "تایید",
                          textColor: Style.Colors.white,
                          onPressed: () async {
                            if (amount != null) {
                              Navigator.pop(context, amount);
                            }else{
                              Navigator.pop(context, "");
                            }
                          });
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
