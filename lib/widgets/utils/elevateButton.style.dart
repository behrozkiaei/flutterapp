import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paytel/style/theme.dart' as Style;

class StyledElevatedButton extends StatelessWidget {
  final Color textColor;
  final Function? onPressed;
  final ButtonStyle? buttonStyle;
  final bool isLoading;
  final bool disabled;
  final double width;
  final double height;
  final IconData? icon;
  final String text;
  final double textSize;
  const StyledElevatedButton(
      {Key? key,
      required this.onPressed,
      this.textColor = Style.Colors.white,
      this.buttonStyle,
      this.disabled = false,
      this.isLoading = false,
      required this.width,
      this.height = 50,
      this.icon,
      required this.text,
      this.textSize = 14})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        if (!disabled) {onPressed!()}
      },
      style: buttonStyle ??
          ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (disabled) {
                  return Style.Colors.gray1;
                }
                return Style.Colors.primary;
              },
            ),
            minimumSize: MaterialStateProperty.resolveWith((states) {
              return Size(width, height);
            }),
            maximumSize: MaterialStateProperty.resolveWith((states) {
              return Size(width, height);
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            elevation: MaterialStateProperty.resolveWith((states) => 0),
          ),
      child: isLoading
          ? const SpinKitThreeBounce(
              color: Style.Colors.white,
              size: 12.0,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  icon != null ? Icon(icon) : const Text(""),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(text, style: TextStyle(fontSize: textSize)),
                ]),
    );
  }

  static ButtonStyle buttonTinyStyle(isActive) {
    return ButtonStyle(
      backgroundColor: MaterialStateColor.resolveWith((states) {
        return isActive ? Style.Colors.primary : Style.Colors.gray2;
      }),
      elevation: MaterialStateProperty.resolveWith((states) => 0),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              side: const BorderSide(color: Style.Colors.gray1),
              borderRadius: BorderRadius.circular(10.0))),
      textStyle: MaterialStateProperty.resolveWith((states) {
        return TextStyle(
            color: isActive ? Style.Colors.white : Style.Colors.gray2);
      }),
    );
  }
}
