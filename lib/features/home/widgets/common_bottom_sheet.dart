import 'package:flutter/material.dart';
import 'package:pocket_pal/core/shared/widgets/common_date_picker.dart';
import 'package:pocket_pal/core/shared/widgets/custom_submit_button.dart';
import 'package:pocket_pal/core/shared/widgets/custom_text_field.dart';

class CommonBottomSheet extends StatefulWidget {
  final String title;
  final String bottomTitle;
  final void Function(String category, DateTime selectedDate)? onTap;
  final TextEditingController amountController;
  final TextEditingController descriptionController;

  const CommonBottomSheet({
    super.key,
    required this.title,
    required this.bottomTitle,
    this.onTap,
    required this.amountController,
    required this.descriptionController,
  });

  @override
  State<CommonBottomSheet> createState() => _CommonBottomSheetState();
}

class _CommonBottomSheetState extends State<CommonBottomSheet> {
  String? selectedCategory;
  DateTime selectedDate = DateTime.now();

  final categories = [
    'Food',
    'Rent',
    'Shopping',
    'Transport',
    'Gym',
    'Bills',
    'Entertainment',
    'Health',
    'Education',
    'Travel',
    'Coffee',
    'Personal',
    'Subscriptions',
    'Gifts',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          CustomTextField(
            controller: widget.amountController,
            keyboardType: TextInputType.number,
            prefix: '₹ ',
            hinttext: 'Enter amount',
          ),

          const SizedBox(height: 16),

          const Text(
            'Category',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((category) {
              final isSelected = selectedCategory == category;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.black : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          const Text('Select a date'),
          const SizedBox(height: 5),
          GestureDetector(
            onTap: () async {
              final date = await commonDatePicker(
                context: context,
                initialDate: selectedDate,
              );

              if (date != null) {
                setState(() {
                  selectedDate = date;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined),
                  const SizedBox(width: 12),
                  Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          CustomTextField(
            controller: widget.descriptionController,
            prefix: '',
            hinttext: 'Enter description',
          ),

          const SizedBox(height: 16),
          CustomSubmitButton(
            buttonText: widget.bottomTitle,
            onPressed: () {
              if (selectedCategory != null) {
                widget.onTap?.call(selectedCategory!, selectedDate);
              }
            },
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
