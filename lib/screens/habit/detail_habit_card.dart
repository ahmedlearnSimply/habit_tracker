// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/screens/habit/habit_card.dart';
import 'package:habit_tracker/screens/home/model/habit_model.dart';
import 'package:habit_tracker/screens/home/widgets/showModelSheet.dart';

class DetailHabitCard extends StatefulWidget {
  final HabitCard habitCard;
  final HabitModel habit;
  final int index;

  final VoidCallback? onDelete;
  DetailHabitCard({
    super.key,
    required this.habit,
    this.onDelete,
    required this.habitCard,
    required this.index,
  });

  @override
  State<DetailHabitCard> createState() => _DetailHabitCardState();
}

class _DetailHabitCardState extends State<DetailHabitCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardW = size.width * 1;
    final cardH = size.height * 0.4;
    final DateTime today = DateTime.now();
    final bool isTodayCompleted = widget.habitCard.completedDates.any((d) =>
        d.year == today.year && d.month == today.month && d.day == today.day);
    bool isPressed = false;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Blurred background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(0),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.secondaryText,
                      width: .1,
                    ),
                  ),
                  width: cardW,
                  height: cardH,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: widget.habitCard.color.withOpacity(.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  widget.habitCard.icon,
                                  size: 23,
                                ),
                              ),
                            ),
                            Gap(10),
                            Expanded(
                              child: Text(
                                widget.habitCard.title,
                                style: getBodyStyle(
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.clear),
                            ),
                          ],
                        ),
                        Gap(10),
                        if (widget.habitCard.description!.isNotEmpty)
                          Expanded(
                            child: Text(
                              widget.habitCard.description ?? '',
                              style: getSmallStyle(fontSize: 12),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        Gap(10),
                        Expanded(child: _buildGrid(context)),
                        Gap(20),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ...[
                                Icons.edit,
                                Icons.calendar_month,
                                Icons.delete,
                              ].map(
                                (icon) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (icon == Icons.edit) {
                                          Navigator.pop(context);
                                          showAddHabitSheet(
                                            context,
                                            habit: widget.habit,
                                            index: widget.index,
                                          );
                                        } else if (icon == Icons.delete) {
                                          if (widget.onDelete != null) {
                                            widget.onDelete!();
                                            Navigator.pop(context);
                                          }
                                        } else if (icon ==
                                            Icons.calendar_month) {
                                          // TODO: Add calendar behavior
                                        }
                                      },
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: widget.habitCard.color
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Icon(
                                          icon,
                                          color: widget.habitCard.color,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                              Spacer(),
                              Expanded(
                                flex: 3,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isTodayCompleted
                                        ? widget.habitCard.color
                                        : widget.habitCard.color
                                            .withOpacity(0.7),
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    widget.habitCard.onToggle(today);
                                  },
                                  child: Text(
                                    isTodayCompleted ? "اكتملت" : "اكمل",
                                    style: getBodyStyle(fontSize: 14)
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final DateTime today = DateTime.now();
    final DateTime startOfYear = DateTime(today.year, 1, 1);
    final DateTime endDate = today.add(Duration(days: 10));
    final int totalDays = endDate.difference(startOfYear).inDays + 1;
    const int columns = 6;

    // Calculate available width minus padding
    final availableWidth =
        MediaQuery.of(context).size.width - 32; // 16 padding on each side

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: availableWidth, // Force full width
        child: Wrap(
          // alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          textDirection: TextDirection.ltr,
          spacing: 4,
          runSpacing: 4,
          children: List.generate(totalDays, (index) {
            final day = startOfYear.add(Duration(days: index));
            final isCompleted = widget.habitCard.completedDates.any((d) =>
                d.year == day.year && d.month == day.month && d.day == day.day);

            return Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: isCompleted
                    ? widget.habitCard.color
                    : widget.habitCard.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ),
    );
  }
}
