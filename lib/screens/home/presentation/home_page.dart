// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/services/localStorage/AppLocalStorage.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/core/widgets/custom_app_bar.dart';
import 'package:habit_tracker/screens/habit/habit_card.dart';
import 'package:habit_tracker/screens/home/bloc/habit_bloc.dart';
import 'package:habit_tracker/screens/home/bloc/habit_event.dart';
import 'package:habit_tracker/screens/home/bloc/habit_state.dart';
import 'package:habit_tracker/screens/home/widgets/showModelSheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  bool isSelected = false;
  TextEditingController habitEditingController = TextEditingController();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.cardColor,
        body: Column(
          children: [
            //? AppBar
            CustomAppBar(
              userName: AppLocalStorage.getCachedData(
                key: AppLocalStorage.kUserName,
              ),
              onAddPressed: () {
                showAddHabitSheet(context);
              },
              onStatsPressed: () {},
              onSettingsPressed: () {},
            ),
            BlocBuilder<HabitBloc, HabitState>(
              builder: (context, state) {
                if (state is HabitListUpdated) {
                  // If we have habits, show them
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.habits.length,
                      itemBuilder: (context, index) {
                        final habit = state.habits[index];
                        return HabitCard(
                          completedDates: habit.completedDates.toList(),
                          onToggle: (DateTime day) {
                            context
                                .read<HabitBloc>()
                                .add(ToggleHabitEvent(index: index, date: day));
                          },
                          icon: habit.icon,
                          color: habit.color,
                          title: habit.title,
                          description: habit.description,
                        );
                      },
                    ),
                  );
                }
                return Center(
                  child: Text(
                    "No habits yet.",
                    style: TextStyle(color: AppColors.secondaryText),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
