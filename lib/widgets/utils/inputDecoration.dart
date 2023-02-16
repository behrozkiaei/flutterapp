import 'dart:ffi';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytel/style/theme.dart' as Style;
import 'package:persian_tools/persian_tools.dart';
class InputDecorationStyle extends StatefulWidget {
const InputDecorationStyle({
  super.key, 
  required this.label,
  this.onSave,
  this.validate,
  this.initialValue = "1",
  this.autofocus = true,
  required  this.onChange,
  this.type = "", 
  required this.icon,
  this.textInputType = TextInputType.number
});

final bool? autofocus;
final IconData icon;
final String initialValue;
final String label;
final Function onChange;
final Function? onSave;
final TextInputType textInputType;
final String type ;
final Function? validate;

  @override
  _InputDecorationStyle createState() => _InputDecorationStyle();
}


class _InputDecorationStyle extends State<InputDecorationStyle> {
    Array<dynamic>? formatter  ;
    TextEditingController? statusController = TextEditingController();

  @override
  void dispose() {
    statusController?.dispose();
    super.dispose();
  }

 @override
  void initState() {
    super.initState();
   

  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                          controller: statusController,
                          keyboardType: widget.textInputType,
                          autofocus :widget.autofocus!,
                          validator:(value){
                             if (value!.isEmpty) {
                                return 'لطفا فرم را پر کنید';
                              }
                            if(widget.type == "phone"){
                              if (!RegExp(r'^09\d{9}$').hasMatch(value!)) {
                                return 'شماره وارد شده صحیح نیست';
                              }
                            }
                          },
                          onChanged:(value) {
                             widget.onChange(value);
                          },
                          initialValue: widget.type == "sheba "? "IR": null ,
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.center,
                          style:const TextStyle(
                            fontSize: 14.0,
                            color: Style.Colors.primary,
                            fontWeight: FontWeight.bold
                          ),
                          inputFormatters:widget.type == "money" ? [
                            LengthLimitingTextInputFormatter(11),
                              ThousandsSeparatorInputFormatter(",") 
                          ]:widget.type == "code" ?[
                            LengthLimitingTextInputFormatter(11), // for coding with separator
                              ThousandsSeparatorInputFormatter("-") 
                          ]:widget.type == "nationalCode" ?[
                            LengthLimitingTextInputFormatter(10)
                          ]:widget.type == "card" ?[
                            LengthLimitingTextInputFormatter(19),
                             MaskedTextInputFormatter(
                              mask: 'xxxx-xxxx-xxxx-xxxx',
                              separator: '-',
                            ),
                          ]:widget.type == "phone" ?[
                             LengthLimitingTextInputFormatter(11),
                          ]:[
                            LengthLimitingTextInputFormatter(20),
                          ],
                          
                          onSaved: (value) => widget.onSave!(value!),
                          decoration: InputDecoration(
                              suffixIcon: widget.type == "sheba" ?  Image.asset('assets/icons/IR.png',scale: 2,):null,
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
   ThousandsSeparatorInputFormatter(this.separator);

   final String separator ; // Change this to '.' for other locales

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


class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  }) { assert(mask != null); assert (separator != null); }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length! > 0) {
      if(newValue.text.length > oldValue.text.length) {
        if(newValue.text.length > mask.length) return oldValue;
        if(newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length-1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}