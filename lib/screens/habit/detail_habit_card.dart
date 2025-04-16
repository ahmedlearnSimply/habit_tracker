// ignore_for_file: use_key_in_widget_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/screens/habit/habit_card.dart';

class DetailHabitCard extends StatelessWidget {
  HabitCard habitCard;
  DetailHabitCard({
    required this.habitCard,
    Key? key,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors
          .transparent, // Makes sure we can see through to the blurred background
      child: Stack(
        children: [
          // 1. The blurred and dimmed background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // 2. The foreground UI for the habit tracker
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: HabitCard(
                title: habitCard.title,
                description: habitCard.description,
                icon: habitCard.icon,
                color: habitCard.color,
                completedDates: habitCard.completedDates,
                onToggle: habitCard.onToggle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
