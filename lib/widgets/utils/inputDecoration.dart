import 'dart:ffi';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:persian_tools/persian_tools.dart';
class InputDecorationStyle extends StatefulWidget {

final String label;
final Function? onSave;
final Function? validate;
final String initialValue;
final bool? autofocus;
final Function onChange;
final String type ;
final IconData icon;
const InputDecorationStyle({
  super.key, 
  required this.label,
  this.onSave,
  required this.validate,
  this.initialValue = "1",
  this.autofocus = true,
  required  this.onChange,
  this.type = "", 
  required this.icon
});
  
  @override
  _InputDecorationStyle createState() => _InputDecorationStyle();
}


class _InputDecorationStyle extends State<InputDecorationStyle> {
    TextEditingController? statusController = TextEditingController();
    Array<dynamic>? formatter  ;


 @override
  void initState() {
    super.initState();
   

  }

  @override
  void dispose() {
    statusController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                          controller: statusController,
                          keyboardType: TextInputType.number,
                          autofocus :widget.autofocus!,
                          onChanged:(value) {
                            widget.onChange(value);
                          },
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          style:const TextStyle(
                            fontSize: 14.0,
                            color: Style.Colors.primary,
                            fontWeight: FontWeight.bold
                          ),
                          // initialValue: widget.initialValue ,
                          inputFormatters:widget.type == "money" ? [
                            LengthLimitingTextInputFormatter(11),
                              ThousandsSeparatorInputFormatter(",") 
                          ]:widget.type == "code" ?[
                            LengthLimitingTextInputFormatter(11),
                              ThousandsSeparatorInputFormatter("-") 
                          ]:[
                            LengthLimitingTextInputFormatter(11),
                          ],
                          validator: (value) {
                            widget.validate!();
                            return null;
                          },
                          onSaved: (value) => widget.onSave!(value!),
                          decoration: InputDecoration(
                              fillColor: Colors.white,
                              prefixIcon: Icon(widget.icon, color:Style.Colors.primary),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:  const BorderSide(color: Style.Colors.primary),
                                  borderRadius: BorderRadius.circular(10.0)
                                  ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Style.Colors.primary),
                                  borderRadius: BorderRadius.circular(10.0)),
                              contentPadding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              labelText: widget.label,
                              hintStyle:const TextStyle(
                                  fontSize: 12.0,
                                  color: Style.Colors.primary,
                                  fontWeight: FontWeight.bold),
                              labelStyle:const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                        );  
                  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
   final String separator ; // Change this to '.' for other locales
   ThousandsSeparatorInputFormatter(this.separator);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
