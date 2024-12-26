import 'package:flutter/services.dart';
bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
class LimitRange extends TextInputFormatter {
  LimitRange(
      this.minRange,
      this.maxRange,
      ) : assert(
  minRange < maxRange,
  );

  final int minRange;
  final int maxRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (isNumeric(newValue.text)) {
      var value = int.parse(newValue.text);
      if (value < minRange) {
        print('value print in between $minRange - $maxRange');
        return TextEditingValue(text: minRange.toString());
      } else if (value > maxRange) {
        print('not more $maxRange');
        return TextEditingValue(text: maxRange.toString());
      }
      return newValue;
    }
    return oldValue;
  }
}