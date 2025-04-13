// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/services/localStorage/AppLocalStorage.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/core/widgets/custom_app_bar.dart';
import 'package:habit_tracker/core/widgets/custom_button.dart';
import 'package:habit_tracker/screens/home/data/FullIconPickerScreen.dart';
import 'package:habit_tracker/screens/home/data/color_tile.dart';
import 'package:habit_tracker/screens/home/data/icon_tile.dart';
import 'package:habit_tracker/screens/home/data/showModelSheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  IconData? selectedIcon;
  Color? selectedColor;
  List<IconData> icons = [
    Icons.bedtime,
    Icons.money,
    Icons.art_track,
    Icons.book_rounded,
    Icons.alarm,
    Icons.apple,
    Icons.bed,
    Icons.book,
    Icons.code,
    Icons.phone,
    Icons.sports_mma,
    Icons.attach_money_rounded,
  ];
  List<Color> colors = [
    Color(0xFFE57373), // Red
    Color(0xFFFFB74D), // Orange
    Color(0xFFFFF176), // Yellow
    Color(0xFF81C784), // Green
    Color(0xFF4FC3F7), // Light Blue
    Color(0xFFBA68C8), // Purple
    Color(0xFFA1887F), // Brown
    Color(0xFF90A4AE), // Blue Grey
    Color(0xFF64B5F6), // Blue
    Color(0xFFAED581), // Lime Green
    Color(0xFFF06292), // Pink
    Color(0xFFB0BEC5), // Grey
    Color(0xFFFFFFFF), // White
    Color(0xFF000000), // Black
  ];

  bool isSelected = false;
  TextEditingController habitEditingController = TextEditingController();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.cardColor,
        body: Column(
          children: [
            //? AppBar
            CustomAppBar(
              userName: AppLocalStorage.getCachedData(
                key: AppLocalStorage.kUserName,
              ),
              onAddPressed: () {
                showAddHabitSheet(context);
              },
              onStatsPressed: () {},
              onSettingsPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
