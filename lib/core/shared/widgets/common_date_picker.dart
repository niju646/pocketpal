import 'package:flutter/material.dart';

Future<DateTime?> commonDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  final now = DateTime.now();

  return await showDatePicker(
    context: context,
    initialDate: initialDate ?? now,
    firstDate: firstDate ?? DateTime(2000),
    lastDate: lastDate ?? DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          scaffoldBackgroundColor: const Color(0xFFF7F7F8),

          colorScheme: const ColorScheme.light(
            primary: Colors.black,
            onPrimary: Colors.white,
            surface: Color(0xFFF7F7F8),
            onSurface: Colors.black,
          ),

          datePickerTheme: DatePickerThemeData(
            backgroundColor: const Color(0xFFF7F7F8),

            // Header
            headerBackgroundColor: Colors.black,
            headerForegroundColor: Colors.white,

            // Selected date
            dayBackgroundColor: WidgetStateProperty.resolveWith<Color?>((
              states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return Colors.black;
              }

              return Colors.transparent;
            }),

            dayForegroundColor: WidgetStateProperty.resolveWith<Color?>((
              states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }

              return Colors.black;
            }),

            // Today border
            todayBorder: const BorderSide(color: Colors.black),

            // Today text
            todayForegroundColor: WidgetStateProperty.resolveWith<Color?>((
              states,
            ) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }

              return Colors.black;
            }),

            // Press / hover effect
            dayOverlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.black.withAlpha(25);
              }

              if (states.contains(WidgetState.hovered)) {
                return Colors.black.withAlpha(15);
              }

              return Colors.transparent;
            }),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}
