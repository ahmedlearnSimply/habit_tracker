// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/screens/habit/habit_card.dart';

class DetailHabitCard extends StatelessWidget {
  HabitCard habitCard;

  DetailHabitCard({
    super.key,
    required this.habitCard,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final bool isTodayCompleted = habitCard.completedDates.any((d) =>
        d.year == today.year && d.month == today.month && d.day == today.day);
    return Material(
      color: Colors
          .transparent, // Makes sure we can see through to the blurred background
      child: Stack(
        children: [
          // 1. The blurred and dimmed background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(0),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.secondaryText,
                      width: .1,
                    ),
                  ),
                  width: double.infinity,
                  height: 180,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              // ✅ wrap this entire inner Row
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: habitCard.color.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        habitCard.icon,
                                        size: 29,
                                      ),
                                    ),
                                  ),
                                  Gap(20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          habitCard.title,
                                          style: getBodyStyle(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          habitCard.description ?? '',
                                          style: getSmallStyle(
                                            fontSize: 12,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.clear),
                                  )
                                ],
                              ),
                            ),
                            // Optional trailing widget, e.g., check icon
                          ],
                        ),
                        Gap(20),
                        Expanded(
                          child: _buildGrid(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    final DateTime today = DateTime.now();
    final DateTime startOfYear = DateTime(today.year, 1, 1);
    final DateTime endDate =
        today.add(Duration(days: 7)); // one month in future

    final int totalDays = endDate.difference(startOfYear).inDays + 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        textDirection: TextDirection.ltr,
        spacing: 4,
        runSpacing: 4,
        direction: Axis.vertical,
        children: List.generate(totalDays, (index) {
          final day = startOfYear.add(Duration(days: index));
          final isPastOrToday = !day.isAfter(today);
          final isCompleted = habitCard.completedDates.any((d) =>
              d.year == day.year && d.month == day.month && d.day == day.day);

          return GestureDetector(
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isCompleted
                    ? habitCard.color
                    : habitCard.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        }),
      ),
    );
  }
}
