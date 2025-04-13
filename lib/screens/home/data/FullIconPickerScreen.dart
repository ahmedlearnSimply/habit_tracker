// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';

class FullIconPickerScreen extends StatelessWidget {
  FullIconPickerScreen({super.key});

  final List<IconData> icons = const [
    Icons.bed,
    Icons.book,
    Icons.alarm,
    Icons.fitness_center,
    Icons.star,
    Icons.music_note,
    Icons.palette,
    Icons.code,
    Icons.timer,
    Icons.sports_basketball,
    Icons.money,
    Icons.food_bank,
  ];

  final Map<String, List<IconData>> iconCategories = {
    'انشطه': [
      Icons.bed,
      Icons.book,
      Icons.code,
      Icons.phone,
      Icons.shopping_cart,
      Icons.headset,
      Icons.gamepad,
      Icons.palette,
      Icons.brush,
      Icons.directions_boat,
    ],
    'رياضه': [
      Icons.directions_run,
      Icons.fitness_center,
      Icons.sports_basketball,
      Icons.sports_soccer,
      Icons.pool,
      Icons.sports_mma,
    ],
    'المأكولات والمشروبات': [
      Icons.apple,
      Icons.local_pizza,
      Icons.fastfood,
      Icons.local_dining,
      Icons.cake,
      Icons.set_meal,
    ],
    'الصحة والعافية': [
      Icons.accessibility_new,
      Icons.spa,
      Icons.health_and_safety,
      Icons.self_improvement,
    ],
    'إنتاجية': [
      Icons.work,
      Icons.alarm,
      Icons.note,
      Icons.calendar_today,
      Icons.done,
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        title: Text(
          "اختر أيقونة",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.cardColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: iconCategories.entries.map((entry) {
            final categoryName = entry.key;
            final icons = entry.value;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(30),
                Text(
                  categoryName,
                  style: getSmallStyle(),
                ),
                Gap(10),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: icons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(
                            context, iconCategories[categoryName]![index]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          icons[index],
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

// GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 50,
//         height: 50,
//         decoration: BoxDecoration(
//           color: AppColors.background,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: isSelected ? Colors.white : Colors.transparent,
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Icon(
//           icon,
//           color: Colors.white,
//           size: 25,
//         ),
//       ),
//     );
