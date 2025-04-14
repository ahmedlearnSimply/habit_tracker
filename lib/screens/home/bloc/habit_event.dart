import 'package:habit_tracker/screens/home/model/habit_model.dart';

class HabitEvent {}

class AddHabitEvent extends HabitEvent {
  final HabitModel habit;
  AddHabitEvent(this.habit);
}
