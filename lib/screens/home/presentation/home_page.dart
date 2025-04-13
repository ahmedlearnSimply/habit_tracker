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
  ];
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.purple,
    Colors.orange,
    Colors.brown,
    Colors.grey,
    Colors.white,
    Colors.amber,
    Colors.lime,
    Colors.cyan,
    Colors.teal,
    Colors.indigo,
    Colors.blueGrey,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.lightGreenAccent,
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
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setModalState) {
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: SizedBox(
                            height: 700,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                Text(
                                  'العلامه',
                                  style: getBodyStyle(),
                                ),
                                Gap(15),
                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: icons.map((icons) {
                                    return IconTile(
                                      icon: icons,
                                      isSelected: selectedIcon == icons,
                                      onTap: () {
                                        setModalState(() {
                                          selectedIcon = icons;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),

                                Gap(20),
                                Text(
                                  'لون العاده',
                                  style: getBodyStyle(),
                                ),
                                Gap(15),

                                Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: colors.map((color) {
                                    return ColorTile(
                                      color: color,
                                      isSelected: selectedColor == color,
                                      onTap: () {
                                        setModalState(() {
                                          selectedColor = color;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),

                                Spacer(),
                                CustomButton(
                                  text: "حفظ",
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                        );
                      });
                    });
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
//                          Wrap(
                                //   spacing: 12,
                                //   runSpacing: 12,
                                //   children: [
                                //     IconTile(
                                //       icon: Icons.alarm,
                                //       isSelected: selectedIcon == Icons.alarm,
                                //       onTap: () => setModalState(
                                //           () => selectedIcon = Icons.alarm),
                                //     ),
                                //     IconTile(
                                //       icon: Icons.apple,
                                //       isSelected: selectedIcon == Icons.apple,
                                //       onTap: () => setModalState(
                                //           () => selectedIcon = Icons.apple),
                                //     ),
                                //     IconTile(
                                //       icon: Icons.bedtime,
                                //       isSelected: selectedIcon == Icons.bedtime,
                                //       onTap: () => setModalState(
                                //           () => selectedIcon = Icons.bedtime),
                                //     ),
                                //     IconTile(
                                //       icon: Icons.attach_money_rounded,
                                //       isSelected: selectedIcon == Icons.money,
                                //       onTap: () => setModalState(
                                //           () => selectedIcon = Icons.money),
                                //     ),
                                //     IconTile(
                                //       icon: Icons.art_track,
                                //       isSelected:
                                //           selectedIcon == Icons.art_track,
                                //       onTap: () => setModalState(
                                //           () => selectedIcon = Icons.art_track),
                                //     ),
                                //     IconTile(
                                //       icon: Icons.sports_mma,
                                //       isSelected:
                                //           selectedIcon == Icons.sports_mma,
                                //       onTap: () => setModalState(() =>
                                //           selectedIcon = Icons.sports_mma),
                                //     ),
                                //     IconTile(
                                //       icon: Icons.book_rounded,
                                //       isSelected:
                                //           selectedIcon == Icons.book_rounded,
                                //       onTap: () => setModalState(() =>
                                //           selectedIcon = Icons.book_rounded),
                                //     ),

                                //     // ...
                                //     GestureDetector(
                                //       onTap: () async {
                                //         final result = await Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (_) =>
                                //                   FullIconPickerScreen()),
                                //         );
                                //         if (result != null &&
                                //             result is IconData) {
                                //           setModalState(() {
                                //             selectedIcon = result;
                                //           });
                                //         }
                                //       },
                                //       child: Container(
                                //         // margin: EdgeInsets.all(6),
                                //         width: 50,
                                //         height: 50,
                                //         decoration: BoxDecoration(
                                //           color: AppColors.background,
                                //           borderRadius:
                                //               BorderRadius.circular(12),
                                //           border: Border.all(
                                //             color: AppColors.background,
                                //             width: 1,
                                //           ),
                                //         ),
                                //         child: Center(
                                //           child: Text(
                                //             "المزيد",
                                //             style: getSmallStyle(
                                //                 color: Colors.white),
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
