import 'package:flutter/material.dart';
import 'package:pocket_pal/core/shared/widgets/common_date_picker.dart';
import 'package:pocket_pal/core/shared/widgets/custom_submit_button.dart';

class ReminderAddCard extends StatefulWidget {
  final TextEditingController title;
  final TextEditingController amount;
  final TextEditingController date;
  final VoidCallback? onPressed;
  const ReminderAddCard({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    this.onPressed,
  });

  @override
  State<ReminderAddCard> createState() => _ReminderAddCardState();
}

class _ReminderAddCardState extends State<ReminderAddCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.swap_horiz,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'New Recurring Bill',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'MONTHLY RULE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4F46E5),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Bill Title Input
          _buildLabel('BILL TITLE'),
          const SizedBox(height: 6),
          TextField(
            controller: widget.title,
            decoration: _inputDecoration(
              hintText: 'e.g. Broadband, Rent, Netflix',
              prefixIcon: const Icon(
                Icons.edit_outlined,
                size: 18,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Amount & Due Day Fields
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('AMOUNT (₹)'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: widget.amount,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(hintText: '₹ 1,200'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('DUE DAY'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: widget.date,
                      readOnly: true,
                      onTap: () async {
                        final selectedDate = await commonDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );

                        if (selectedDate != null) {
                          widget.date.text =
                              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                        }
                      },
                      decoration: _inputDecoration(
                        hintText: '18th each month',
                        prefixIcon: const Icon(
                          Icons.calendar_today_outlined,
                          size: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    // TextField(
                    //   controller: dateController,
                    //   readOnly: true,
                    //   decoration: _inputDecoration(
                    //     hintText: '18th each month',
                    //     prefixIcon: const Icon(
                    //       Icons.calendar_today_outlined,
                    //       size: 18,
                    //       color: Colors.grey,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Info Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 18, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Repeats automatically every month on selected day until deleted.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Submit Button
          CustomSubmitButton(
            buttonText: 'Add Recuring Bill',
            onPressed: widget.onPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: Color(0xFF64748B),
        letterSpacing: 0.5,
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hintText,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: const Color(0xFFF1F5F9),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
      ),
    );
  }
}
