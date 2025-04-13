// import 'package:flutter/material.dart';
// import 'package:habit_tracker/core/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/colors.dart';

class IconTile extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  IconTile({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
