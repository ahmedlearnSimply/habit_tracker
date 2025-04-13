import 'package:flutter/material.dart';
import 'package:habit_tracker/core/utils/colors.dart';

class ColorTile extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Color color;

  ColorTile({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
