import 'package:habit_tracker/screens/home/model/habit_model.dart';

class HabitState {}

class HabitInitialState extends HabitState {}

class HabitListUpdated extends HabitState {
  final List<HabitModel> habits;
  HabitListUpdated(this.habits);
}
