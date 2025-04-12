// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/services/localStorage/AppLocalStorage.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/core/widgets/custom_app_bar.dart';
import 'package:habit_tracker/core/widgets/custom_button.dart';
import 'package:habit_tracker/screens/home/data/icon_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  IconData? selectedIcon;

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
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
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
                              labelText: "اسم العاده",
                            ),
                          ),
                          Gap(25),
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
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              labelText: "وصف العاده  (اختياري)",
                            ),
                          ),
                          Gap(25),
                          Text("icons"),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              iconTile(Icons.sports_gymnastics),
                              iconTile(Icons.bedtime),
                              iconTile(Icons.book),
                              iconTile(Icons.money),
                              iconTile(Icons.art_track),
                              iconTile(Icons.brightness_1),
                              iconTile(Icons.panorama_wide_angle),
                              iconTile(Icons.place),
                              iconTile(Icons.music_note),
                              iconTile(Icons.panorama_wide_angle),
                              iconTile(Icons.place),

                              // ...
                              GestureDetector(
                                onTap: () async {
                                  // final result = await Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (_) => FullIconPickerScreen()),
                                  // );
                                  // if (result != null && result is IconData) {
                                  //   setState(() {
                                  //     selectedIcon = result;
                                  //   });
                                  // }
                                },
                                child: Container(
                                  // margin: EdgeInsets.all(6),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.background,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "المزيد",
                                      style: getSmallStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

  Widget iconTile(IconData icon) {
    final isSelected = selectedIcon == icon;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIcon = icon;
        });
      },
      child: Container(
        // margin: EdgeInsets.all(6),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.white : AppColors.background,
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
