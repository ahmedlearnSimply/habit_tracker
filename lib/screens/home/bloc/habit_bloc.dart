// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/screens/home/bloc/habit_event.dart';
import 'package:habit_tracker/screens/home/bloc/habit_state.dart';
import 'package:habit_tracker/screens/home/model/habit_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  //list to hold all habits
  List<HabitModel> _habits = [];
  HabitBloc() : super(HabitInitialState()) {
    on<AddHabitEvent>((event, emit) async {
      final box = Hive.box<HabitModel>('habits');
      await box.add(event.habit);
      // _habits.add(event.habit);
      emit(HabitListUpdated(box.values.toList()));
    });

    on<ToggleHabitEvent>((event, emit) async {
      final box = Hive.box<HabitModel>('habits');
      final habit = box.getAt(event.index);
      final isoDate = event.date.toIso8601String();

      // final habit = _habits[event.index];
      final isAlreadyMarked = habit!.completedDates.any((d) {
        final parsed = DateTime.parse(d);

        return parsed.year == event.date.year &&
            parsed.month == event.date.month &&
            parsed.day == event.date.day;
      });

      if (isAlreadyMarked) {
        habit.completedDates.removeWhere((d) {
          final parsed = DateTime.parse(d);

          return parsed.year == event.date.year &&
              parsed.month == event.date.month &&
              parsed.day == event.date.day;
        });
      } else {
        habit.completedDates.add(isoDate);
      }
      await habit.save();
      emit(HabitListUpdated(box.values.toList()));
    });
  }
}
