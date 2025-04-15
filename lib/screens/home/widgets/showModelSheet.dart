//  i have alot of bugs in this
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:habit_tracker/core/utils/colors.dart';
import 'package:habit_tracker/core/utils/textStyle.dart';
import 'package:habit_tracker/core/widgets/custom_button.dart';
import 'package:habit_tracker/screens/home/bloc/habit_bloc.dart';
import 'package:habit_tracker/screens/home/bloc/habit_event.dart';
import 'package:habit_tracker/screens/home/model/habit_model.dart';
import 'package:habit_tracker/screens/home/widgets/FullIconPickerScreen.dart';
import 'package:habit_tracker/screens/home/widgets/color_tile.dart';
import 'package:habit_tracker/screens/home/widgets/icon_tile.dart';

GlobalKey<FormState> _formState = GlobalKey();

List<IconData> icons = [
  Icons.bedtime,
  Icons.money,
  Icons.art_track,
  Icons.book_rounded,
  Icons.alarm,
  Icons.apple,
  Icons.bed,
  Icons.book,
  Icons.code,
  Icons.phone,
  Icons.sports_mma,
  Icons.attach_money_rounded,
];
List<Color> colors = [
  Color(0xFFE57373), // Red
  Color(0xFFFFB74D), // Orange
  Color(0xFFFFF176), // Yellow
  Color(0xFF81C784), // Green
  Color(0xFF4FC3F7), // Light Blue
  Color(0xFFBA68C8), // Purple
  Color(0xFFA1887F), // Brown
  Color(0xFF90A4AE), // Blue Grey
  Color(0xFF64B5F6), // Blue
  Color(0xFFAED581), // Lime Green
  Color(0xFFF06292), // Pink
  Color(0xFFB0BEC5), // Grey
  Color(0xFFFFFFFF), // White
  Color(0xFF000000), // Black
];
void showAddHabitSheet(BuildContext context) {
  final nameController = TextEditingController();
  final desController = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.cardColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      IconData? selectedIcon = icons.isNotEmpty ? icons[0] : null;
      Color? selectedColor = colors.isNotEmpty ? colors[0] : null;

      return StatefulBuilder(
        builder: (context, setModalState) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.8,
            minChildSize: 0.6,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 24,
                      bottom: 50, // space for button
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Form(
                        key: _formState,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'إضافة عادة جديدة',
                                  style: getBodyStyle(),
                                ),
                                IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                            Gap(20),

                            // Name
                            TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك ادخل اسم العادة';
                                } else {
                                  return null;
                                }
                              },
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "اسم العادة",
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                filled: true,
                                fillColor: AppColors.background,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                              ),
                            ),
                            Gap(20),

                            // Description
                            TextFormField(
                              controller: desController,
                              decoration: InputDecoration(
                                labelText: "وصف العادة (اختياري)",
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                filled: true,
                                fillColor: AppColors.background,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                              ),
                            ),
                            Gap(30),

                            Gap(25),
                            Text(
                              'ايقونه',
                              style: getBodyStyle(),
                            ),
                            Gap(15),

                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: icons.map((icons) {
                                return IconTile(
                                  icon: icons,
                                  isSelected: selectedIcon == icons,
                                  onTap: () {
                                    setModalState(() {
                                      selectedIcon = icons;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            Gap(12),

                            GestureDetector(
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => FullIconPickerScreen(),
                                  ),
                                );
                                if (result != null && result is IconData) {
                                  setModalState(
                                    () {
                                      selectedIcon = result;
                                      bool isContains = icons.contains(result);
                                      if (!isContains) {
                                        icons = [result, ...icons.sublist(1)];
                                      }
                                    },
                                  );
                                }
                              },
                              child: Container(
                                // margin: EdgeInsets.all(6),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: AppColors.background,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "المزيد",
                                    style: getSmallStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),

                            Gap(20),
                            Text(
                              'لون العاده',
                              style: getBodyStyle(),
                            ),
                            Gap(15),

                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: colors.map((color) {
                                return ColorTile(
                                  color: color,
                                  isSelected: selectedColor == color,
                                  onTap: () {
                                    setModalState(() {
                                      selectedColor = color;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            Gap(24),
                            // Button fixed at the bottom
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                    left: 16,
                    right: 16,
                    child: CustomButton(
                      text: "حفظ",
                      //!----------------!//
                      onPressed: () {
                        if (_formState.currentState!.validate()) {
                          final newHabit = HabitModel(
                            title: nameController.text,
                            description: desController.text.trim(),
                            icon: selectedIcon!,
                            color: selectedColor!,
                            createdAt: DateTime.now(),
                          );
                          context
                              .read<HabitBloc>()
                              .add(AddHabitEvent(newHabit));

                          Navigator.pop(context);
                        }
                      },
                      //!----------------!//
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
    },
  );
}
