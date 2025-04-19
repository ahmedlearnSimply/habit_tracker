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
  const Color(0xFFE57373), // Red
  const Color(0xFFFFB74D), // Orange
  const Color(0xFFFFF176), // Yellow
  const Color(0xFF81C784), // Green
  const Color(0xFF4FC3F7), // Light Blue
  const Color(0xFFBA68C8), // Purple
  const Color(0xFFA1887F), // Brown
  const Color(0xFF90A4AE), // Blue Grey
  const Color(0xFF64B5F6), // Blue
  const Color(0xFFAED581), // Lime Green
  const Color(0xFFF06292), // Pink
  const Color(0xFFB0BEC5), // Grey
  const Color(0xFFFFFFFF), // White
  const Color(0xFF000000), // Black
];
void showAddHabitSheet(
  BuildContext context, {
  HabitModel? habit,
  int? index,
}) {
  final nameController = TextEditingController(text: habit?.title ?? '');
  final desController = TextEditingController(text: habit?.description ?? '');
  IconData? selectedIcon = habit != null
      ? IconData(habit.iconCodePoint, fontFamily: 'MaterialIcons')
      : (icons.isNotEmpty ? icons[0] : null);
  Color? selectedColor = habit != null
      ? Color(habit.colorValue)
      : (colors.isNotEmpty ? colors[0] : null);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.cardColor,
    shape: const RoundedRectangleBorder(
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
                    padding: const EdgeInsets.only(
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
                                  icon: const Icon(Icons.clear),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                            const Gap(20),

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
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                              ),
                            ),
                            const Gap(20),

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
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 14),
                              ),
                            ),
                            const Gap(30),

                            const Gap(25),
                            Text(
                              'ايقونه',
                              style: getBodyStyle(),
                            ),
                            const Gap(15),

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
                            const Gap(12),

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

                            const Gap(20),
                            Text(
                              'لون العاده',
                              style: getBodyStyle(),
                            ),
                            const Gap(15),

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
                            const Gap(24),
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
                            iconCodePoint: selectedIcon!.codePoint,
                            colorValue: selectedColor!.value,
                            createdAt: habit?.createdAt ??
                                DateTime.now().toIso8601String(),
                            completedDates: habit?.completedDates ?? [],
                          );

                          if (habit == null) {
                            context
                                .read<HabitBloc>()
                                .add(AddHabitEvent(newHabit));
                          } else {
                            context.read<HabitBloc>().add(
                                  UpdateHabitEvent(
                                      index: index!, updatedHabit: newHabit),
                                );
                          }

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
