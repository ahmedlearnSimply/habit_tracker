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
              }
              // onAddPressed: () {
              //   showModalBottomSheet(
              //       context: context,
              //       isScrollControlled: true,
              //       shape: RoundedRectangleBorder(
              //         borderRadius:
              //             BorderRadius.vertical(top: Radius.circular(20)),
              //       ),
              //       builder: (context) {
              //         return StatefulBuilder(builder: (context, setModalState) {
              //           return SingleChildScrollView(
              //             child: Padding(
              //               padding: EdgeInsets.only(
              //                 left: 16,
              //                 right: 16,
              //                 top: 24,
              //                 bottom:
              //                     MediaQuery.of(context).viewInsets.bottom + 16,
              //               ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisSize: MainAxisSize.min,
              //                 children: [
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text(
              //                         'إضافة عادة جديدة',
              //                         style: getBodyStyle(),
              //                       ),
              //                       IconButton(
              //                         onPressed: () {
              //                           Navigator.pop(context);
              //                         },
              //                         icon: Icon(Icons.clear),
              //                       ),
              //                     ],
              //                   ),
              //                   Gap(20),
              //                   TextFormField(
              //                     validator: (value) {
              //                       if (value!.isEmpty) {
              //                         return 'من فضلك ادخل اسم العاده';
              //                       } else {
              //                         return null;
              //                       }
              //                     },
              //                     controller: habitEditingController,
              //                     decoration: InputDecoration(
              //                       floatingLabelAlignment:
              //                           FloatingLabelAlignment.center,
              //                       enabledBorder: OutlineInputBorder(
              //                         borderRadius:
              //                             BorderRadius.all(Radius.circular(10)),
              //                         borderSide: BorderSide.none,
              //                       ),
              //                       fillColor: AppColors.background,
              //                       contentPadding: EdgeInsets.symmetric(
              //                         horizontal: 20,
              //                         vertical: 14,
              //                       ),
              //                       labelText: "اسم العاده",
              //                     ),
              //                   ),
              //                   Gap(25),
              //                   //description of habit
              //                   TextFormField(
              //                     // validator: (value) {
              //                     //   if (value!.isEmpty) {
              //                     //     return 'من فضلك ادخل اسم العاده';
              //                     //   } else {
              //                     //     return null;
              //                     //   }
              //                     // },
              //                     controller: habitEditingController,
              //                     decoration: InputDecoration(
              //                       enabledBorder: OutlineInputBorder(
              //                         borderRadius:
              //                             BorderRadius.all(Radius.circular(10)),
              //                         borderSide: BorderSide.none,
              //                       ),
              //                       fillColor: AppColors.background,
              //                       contentPadding: EdgeInsets.symmetric(
              //                         horizontal: 20,
              //                         vertical: 14,
              //                       ),
              //                       floatingLabelAlignment:
              //                           FloatingLabelAlignment.center,
              //                       labelText: "وصف العاده  (اختياري)",
              //                     ),
              //                   ),
              // Gap(25),
              // Text(
              //   'العلامه',
              //   style: getBodyStyle(),
              // ),
              // Gap(15),

              // Wrap(
              //   spacing: 12,
              //   runSpacing: 12,
              //   children: icons.map((icons) {
              //     return IconTile(
              //       icon: icons,
              //       isSelected: selectedIcon == icons,
              //       onTap: () {
              //         setModalState(() {
              //           selectedIcon = icons;
              //         });
              //       },
              //     );
              //   }).toList(),
              // ),
              // Gap(12),

              // GestureDetector(
              //   onTap: () async {
              //     final result = await Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (_) =>
              //               FullIconPickerScreen()),
              //     );
              //     if (result != null && result is IconData) {
              //       setModalState(() {
              //         selectedIcon = result;
              //       });
              //     }
              //   },
              //   child: Container(
              //     // margin: EdgeInsets.all(6),
              //     width: 50,
              //     height: 50,
              //     decoration: BoxDecoration(
              //       color: AppColors.background,
              //       borderRadius: BorderRadius.circular(12),
              //       border: Border.all(
              //         color: AppColors.background,
              //         width: 1,
              //       ),
              //     ),
              //     child: Center(
              //       child: Text(
              //         "المزيد",
              //         style:
              //             getSmallStyle(color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),

              // Gap(20),
              // Text(
              //   'لون العاده',
              //   style: getBodyStyle(),
              // ),
              // Gap(15),

              // Wrap(
              //   spacing: 12,
              //   runSpacing: 12,
              //   children: colors.map((color) {
              //     return ColorTile(
              //       color: color,
              //       isSelected: selectedColor == color,
              //       onTap: () {
              //         setModalState(() {
              //           selectedColor = color;
              //         });
              //       },
              //     );
              //   }).toList(),
              // ),
              // Gap(24),
              // // Button fixed at the bottom
              // Padding(
              //   padding: const EdgeInsets.only(
              //       top: 12.0, bottom: 16),
              //   child: CustomButton(
              //     text: "حفظ",
              //     onPressed: () {},
              //   ),
              // ),

              // Gap(16),
              //                 ],
              //               ),
              //             ),
              //           );
              //         });
              //       });
              // },
              ,
              onStatsPressed: () {},
              onSettingsPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
