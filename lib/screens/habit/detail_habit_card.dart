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
    final cardH = size.height * 0.3;
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: widget.habitCard.color
                                          .withOpacity(.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        widget.habitCard.icon,
                                        size: 29,
                                      ),
                                    ),
                                  ),
                                  Gap(20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.habitCard.title,
                                          style: getBodyStyle(
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // SizedBox(height: 4),
                                        if (widget
                                            .habitCard.description!.isNotEmpty)
                                          Text(
                                            widget.habitCard.description ?? '',
                                            style: getSmallStyle(fontSize: 12),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(Icons.clear),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        _buildGrid(context),
                        Gap(20),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // GestureDetector(
                              //   onTap: () {},
                              //   child: SizedBox(
                              //     width: 55,
                              //     height: 50,
                              //     child: Icon(
                              //       Icons.share,
                              //     ),
                              //   ),
                              // ),

                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  showAddHabitSheet(
                                    context,
                                    habit: widget.habit,
                                    index: widget.index,
                                  );
                                },
                                child: SizedBox(
                                  width: 55,
                                  height: 50,
                                  child: Icon(
                                    Icons.edit,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: SizedBox(
                                  width: 55,
                                  height: 50,
                                  child: Icon(
                                    Icons.calendar_month,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (widget.onDelete != null) {
                                    widget.onDelete!();
                                    Navigator.pop(context);
                                  }
                                },
                                child: SizedBox(
                                  width: 55,
                                  height: 50,
                                  child: Icon(
                                    Icons.delete,
                                  ),
                                ),
                              ),
                              // IconButton(
                              //   onPressed: () {},
                              //   icon: Icon(Icons.calendar_month),
                              // ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: isTodayCompleted
                                          ? widget.habitCard.color
                                          : widget.habitCard.color
                                              .withOpacity(0.7),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onPressed: () {
                                    widget.habitCard.onToggle(today);
                                  },
                                  child: isTodayCompleted
                                      ? Text(
                                          "اكتملت",
                                        )
                                      : Text("اكمل"),
                                ),
                              ),
                            ],
                          ),
                        )
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
    final DateTime endDate = today.add(Duration(days: 3));
    final int totalDays = endDate.difference(startOfYear).inDays + 1;

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

            return GestureDetector(
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? widget.habitCard.color
                      : widget.habitCard.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
