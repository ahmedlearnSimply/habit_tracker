// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/core/services/localStorage/AppLocalStorage.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/widgets/custom_app_bar.dart';
import 'package:habit_tracker/screens/habit/detail_habit_card.dart';
import 'package:habit_tracker/screens/habit/habit_card.dart';
import 'package:habit_tracker/screens/home/bloc/habit_bloc.dart';
import 'package:habit_tracker/screens/home/bloc/habit_event.dart';
import 'package:habit_tracker/screens/home/bloc/habit_state.dart';
import 'package:habit_tracker/screens/home/widgets/showModelSheet.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
                        return GestureDetector(
                          onTap: () {
                            showGeneralDialog(
                              barrierLabel: 'Close habit details',
                              barrierDismissible: true,
                              barrierColor: Colors.black.withOpacity(0.5),
                              transitionDuration: Duration(milliseconds: 200),
                              transitionBuilder:
                                  (context, anim1, anim2, child) {
                                return FadeTransition(
                                  opacity: CurvedAnimation(
                                      parent: anim1, curve: Curves.easeOut),
                                  child: child,
                                );
                              },
                              context: context,
                              pageBuilder: (context, anim1, anim2) {
                                return GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  behavior: HitTestBehavior.opaque,
                                  child: BlocProvider.value(
                                    value: BlocProvider.of<HabitBloc>(context),
                                    child: BlocBuilder<HabitBloc, HabitState>(
                                      builder: (context, state) {
                                        return DetailHabitCard(
                                          habit: habit,
                                          index: index,
                                          onDelete: () {
                                            context.read<HabitBloc>().add(
                                                  DeleteHabitEvent(
                                                    index: index,
                                                  ),
                                                );
                                          },
                                          habitCard: HabitCard(
                                            description: habit.description,
                                            title: habit.title,
                                            icon: habit.icon,
                                            color: habit.color,
                                            completedDates:
                                                habit.completedDateSet.toList(),
                                            onToggle: (DateTime day) {
                                              context.read<HabitBloc>().add(
                                                    ToggleHabitEvent(
                                                        index: index,
                                                        date: day),
                                                  );
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: HabitCard(
                            completedDates: habit.completedDateSet.toList(),
                            onToggle: (DateTime day) {
                              context.read<HabitBloc>().add(
                                  ToggleHabitEvent(index: index, date: day));
                            },
                            icon: habit.icon,
                            color: habit.color,
                            title: habit.title,
                            description: habit.description,
                          ),
                        );
                      },
                    ),
                  );
                }
                return Center(
                  child: Text(
                    "لا يوجد عادات تم اضافتها",
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
