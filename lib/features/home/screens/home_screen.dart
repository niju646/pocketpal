import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/core/shared/utlis/date_helper.dart';
import 'package:pocket_pal/core/shared/utlis/get_category_icons.dart';
import 'package:pocket_pal/features/home/cubit/transaction_cubit.dart';
import 'package:pocket_pal/features/home/screens/transaction_listing_screen.dart';
import 'package:pocket_pal/features/home/widgets/bottom_sheet.dart';
import 'package:pocket_pal/features/home/widgets/build_balance_card.dart';
import 'package:pocket_pal/features/home/widgets/common_day_widget.dart';
import 'package:pocket_pal/features/home/widgets/common_empty_screen.dart';
import 'package:pocket_pal/features/home/widgets/common_transaction_tile.dart';
import 'package:pocket_pal/features/profile/screens/edit_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TransactionCubit>().getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F7F8),
        elevation: 0,
        title: commonDayWidget(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              );
            },
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBalanceCard(),

            const SizedBox(height: 16),

            _buildActionButtons(context),

            const SizedBox(height: 24),

            BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'THIS MONTH',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                        letterSpacing: 0.8,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(10),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'THIS MONTH',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                              letterSpacing: 1,
                            ),
                          ),

                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(
                                child: _summaryItem(
                                  title: 'Income',
                                  amount: state.totalIncome,
                                  icon: Icons.arrow_downward_rounded,
                                ),
                              ),

                              Container(
                                height: 45,
                                width: 1,
                                color: Colors.grey.shade200,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _summaryItem(
                                  title: 'Expenses',
                                  amount: state.totalExpense,
                                  icon: Icons.arrow_upward_rounded,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 18),

                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(8),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.account_balance_wallet_outlined,
                                    size: 20,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                const Expanded(
                                  child: Text(
                                    'Balance',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                Text(
                                  '₹${state.balance.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TransactionListingScreen(),
                      ),
                    );
                  },
                  child: const Text('See all'),
                ),
              ],
            ),

            const SizedBox(height: 8),

            BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                final transactions = context
                    .read<TransactionCubit>()
                    .transactions;

                if (transactions.isEmpty) {
                  return const Center(
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
                  itemCount: transactions.length > 4 ? 4 : transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];

                    return commonTransactionTile(
                      icon: getCategoryIcon(transaction.category),
                      title: transaction.title,
                      subtitle:
                          '${transaction.description ?? transaction.category} • ${formatDate(DateTime.parse(transaction.date))}',
                      amount:
                          '${transaction.isIncome ? '+' : '-'}₹${transaction.amount.toStringAsFixed(0)}',
                      isIncome: transaction.isIncome,
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.add,
            title: 'Add Income',
            onTap: () {
              showModalBottomSheet(
                backgroundColor: const Color(0xFFF7F7F8),
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: 1,
                    child: CommonBottomSheet(
                      amountController: amountController,
                      descriptionController: descriptionController,
                      title: 'Add Income',
                      bottomTitle: 'Add Income',
                      onTap: (category, selectedDate) {
                        final text = amountController.text.trim();
                        if (text.isNotEmpty) {
                          final amount = double.tryParse(text) ?? 0;
                          context.read<TransactionCubit>().addIncome(
                            amount: amount,
                            category: category,
                            date: selectedDate,
                            description: descriptionController.text.trim(),
                          );
                          amountController.clear();
                          descriptionController.clear();
                        }
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildActionButton(
            icon: Icons.remove,
            title: 'Add Expense',
            onTap: () {
              showModalBottomSheet(
                backgroundColor: const Color(0xFFF7F7F8),
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return FractionallySizedBox(
                    heightFactor: 1,
                    child: CommonBottomSheet(
                      amountController: amountController,
                      descriptionController: descriptionController,
                      title: 'Add Expense',
                      bottomTitle: 'Add Expense',

                      onTap: (category, selectedDate) {
                        final text = amountController.text.trim();
                        if (text.isNotEmpty) {
                          final amount = double.tryParse(text) ?? 0;
                          context.read<TransactionCubit>().addExpense(
                            amount: amount,
                            category: category,
                            date: selectedDate,
                            description: descriptionController.text.trim(),
                          );
                          amountController.clear();
                        }
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.black),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem({
    required String title,
    required double amount,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 3),
              Text(
                '₹${amount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
