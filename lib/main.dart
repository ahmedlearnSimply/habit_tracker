// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/theme.dart';
import 'package:habit_tracker/screens/onborading/model/onboarding_model.dart';
import 'package:habit_tracker/screens/onborading/page/onborading_screen.dart';
import 'package:habit_tracker/screens/splash/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: OnboradingScreen(),
    );
  }
}
