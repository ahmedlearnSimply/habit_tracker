// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                                // index++;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(habit.colorValue).withOpacity(0.2),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                        color: widget.habits[0].color,
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
              Container(
                  child: Row(
                children: [
                  Text(
                    "dfasd",
                    style: getBodyStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
