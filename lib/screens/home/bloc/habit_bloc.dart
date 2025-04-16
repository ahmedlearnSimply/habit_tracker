// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/screens/home/bloc/habit_event.dart';
import 'package:habit_tracker/screens/home/bloc/habit_state.dart';
import 'package:habit_tracker/screens/home/model/habit_model.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  //list to hold all habits
  List<HabitModel> _habits = [];
  HabitBloc() : super(HabitInitialState()) {
    on<AddHabitEvent>((event, emit) {
      _habits.add(event.habit);
      emit(HabitListUpdated(List.from(_habits)));
    });

    on<ToggleHabitEvent>((event, emit) {
      final habit = _habits[event.index];
      final isAlreadyMarked = habit.completedDates.any(
        (d) =>
            d.year == event.date.year &&
            d.month == event.date.month &&
            d.day == event.date.day,
      );

      if (isAlreadyMarked) {
        habit.completedDates.removeWhere(
          (d) =>
              d.year == event.date.year &&
              d.month == event.date.month &&
              d.day == event.date.day,
        );
      } else {
        habit.completedDates.add(event.date);
      }

      emit(HabitListUpdated(List.from(_habits)));
    });
  }
}
