import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class HabitModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  int iconCodePoint;

  @HiveField(3)
  int colorValue;

  @HiveField(4)
  String createdAt;

  @HiveField(5)
  List<String> completedDates;

  HabitModel({
    required this.title,
    this.description,
    required this.iconCodePoint,
    required this.colorValue,
    required this.createdAt,
    required this.completedDates,
  });

  /// These are the real types your UI will continue using:

  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');
  Color get color => Color(colorValue);
  DateTime get createdDate => DateTime.parse(createdAt);
  Set<DateTime> get completedDateSet =>
      completedDates.map((e) => DateTime.parse(e)).toSet();

  /// And if you want to modify:
  void toggleCompletion(DateTime date) {
    final iso = date.toIso8601String();
    if (completedDates.contains(iso)) {
      completedDates.remove(iso);
    } else {
      completedDates.add(iso);
    }
  }
}
