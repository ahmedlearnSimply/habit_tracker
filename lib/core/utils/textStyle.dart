import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/colors.dart';

//* get title
TextStyle getTitleStyle(
    {Color? color,
    double? fontSize = 18,
    FontWeight? fontWeight = FontWeight.bold}) {
  return TextStyle(
    fontSize: fontSize,
    color: color ?? AppColors.primaryText,
    fontWeight: fontWeight,
    fontFamily: 'cairo',
  );
}

//* get body style
TextStyle getBodyStyle(
        {Color? color,
        double? fontSize = 18,
        FontWeight? fontWeight = FontWeight.w400}) =>
    TextStyle(
      fontSize: fontSize,
      color: color ?? AppColors.primaryText,
      fontWeight: fontWeight,
      fontFamily: 'cairo',
    );

//* get small style
TextStyle getSmallStyle(
        {Color? color,
        double? fontSize = 12,
        FontWeight? fontWeight = FontWeight.w500}) =>
    TextStyle(
      fontSize: fontSize,
      fontFamily: 'cairo',
      color: color ?? AppColors.primaryText,
      fontWeight: fontWeight,
    );
