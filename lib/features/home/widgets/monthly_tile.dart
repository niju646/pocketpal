import 'package:flutter/material.dart';

Widget buildSummaryRow({
  required String title,
  required String amount,
  bool isBold = false,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
        // Divider(height: 24),
      ],
    ),
  );
}
