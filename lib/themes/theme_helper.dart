import 'package:flutter/material.dart';


class ThemeHelper {

  InputDecoration textInputDecoration(
      {String? labelText, String? hintText, Widget? prefixIcon, Widget? suffixIcon, String? counterText, String? suffixText,
        double? focusedBorderRadius, double? enabledBorderRadius, double? errorBorderRadius, double? focusedErrorBorderRadius, bool filled = false, Color? fillColor}) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      counterText: counterText,
      suffixIcon: suffixIcon,
      suffixText: suffixText,
      fillColor: fillColor ?? Colors.white,

    );
  }


}