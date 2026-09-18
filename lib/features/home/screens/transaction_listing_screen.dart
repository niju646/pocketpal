import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/core/shared/utlis/date_helper.dart';
import 'package:pocket_pal/core/shared/utlis/get_category_icons.dart';
import 'package:pocket_pal/core/shared/widgets/common_dialog.dart';
import 'package:pocket_pal/features/home/cubit/transaction_cubit.dart';
import 'package:pocket_pal/features/home/widgets/common_bottom_sheet_two.dart';
import 'package:pocket_pal/features/home/widgets/common_empty_screen.dart';
import 'package:pocket_pal/features/home/widgets/common_transaction_tile.dart';

class TransactionListingScreen extends StatefulWidget {
  const TransactionListingScreen({super.key});

  @override
  State<TransactionListingScreen> createState() =>
      _TransactionListingScreenState();
}

class _TransactionListingScreenState extends State<TransactionListingScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      appBar: AppBar(
        title: const Text('Your Transaction'),
        backgroundColor: const Color(0xFFF7F7F8),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              BlocBuilder<TransactionCubit, TransactionState>(
                builder: (context, state) {
                  final transactions = context
                      .read<TransactionCubit>()
                      .transactions;
                  if (transactions.isEmpty) {
                    return Center(
                      child: CommonEmptyScreen(
                        icon: Icons.receipt,
                        title: 'No transactions yet',
                        message: 'Create your first transaction to get started',
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];

                      return GestureDetector(
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CommonDialog(
                                title: 'Delete?',
                                message: 'Are you sure you want to delete?',
                                confirmText: 'Delete',
                                onConfirm: () {
                                  context
                                      .read<TransactionCubit>()
                                      .deleteTransaction(transaction);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Deleted ${transaction.title}',
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: commonTransactionTile(
                          icon: getCategoryIcon(transaction.category),
                          title: transaction.title,
                          subtitle:
                              '${transaction.description ?? transaction.category} • ${formatDate(DateTime.parse(transaction.date))} ',
                          amount:
                              '${transaction.isIncome ? '+' : '-'}₹${transaction.amount.toStringAsFixed(0)}',
                          isIncome: transaction.isIncome,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          amountController.clear();
          descriptionController.clear();

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: const Color(0xFFF7F7F8),
            builder: (context) {
              return CommonTransactionBottomSheet(
                amountController: amountController,
                descriptionController: descriptionController,
                onSubmit: (amount, category, date, description, isIncome) {
                  if (isIncome) {
                    context.read<TransactionCubit>().addIncome(
                      amount: amount,
                      category: category,
                      date: date,
                      description: description,
                    );
                  } else {
                    context.read<TransactionCubit>().addExpense(
                      amount: amount,
                      category: category,
                      date: date,
                      description: description,
                    );
                  }

                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }
}
