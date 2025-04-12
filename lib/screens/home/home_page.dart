// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/services/localStorage/AppLocalStorage.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/core/widgets/custom_app_bar.dart';
import 'package:habit_tracker/core/widgets/custom_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
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
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      height: 700,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'إضافة عادة جديدة',
                                style: getBodyStyle(),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.clear),
                              ),
                            ],
                          ),
                          Gap(20),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'من فضلك ادخل اسم العاده';
                              } else {
                                return null;
                              }
                            },
                            controller: habitEditingController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: AppColors.background,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              label: Row(
                                children: [
                                  Text(
                                    "اسم العاده",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(20),
                          //description of habit
                          TextFormField(
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'من فضلك ادخل اسم العاده';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            controller: habitEditingController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: AppColors.background,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 14,
                              ),
                              label: Row(
                                children: [
                                  Text(
                                    "وصف العاده  (اختياري)",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(20),
                          Spacer(),
                          CustomButton(
                            text: "حفظ",
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                );
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
