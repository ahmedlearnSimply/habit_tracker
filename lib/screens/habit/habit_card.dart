// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/screens/home/bloc/habit_bloc.dart';
import 'package:habit_tracker/screens/home/bloc/habit_state.dart';
import 'package:habit_tracker/screens/home/model/habit_model.dart';

class HabitCard extends StatefulWidget {
  Color color;
  String title;
  String? description = " ";
  IconData icon;
  HabitCard({
    super.key,
    required this.title,
    this.description,
    required this.icon,
    required this.color,
    // required this.habitModel,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  @override
  Widget build(BuildContext context) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      Column(
                        children: [
                          Text(
                            widget.title,
                            style: getTitleStyle(),
                          ),
                          Text(
                            widget.description!,
                            style: getSmallStyle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
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
    final DateTime endDate = today.add(Duration(days: 7)); // one week in future

    final int totalDays = endDate.difference(startOfYear).inDays + 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        direction: Axis.vertical,
        children: List.generate(totalDays, (index) {
          final day = startOfYear.add(Duration(days: index));
          final isPastOrToday = !day.isAfter(today);

          return Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }
}
