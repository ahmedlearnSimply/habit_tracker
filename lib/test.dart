// void showAddHabitSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: AppColors.cardColor,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setModalState) {
//           TextEditingController nameController = TextEditingController();
//           TextEditingController desController = TextEditingController();
//           IconData? selectedIcon;
//           Color? selectedColor;

//           return DraggableScrollableSheet(
//             expand: false,
//             initialChildSize: 0.8,
//             minChildSize: 0.6,
//             maxChildSize: 0.95,
//             builder: (context, scrollController) {
//               return Stack(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(
//                       left: 16,
//                       right: 16,
//                       top: 24,
//                       bottom: 50, // Space for button
//                     ),
//                     child: SingleChildScrollView(
//                       controller: scrollController,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'إضافة عادة جديدة',
//                                 style: getBodyStyle(),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.clear),
//                                 onPressed: () => Navigator.pop(context),
//                               ),
//                             ],
//                           ),
//                           const Gap(20),

//                           // Habit Name Input
//                           TextFormField(
//                             controller: nameController,
//                             decoration: InputDecoration(
//                               labelText: "اسم العادة",
//                               floatingLabelAlignment:
//                                   FloatingLabelAlignment.center,
//                               filled: true,
//                               fillColor: AppColors.background,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide.none,
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 14),
//                             ),
//                           ),
//                           const Gap(20),

//                           // Habit Description Input
//                           TextFormField(
//                             controller: desController,
//                             decoration: InputDecoration(
//                               labelText: "وصف العادة (اختياري)",
//                               floatingLabelAlignment:
//                                   FloatingLabelAlignment.center,
//                               filled: true,
//                               fillColor: AppColors.background,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide.none,
//                               ),
//                               contentPadding: const EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 14),
//                             ),
//                           ),
//                           const Gap(30),

//                           const Gap(25),
//                           Text(
//                             'ايقونه',
//                             style: getBodyStyle(),
//                           ),
//                           const Gap(15),

//                           // Icon Selection
//                           Wrap(
//                             spacing: 12,
//                             runSpacing: 12,
//                             children: icons.map((icon) {
//                               return IconTile(
//                                 icon: icon,
//                                 isSelected: selectedIcon == icon,
//                                 onTap: () {
//                                   setModalState(() {
//                                     selectedIcon = icon;
//                                   });
//                                 },
//                               );
//                             }).toList(),
//                           ),
//                           const Gap(12),

//                           // "More" Button
//                           GestureDetector(
//                             onTap: () async {
//                               final result = await Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) => FullIconPickerScreen(),
//                                 ),
//                               );
//                               if (result != null && result is IconData) {
//                                 setModalState(() => selectedIcon = result);
//                               }
//                             },
//                             child: Container(
//                               width: 50,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 color: AppColors.background,
//                                 borderRadius: BorderRadius.circular(12),
//                                 border: Border.all(
//                                   color: AppColors.background,
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   "المزيد",
//                                   style: getSmallStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),

//                           const Gap(20),
//                           Text(
//                             'لون العاده',
//                             style: getBodyStyle(),
//                           ),
//                           const Gap(15),

//                           // Color Selection
//                           Wrap(
//                             spacing: 12,
//                             runSpacing: 12,
//                             children: colors.map((color) {
//                               return ColorTile(
//                                 color: color,
//                                 isSelected: selectedColor == color,
//                                 onTap: () {
//                                   setModalState(() => selectedColor = color);
//                                 },
//                               );
//                             }).toList(),
//                           ),
//                           const Gap(24),
//                         ],
//                       ),
//                     ),
//                   ),

//                   // Save Button (always visible)
//                   Positioned(
//                     bottom: 16,
//                     left: 16,
//                     right: 16,
//                     child: CustomButton(
//                       text: "حفظ",
//                       onPressed: () {
//                         // Validation for input fields
//                         if (nameController.text.isEmpty) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text('يجب إدخال اسم العادة'),
//                             ),
//                           );
//                           return;
//                         }

//                         if (selectedIcon == null || selectedColor == null) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text('يجب اختيار الأيقونة واللون'),
//                             ),
//                           );
//                           return;
//                         }

//                         // Save the habit
//                         final newHabit = HabitModel(
//                           title: nameController.text,
//                           description: desController.text.trim(),
//                           icon: selectedIcon!,
//                           color: selectedColor!,
//                           createdAt: DateTime.now(),
//                         );

//                         context.read<HabitBloc>().add(AddHabitEvent(newHabit));
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       );
//     },
//   );
// }
