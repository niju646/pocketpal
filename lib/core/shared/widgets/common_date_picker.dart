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
            headerBackgroundColor: Colors.black,
            headerForegroundColor: Colors.white,
            todayForegroundColor: WidgetStateProperty.all(Colors.white),
            todayBorder: const BorderSide(color: Colors.black),
            dayForegroundColor: WidgetStateProperty.all(Colors.black),
            dayOverlayColor: WidgetStateProperty.all(Colors.white),
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
