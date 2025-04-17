import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/screens/habit/habit_card.dart';

class DetailHabitCard extends StatelessWidget {
  final HabitCard habitCard;

  const DetailHabitCard({
    super.key,
    required this.habitCard,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardW = size.width * 1;
    final cardH = size.height * 0.3;
    final DateTime today = DateTime.now();
    final bool isTodayCompleted = habitCard.completedDates.any((d) =>
        d.year == today.year && d.month == today.month && d.day == today.day);

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Blurred background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.black.withOpacity(0.3)),
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
                  width: cardW,
                  height: cardH,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
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
                                          style: getSmallStyle(fontSize: 12),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(Icons.clear),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                        Expanded(
                          child: _buildGrid(context), // Pass context here
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

  Widget _buildGrid(BuildContext context) {
    final DateTime today = DateTime.now();
    final DateTime startOfYear = DateTime(today.year, 1, 1);
    final DateTime endDate = today.add(Duration(days: 7));
    final int totalDays = endDate.difference(startOfYear).inDays + 1;

    // Calculate available width minus padding
    final availableWidth =
        MediaQuery.of(context).size.width - 32; // 16 padding on each side

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: availableWidth, // Force full width
        child: Wrap(
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          textDirection: TextDirection.ltr,
          spacing: 4,
          runSpacing: 4,
          children: List.generate(totalDays, (index) {
            final day = startOfYear.add(Duration(days: index));
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
      ),
    );
  }
}
