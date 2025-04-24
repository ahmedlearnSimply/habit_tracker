// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/utils/assets.dart';
import 'package:habit_tracker/core/utils/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String userName;
  final void Function() onAddPressed;
  final void Function()? onStatsPressed;
  final void Function() onSettingsPressed;

  CustomAppBar({
    super.key,
    required this.userName,
    required this.onAddPressed,
    required this.onStatsPressed,
    required this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(color: AppColors.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "أهلاً، $userName 👋",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'cairo',
                ),
              ),
              Row(
                children: [
                  Text(
                    "اثر",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'cairo',
                    ),
                  ),
                  Gap(5),
                  SvgPicture.asset(
                    AppAssets.logoSvg,
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
          Gap(4),
          Text(
            "كل عادة تترك أثرًا",
            style: TextStyle(
              fontSize: 16,
              color: AppColors.secondaryText,
              fontFamily: 'cairo',
            ),
          ),
          Gap(20),
          // Action icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.bar_chart_outlined),
                iconSize: 26,
                color: AppColors.primaryText,
                onPressed: onStatsPressed,
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                iconSize: 28,
                color: AppColors.primaryText,
                onPressed: onAddPressed,
              ),
              IconButton(
                icon: Icon(Icons.settings_outlined),
                iconSize: 26,
                color: AppColors.primaryText,
                onPressed: onSettingsPressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
