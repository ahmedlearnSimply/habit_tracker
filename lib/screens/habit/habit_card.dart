// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';

class HabitCard extends StatefulWidget {
  Color color;
  String title;
  final List<DateTime> completedDates;
  final Function(DateTime) onToggle;

  String? description = " ";
  IconData icon;
  HabitCard({
    super.key,
    required this.title,
    this.description,
    required this.icon,
    required this.color,
    required this.completedDates,
    required this.onToggle,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();
    final bool isTodayCompleted = widget.completedDates.any((d) =>
        d.year == today.year && d.month == today.month && d.day == today.day);
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
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
                            color: widget.color.withOpacity(.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(
                              widget.icon,
                              size: 29,
                            ),
                          ),
                        ),
                        Gap(20),
                        Expanded(
                          // ✅ still needed here to make text flexible
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: getBodyStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                widget.description ?? '',
                                style: getSmallStyle(
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Optional trailing widget, e.g., check icon
                  Gap(10),
                  GestureDetector(
                    onTap: () => widget.onToggle(today),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isTodayCompleted
                            ? widget.color
                            : widget.color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                        ),
                      ),
                    ),
                  ),
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
          final isCompleted = widget.completedDates.any((d) =>
              d.year == day.year && d.month == day.month && d.day == day.day);

          return GestureDetector(
            onTap: () => widget.onToggle(day),
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color:
                    isCompleted ? widget.color : widget.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        }),
      ),
    );
  }
}
