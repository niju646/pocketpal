import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/core/shared/widgets/common_dialog.dart';
import 'package:pocket_pal/core/shared/widgets/custom_submit_button.dart';
import 'package:pocket_pal/features/savings/cubit/savings_cubit.dart';
import 'package:pocket_pal/features/savings/cubit/savings_state.dart';
import 'package:pocket_pal/features/savings/widgets/savings_bottom_sheet.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F8),
        elevation: 0,
        title: const Text(
          'Savings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CommonDialog(
                    title: 'Clear All Savings',
                    message: 'Are you sure you want to clear all savings?',
                    onConfirm: () {
                      context.read<SavingsCubit>().clearAllSavings();
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
            icon: const Icon(CupertinoIcons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Total savings
            BlocBuilder<SavingsCubit, SavingsState>(
              builder: (context, state) {
                if (state is SavingsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SavingsError) {
                  return Center(child: Text(state.message));
                }

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.savings_outlined,
                        color: Colors.white,
                        size: 36,
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        'Total Savings',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '₹ ${state.totalSavings.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Your accumulated savings',
                        style: TextStyle(
                          color: Colors.white.withAlpha(150),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const Spacer(),

            // Add savings button
            CustomSubmitButton(
              buttonText: 'Add Savings',
              onPressed: () {
                showSavingsBottomSheet(context);
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
