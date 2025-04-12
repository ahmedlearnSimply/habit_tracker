// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/services/localStorage/AppLocalStorage.dart';
import 'package:habit_tracker/core/utils/assets.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/core/widgets/custom_button.dart';
import 'package:habit_tracker/screens/home/presentation/home_page.dart';
import 'package:habit_tracker/screens/onborading/model/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboradingScreen extends StatefulWidget {
  const OnboradingScreen({super.key});

  @override
  State<OnboradingScreen> createState() => _OnboradingScreenState();
}

class _OnboradingScreenState extends State<OnboradingScreen> {
  @override
  PageController pageController = new PageController();
  GlobalKey<FormState> _formState = GlobalKey();
  TextEditingController textEditingController = TextEditingController();
  int pageIndex = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formState,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      pageIndex = value;
                    });
                  },
                  controller: pageController,
                  itemCount: onboardingPages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(
                          flex: 2,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF1E1E1E), // background for the icon
                          ),
                          child: SvgPicture.asset(
                            onboardingPages[index].image,
                            height: 100,
                          ),
                        ),
                        Gap(40),
                        Text(
                          onboardingPages[index].title,
                          style: getTitleStyle(
                            fontSize: 36,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Gap(20),
                        Text(
                          onboardingPages[index].description,
                          style: getSmallStyle(
                            color: AppColors.secondaryText,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Gap(30),
                        if (pageIndex == onboardingPages.length - 1)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك ادخل اسمك';
                                } else {
                                  return null;
                                }
                              },
                              controller: textEditingController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                                label: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "ادخل اسمك هنا",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Spacer(
                          flex: 2,
                        )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (pageIndex != onboardingPages.length - 1)
                      TextButton(
                        onPressed: () {
                          pageController.jumpToPage(onboardingPages.length - 1);
                        },
                        child: Text("تخطي",
                            style: getSmallStyle(
                                fontSize: 16, color: AppColors.secondaryText)),
                      ),
                    if (pageIndex == onboardingPages.length - 1)
                      TextButton(
                        onPressed: () {
                          pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                        child: Text("رجوع",
                            style: getSmallStyle(
                                fontSize: 16, color: AppColors.secondaryText)),
                      ),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: onboardingPages.length,
                      effect: ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        spacing: 5,
                        dotColor: AppColors.secondaryText,
                        activeDotColor: AppColors.primaryText,
                      ),
                    ),
                    if (pageIndex != onboardingPages.length - 1)
                      CustomButton(
                        width: 100,
                        height: 60,
                        text: "التالي",
                        onPressed: () {
                          pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                      ),
                    if (pageIndex == onboardingPages.length - 1)
                      CustomButton(
                        width: 100,
                        height: 80,
                        text: "يلا نبدا",
                        onPressed: () {
                          if (_formState.currentState!.validate()) {
                            print("okay");
                            AppLocalStorage.cacheData(
                                key: AppLocalStorage.kOnboarding, value: true);
                            AppLocalStorage.cacheData(
                                key: AppLocalStorage.kUserName,
                                value: textEditingController.text);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
