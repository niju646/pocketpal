import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/features/home/cubit/transaction_cubit.dart';

Widget buildBalanceCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CURRENT BALANCE',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 10),

        BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            return Text(
              '₹${state.balance.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            );
          },
        ),

        const SizedBox(height: 20),

        BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  child: _buildBalanceItem(
                    title: 'Income',
                    amount: '₹${state.totalIncome.toStringAsFixed(0)}',
                    icon: Icons.arrow_upward,
                  ),
                ),
                Expanded(
                  child: _buildBalanceItem(
                    title: 'Expenses',
                    amount: '₹${state.totalExpense.toStringAsFixed(0)}',
                    icon: Icons.arrow_downward,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget _buildBalanceItem({
  required String title,
  required String amount,
  required IconData icon,
}) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(25),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 14, color: Colors.white),
      ),

      const SizedBox(width: 8),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 2),
          Text(
            amount,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ],
  );
}
