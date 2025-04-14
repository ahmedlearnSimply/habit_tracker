import 'package:flutter/material.dart';

class HabitModel {
  final String title;
  final String? description;
  final IconData icon;
  final Color color;
  final DateTime createdAt;

  HabitModel({
    required this.title,
    this.description,
    required this.icon,
    required this.color,
    required this.createdAt,
  });
}
