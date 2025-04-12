// import 'package:flutter/material.dart';
// import 'package:habit_tracker/core/utils/colors.dart';

// Map<String, List<IconData>> iconCategories = {
//   'Activities': [
//     Icons.bed, Icons.book, Icons.code, Icons.phone, Icons.shopping_cart,
//     Icons.headset, Icons.gamepad, Icons.palette, Icons.brush,
//     Icons.directions_boat,
//     // add more...
//   ],
//   'Sports': [
//     Icons.directions_run,
//     Icons.fitness_center,
//     Icons.sports_basketball,
//     Icons.sports_soccer,
//     Icons.pool,
//     Icons.sports_mma,
//   ],
//   'Food and Beverages': [
//     Icons.apple,
//     Icons.local_pizza,
//     Icons.fastfood,
//     Icons.local_dining,
//     Icons.cake,
//     Icons.set_meal,
//   ],
// };
import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/colors.dart';

class IconTile extends StatelessWidget {
  final IconData icon;
  final IconData? selectedIcon;
  final VoidCallback onTap;

  const IconTile({
    super.key,
    required this.icon,
    required this.selectedIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIcon == icon;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: isSelected ? 2 : 1,
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
