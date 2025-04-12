import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/colors.dart';

Map<String, List<IconData>> iconCategories = {
  'Activities': [
    Icons.bed, Icons.book, Icons.code, Icons.phone, Icons.shopping_cart,
    Icons.headset, Icons.gamepad, Icons.palette, Icons.brush,
    Icons.directions_boat,
    // add more...
  ],
  'Sports': [
    Icons.directions_run,
    Icons.fitness_center,
    Icons.sports_basketball,
    Icons.sports_soccer,
    Icons.pool,
    Icons.sports_mma,
  ],
  'Food and Beverages': [
    Icons.apple,
    Icons.local_pizza,
    Icons.fastfood,
    Icons.local_dining,
    Icons.cake,
    Icons.set_meal,
  ],
};

Widget iconTile(IconData icon, bool isSelected) {
  return Container(
    margin: EdgeInsets.all(6),
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      color: AppColors.background,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isSelected ? Colors.white : AppColors.background,
        width: 1,
      ),
    ),
    child: Center(
      child: Icon(icon, color: Colors.white, size: 18),
    ),
  );
}
