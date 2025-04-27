// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/screens/habit/habit_card.dart';
import 'package:habit_tracker/screens/home/model/habit_model.dart';

class InsightsScreen extends StatefulWidget {
  final List<HabitModel> habits;

  InsightsScreen({
    required this.habits,
    super.key,
  });

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  @override
  int index = 0;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.cardColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: widget.habits.map((habit) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  index = widget.habits.indexOf(habit);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color:
                                      Color(habit.colorValue).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  IconData(habit.iconCodePoint,
                                      fontFamily: 'MaterialIcons'),
                                  color: Color(habit.colorValue),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Gap(5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 70,
                        decoration: BoxDecoration(
                          color: widget.habits[index].color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            "تم",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(30),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(widget.habits[index].colorValue)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            IconData(widget.habits[index].iconCodePoint,
                                fontFamily: 'MaterialIcons'),
                            color: Color(widget.habits[index].colorValue),
                          ),
                        ),
                        Gap(10),
                        Flexible(
                          child: Text(
                            widget.habits[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(10),
                //!year selector
                //? habit card
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Center(
                      child: _buildGrid(
                        widget.habits[index].completedDateSet.toList(),
                        Color(widget.habits[index].colorValue),
                      ),
                    ),
                  ),
                ),
                Gap(20),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          // mainAxisAlignment: ,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(widget.habits[index].colorValue)
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.star,
                                color: Color(widget.habits[index].colorValue),
                              ),
                            ),
                            Gap(10),
                            Text(
                              "عدد الاتمامات",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            )
                          ],
                        ),
                        Gap(10),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(widget.habits[index].colorValue)
                                .withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              "${widget.habits[index].completedDates.length}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
        const int rows = 12; // For example, fixed number of rows

        double dotSize = 15; // dynamic size
        int columns = 6;

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
}
