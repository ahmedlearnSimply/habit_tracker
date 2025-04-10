import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.width,
      this.height,
      this.fontsize,
      this.radius});
  //* variables
  final String text;
  final double? fontsize;
  final Function() onPressed;
  final double? width;
  final double? radius;
  final double? height;

  //* widget
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryText,
              foregroundColor: AppColors.secondaryText,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 15))),
          onPressed: onPressed,
          child: Text(text,
              style: getTitleStyle(
                color: AppColors.background,
                fontSize: fontsize ?? 16,
              ))),
    );
  }
}
