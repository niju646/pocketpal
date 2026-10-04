import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/core/shared/widgets/custom_submit_button.dart';
import 'package:pocket_pal/core/shared/widgets/custom_text_field.dart';
import 'package:pocket_pal/core/theme/app_colors.dart';
import 'package:pocket_pal/features/savings/cubit/savings_cubit.dart';

class SavingsBottomSheet extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final VoidCallback onAdd;

  const SavingsBottomSheet({
    super.key,
    required this.titleController,
    required this.amountController,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Savings',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          CustomTextField(
            controller: titleController,
            prefix: '',
            hinttext: 'Savings name',
          ),

          const SizedBox(height: 16),

          CustomTextField(
            controller: amountController,
            prefix: '₹',
            hinttext: 'Enter amount',
          ),

          const SizedBox(height: 20),

          CustomSubmitButton(buttonText: 'Add Savings', onPressed: onAdd),
        ],
      ),
    );
  }
}

void showSavingsBottomSheet(BuildContext context) {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  showModalBottomSheet(
    backgroundColor: AppColors.backgroundColor,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return SavingsBottomSheet(
        titleController: titleController,
        amountController: amountController,
        onAdd: () {
          final amount = double.tryParse(amountController.text.trim());

          if (amount == null || amount <= 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter a valid amount')),
            );
            return;
          }
          context.read<SavingsCubit>().addSavings(
            amount: double.parse(amountController.text),
            date: DateTime.now(),
            note: titleController.text,
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Savings added successfully')));
          Navigator.pop(context);
        },
      );
    },
  );
}
