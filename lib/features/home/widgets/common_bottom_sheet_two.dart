import 'package:flutter/material.dart';
import 'package:pocket_pal/core/shared/utlis/date_helper.dart';
import 'package:pocket_pal/core/shared/widgets/common_date_picker.dart';

class CommonTransactionBottomSheet extends StatefulWidget {
  final TextEditingController amountController;
  final TextEditingController descriptionController;

  final void Function(
    double amount,
    String category,
    DateTime date,
    String description,
    bool isIncome,
  )?
  onSubmit;

  const CommonTransactionBottomSheet({
    super.key,
    required this.amountController,
    required this.descriptionController,
    this.onSubmit,
  });

  @override
  State<CommonTransactionBottomSheet> createState() =>
      _CommonTransactionBottomSheetState();
}

class _CommonTransactionBottomSheetState
    extends State<CommonTransactionBottomSheet> {
  bool isIncome = true;

  String? selectedCategory;

  DateTime selectedDate = DateTime.now();

  final List<String> categories = [
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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Transaction',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
              ),

              const SizedBox(height: 20),

              // Income / Expense tabs
              Container(
                height: 48,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEAEA),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isIncome = true;
                            selectedCategory = null;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isIncome ? Colors.black : Colors.transparent,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Text(
                            'Income',
                            style: TextStyle(
                              color: isIncome ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isIncome = false;
                            selectedCategory = null;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: !isIncome
                                ? Colors.black
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Text(
                            'Expense',
                            style: TextStyle(
                              color: !isIncome ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Amount
              const Text(
                'Amount',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: widget.amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  prefixText: '₹ ',
                  hintText: '0.00',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Category
              const Text(
                'Category',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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

              const SizedBox(height: 18),

              // Date
              const Text(
                'Date',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

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
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        formatDate(selectedDate),
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Description
              const Text(
                'Description',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: widget.descriptionController,

                decoration: InputDecoration(hintText: 'Optional'),
              ),

              const SizedBox(height: 22),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    final amount = double.tryParse(
                      widget.amountController.text.trim(),
                    );

                    if (amount == null || amount <= 0) {
                      return;
                    }

                    if (selectedCategory == null) {
                      return;
                    }

                    widget.onSubmit?.call(
                      amount,
                      selectedCategory!,
                      selectedDate,
                      widget.descriptionController.text.trim(),
                      isIncome,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    isIncome ? 'Add Income' : 'Add Expense',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
