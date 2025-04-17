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
import 'package:habit_tracker/screens/home/model/habit_model.dart';
import 'package:habit_tracker/screens/home/widgets/showModelSheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.cardColor,
        body: Column(
          children: [
            CustomAppBar(
              userName: AppLocalStorage.getCachedData(
                key: AppLocalStorage.kUserName,
              ),
              onAddPressed: () => showAddHabitSheet(context),
              onStatsPressed: () {},
              onSettingsPressed: () {},
            ),
            Expanded(
              child: BlocBuilder<HabitBloc, HabitState>(
                builder: (context, state) {
                  if (state is HabitListUpdated) {
                    if (state.habits.isEmpty) {
                      return _buildEmptyState(context);
                    }
                    return ListView.builder(
                      itemCount: state.habits.length,
                      itemBuilder: (context, index) {
                        return _buildHabitCard(
                            context, state.habits[index], index);
                      },
                    );
                  }
                  return _buildEmptyState(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Text(
        "No habits yet.",
        style: TextStyle(color: AppColors.secondaryText),
      ),
    );
  }

  Widget _buildHabitCard(BuildContext context, HabitModel habit, int index) {
    return GestureDetector(
      onTap: () => _showHabitDetail(context, habit, index),
      child: HabitCard(
        completedDates: habit.completedDates.toList(),
        onToggle: (DateTime day) {
          context.read<HabitBloc>().add(
                ToggleHabitEvent(index: index, date: day),
              );
        },
        icon: habit.icon,
        color: habit.color,
        title: habit.title,
        description: habit.description,
      ),
    );
  }

  void _showHabitDetail(BuildContext context, HabitModel habit, int index) {
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<HabitBloc>(context),
        child: BlocBuilder<HabitBloc, HabitState>(
          builder: (context, state) {
            if (state is HabitListUpdated) {
              final updatedHabit = state.habits[index];
              return Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(16),
                child: DetailHabitCard(
                  habitCard: HabitCard(
                    completedDates: updatedHabit.completedDates.toList(),
                    onToggle: (DateTime day) {
                      context.read<HabitBloc>().add(
                            ToggleHabitEvent(index: index, date: day),
                          );
                    },
                    icon: updatedHabit.icon,
                    color: updatedHabit.color,
                    title: updatedHabit.title,
                    description: updatedHabit.description,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
