// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/screens/habit/detail_habit_card.dart';

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
    final size = MediaQuery.of(context).size;
    final cardW = size.width * 1;
    final cardH = size.height * 0.4;
    final DateTime today = DateTime.now();
    final bool isTodayCompleted = widget.completedDates.any((d) =>
        d.year == today.year && d.month == today.month && d.day == today.day);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Center(
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
          height: 200,
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
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: widget.color.withOpacity(.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Icon(
                                widget.icon,
                                size: 24,
                              ),
                            ),
                          ),
                          Gap(20),
                          Expanded(
                            child: Text(
                              widget.title,
                              style: getBodyStyle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    GestureDetector(
                      onTap: () => widget.onToggle(today),
                      child: Container(
                        width: 40,
                        height: 40,
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
                // Gap(10),
                // if (widget.description!.isNotEmpty)
                //   Align(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       widget.description ?? '',
                //       style: getSmallStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.normal,
                //       ),
                //       maxLines: 1,
                //       overflow: TextOverflow.ellipsis,
                //     ),
                //   ),
                Gap(20),
                Expanded(
                    child: _buildGrid(
                  widget.completedDates,
                  widget.color,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(List<DateTime> completedDates, Color color) {
    final DateTime today = DateTime.now();
    final DateTime startOfYear = DateTime(today.year, 1, 1);
    final DateTime endDate = today.add(Duration(days: 0)); // Up to today only

    final int totalDays = endDate.difference(startOfYear).inDays + 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate rows and columns based on container height/width
        const double spacing = 4;
        const int rows = 6; // For example, fixed number of rows

        double dotSize = (constraints.maxHeight - (rows - 2) * spacing) /
            rows; // dynamic size
        int columns = (constraints.maxWidth / (dotSize + spacing)).floor();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            textDirection: TextDirection.ltr,
            spacing: spacing,
            runSpacing: spacing,
            direction: Axis.vertical,
            children: List.generate(totalDays, (index) {
              final day = startOfYear.add(Duration(days: index));
              final isCompleted = completedDates.any((d) =>
                  d.year == day.year &&
                  d.month == day.month &&
                  d.day == day.day);

              return Container(
                width: dotSize,
                height: dotSize + 1,
                decoration: BoxDecoration(
                  color: isCompleted ? color : color.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  // Widget _buildGrid(List<DateTime> completedDates, Color color) {
  //   final DateTime today = DateTime.now();
  //   final DateTime startOfYear = DateTime(today.year, 1, 1);
  //   final DateTime endDate = today.add(Duration(days: 2)); // Up to today only

  //   final int totalDays = endDate.difference(startOfYear).inDays + 1;

  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Wrap(
  //       textDirection: TextDirection.ltr,
  //       spacing: 4,
  //       runSpacing: 4,
  //       direction: Axis.vertical,
  //       children: List.generate(totalDays, (index) {
  //         final day = startOfYear.add(Duration(days: index));
  //         final isCompleted = completedDates.any((d) =>
  //             d.year == day.year && d.month == day.month && d.day == day.day);

  //         return Container(
  //           width: 11,
  //           height: 11,
  //           decoration: BoxDecoration(
  //             color: isCompleted ? color : color.withOpacity(0.13),
  //             borderRadius: BorderRadius.circular(3),
  //           ),
  //         );
  //       }),
  //     ),
  //   );
  // }
}
