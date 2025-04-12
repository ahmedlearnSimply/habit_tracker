// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/services/localStorage/AppLocalStorage.dart';
import 'package:habit_tracker/core/utils/assets.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/screens/home/home_page.dart';
import 'package:habit_tracker/screens/onborading/page/onborading_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showLogo = false;
  bool _showTitle = false;
  bool _showSubtitle = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() => _showLogo = true);
    });

    Future.delayed(Duration(milliseconds: 700), () {
      setState(() => _showTitle = true);
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() => _showSubtitle = true);
    });

    Future.delayed(Duration(seconds: 2), () {
      bool isOnboardingShown =
          AppLocalStorage.getCachedData(key: AppLocalStorage.kOnboarding) ??
              false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isOnboardingShown ? HomePage() : OnboradingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: _showLogo ? 1.0 : 0.0,
                curve: Curves.easeInOut,
                child: SvgPicture.asset(
                  AppAssets.logoSvg,
                  height: 300,
                ),
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: _showTitle ? 1.0 : 0.0,
                curve: Curves.easeInOut,
                child: Text(
                  "أثر",
                  style: getTitleStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              Gap(10),
              AnimatedOpacity(
                duration: Duration(milliseconds: 800),
                opacity: _showSubtitle ? 1.0 : 0.0,
                curve: Curves.easeInOut,
                child: Text(
                  "كل عادة تترك أثرًا",
                  style: getSmallStyle(
                    fontSize: 18,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
