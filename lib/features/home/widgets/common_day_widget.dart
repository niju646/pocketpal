import 'package:flutter/material.dart';

Column commonDayWidget() {
  final now = DateTime.now();
  final hour = now.hour;

  String greeting;

  if (hour < 12) {
    greeting = 'Good morning 👋';
  } else if (hour < 17) {
    greeting = 'Good afternoon 👋';
  } else {
    greeting = 'Good evening 👋';
  }

  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final monthYear = '${months[now.month - 1]} ${now.year}';

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        greeting,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 4),
      Text(monthYear, style: const TextStyle(fontSize: 13, color: Colors.grey)),
    ],
  );
}
