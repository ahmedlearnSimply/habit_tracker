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
                HabitCard(
                  ver: 0,
                  hor: 0,
                  title: widget.habits[index].title,
                  icon: IconData(widget.habits[index].iconCodePoint,
                      fontFamily: 'MaterialIcons'),
                  color: Color(widget.habits[index].colorValue),
                  onToggle: (date) {},
                  completedDates:
                      widget.habits[index].completedDateSet.toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
