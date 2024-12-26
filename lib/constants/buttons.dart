import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

Widget customButtonWithIcon({ double? width, double? height, required IconData icon,  Color? iconColor, Size? minSize , Size? maxSize,
  Color? buttonColor, required String text,  Color? textColor, double? fontSize, required  VoidCallback onPressed, bool isDisabled = false,
  List<Color>? buttonGradientColor, double? borderRadius,
}) {

  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        gradient: isDisabled? null: LinearGradient(
            colors: buttonGradientColor ?? blueGradient,
        ),
        borderRadius: BorderRadius.circular(borderRadius?? 10)
    ),
    child: ElevatedButton.icon(
        icon: Icon(icon, color: iconColor?? Colors.white,),
        label: Text(text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? 14,
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: minSize,
          maximumSize: maxSize,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const StadiumBorder(),
        )),

  );
}

Widget customButton({required double width, required double height, List<Color>? buttonGradientColor, required String text,
  Color? textColor, double? fontSize, required  VoidCallback onPressed,
  OutlinedBorder? outlinedBorder,  bool isDisabled = false, double? borderRadius, OutlinedBorder? buttonShape, TextStyle? textStyle
}) {

  return Container(
    decoration: BoxDecoration(
        gradient: isDisabled? null: LinearGradient(
            colors: blueGradient,
        ),
        borderRadius: BorderRadius.circular(borderRadius?? 10)
    ),

    child: ElevatedButton(
      onPressed: isDisabled? null : onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: buttonShape,
          textStyle: textStyle??
          TextStyle(
              fontSize: fontSize?? 14
          )),
      child: Text(text, style: TextStyle(
        color: textColor?? Colors.white,)),
    ),
  );
}


Widget customOutLinedButton({required double width, required double height, required IconData icon, Color? iconColor,
  Color? buttonColor, required String text,  Color? textColor, double? fontSize, required  VoidCallback onPressed, OutlinedBorder? outlinedBorder
}) {

  return TextButton.icon(
    label: Icon(icon, color: iconColor?? Colors.white,),
    icon: Text(text, style: TextStyle(color: textColor?? appButtons),),
    onPressed: onPressed,

    style: TextButton.styleFrom(
        shape: outlinedBorder?? const StadiumBorder(),
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        foregroundColor: buttonColor,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle:
        const TextStyle(
            fontSize: 14
        )),
  );
}

Widget cusOutLinedButton({required double width, required double height, required IconData icon, Color? iconColor, Size? maxSize,
  Color? buttonColor, required String text,  Color? textColor, double? fontSize, required  VoidCallback onPressed, OutlinedBorder? outlinedBorder
}) {

  return OutlinedButton(
    child: Text(text, style: TextStyle(color: textColor?? appButtons),),
    onPressed: onPressed,

    style: OutlinedButton.styleFrom(
        shape:  const RoundedRectangleBorder(side: BorderSide(color: Colors.red, width: 2), borderRadius: BorderRadius.all(Radius.circular(11))),
        minimumSize: Size(width, height),
        maximumSize: maxSize,
        textStyle:
        const TextStyle(
            fontSize: 14
        )),
  );
}

Container borderOutLinedButton({required double width, required double height, required IconData icon,}) {
  return Container(
    width: width,
    height: height,
    child: OutlinedButton(
      child: Icon(icon, color: Colors.white,),
      onPressed: () {},
      style: OutlinedButton.styleFrom(
          shape:  const RoundedRectangleBorder(side: BorderSide(color: Colors.red, width: 2), borderRadius: BorderRadius.all(Radius.circular(11))),
          minimumSize: Size(width, height),
          textStyle:
          const TextStyle(
              fontSize: 14
          )),
    ),
  );
}
