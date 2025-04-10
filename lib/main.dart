// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('ar')],
      locale: Locale('ar'),
      theme: AppThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: OnboradingScreen(),
    );
  }
}
