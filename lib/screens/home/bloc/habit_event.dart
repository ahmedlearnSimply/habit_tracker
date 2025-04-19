import 'package:habit_tracker/screens/home/model/habit_model.dart';

class HabitEvent {}

class AddHabitEvent extends HabitEvent {
  final HabitModel habit;
  AddHabitEvent(this.habit);
}

class ToggleHabitEvent extends HabitEvent {
  final int index;
  final DateTime date;
  ToggleHabitEvent({required this.index, required this.date});
}

class DeleteHabitEvent extends HabitEvent {
  final int index;
  DeleteHabitEvent({required this.index});
}
