import 'package:flutter/material.dart';

class HabitModel {
  final String title;
  final String? description;
  final IconData icon;
  final Color color;
  final DateTime createdAt;
  final Set<DateTime> completedDates;

  HabitModel({
    required this.title,
    this.description,
    Set<DateTime>? completedDates,
    required this.icon,
    required this.color,
    required this.createdAt,
  }) : completedDates = completedDates ?? {};
}
