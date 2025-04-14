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
  }
}
