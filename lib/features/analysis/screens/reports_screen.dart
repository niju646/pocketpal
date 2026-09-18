import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/core/shared/utlis/get_category_color.dart';
import 'package:pocket_pal/core/shared/utlis/get_category_icons.dart';
import 'package:pocket_pal/core/shared/utlis/get_month_helper.dart';
import 'package:pocket_pal/features/analysis/widgets/section_label.dart';
import 'package:pocket_pal/features/home/cubit/transaction_cubit.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FF),
        elevation: 0,
        centerTitle: false,
        title: const Text("Reports"),
      ),
      body: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),

                const SizedBox(height: 20),

                _buildMainMetrics(),

                const SizedBox(height: 16),

                _buildCategoryDistribution(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Expense Analytics',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF000F1D),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Comprehensive audit of cash outflow & velocity',
          style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade600),
        ),
      ],
    );
  }

  Widget _buildMainMetrics() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 7, child: _buildTotalSpendCard(context)),
              const SizedBox(width: 16),
              Expanded(flex: 5, child: _buildBudgetCard(context)),
            ],
          );
        }

        return Column(
          children: [
            _buildTotalSpendCard(context),
            const SizedBox(height: 16),
            _buildBudgetCard(context),
          ],
        );
      },
    );
  }

  Widget _buildTotalSpendCard(BuildContext context) {
    final transactionCubit = context.read<TransactionCubit>();

    final monthlyExpense = transactionCubit.getCurrentMonthExpense();

    final expenseChange = transactionCubit.getMonthlyExpenseChangePercentage();

    final previousMonthName = DateTime(
      DateTime.now().year,
      DateTime.now().month - 1,
    );

    final monthName = getMonthName(previousMonthName.month);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionLabel('TOTAL MONTHLY SPEND'),
                    const SizedBox(height: 4),
                    Text(
                      '₹ ${monthlyExpense.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF000F1D),
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              ),
              _percentageBadge(
                icon: expenseChange < 0
                    ? Icons.trending_down
                    : Icons.trending_up,
                text:
                    '${expenseChange > 0 ? '+' : ''}${expenseChange.toStringAsFixed(1)}% vs $monthName',
                color: expenseChange <= 0
                    ? const Color(0xFF006C4A)
                    : const Color(0xFFBA1A1A),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Divider(color: Colors.grey.shade200, height: 1),
          const SizedBox(height: 16),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.savings_outlined,
                    size: 18,
                    color: Colors.blueGrey.shade400,
                  ),
                  const SizedBox(width: 6),
                  Text('Saved ', style: _smallTextStyle()),
                  const Text(
                    '₹2,500',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                  Text(' compared to last month', style: _smallTextStyle()),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.speed_outlined,
                    size: 18,
                    color: Colors.blueGrey.shade400,
                  ),
                  const SizedBox(width: 6),
                  Text('Avg. burn: ', style: _smallTextStyle()),
                  const Text(
                    '₹516/day',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0B1C30),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetCard(BuildContext context) {
    final utilization = context
        .read<TransactionCubit>()
        .getUtilizationPercentage();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionLabel('BUDGET VELOCITY'),
                    const SizedBox(height: 4),
                    Text(
                      '${utilization.toStringAsFixed(1)}% Utilized',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000F1D),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF85F8C4),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'On Track',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF005137),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: 0.775,
              minHeight: 12,
              backgroundColor: const Color(0xFFE5EEFF),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF000F1D)),
            ),
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _budgetText('Spent:', '₹15,500'),
              _budgetText('Limit:', '₹20,000'),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF006C4A),
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Safe to spend',
                    style: TextStyle(fontSize: 12, color: Color(0xFF0B1C30)),
                  ),
                ),
                const Text(
                  '₹4,500',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF006C4A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDistribution(BuildContext context) {
    final transactionCubit = context.read<TransactionCubit>();

    final categoryExpenses = transactionCubit
        .getCurrentMonthExpensesByCategory();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Category Distribution',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000F1D),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Breakdown across ${categoryExpenses.length} active expense buckets',
          style: _smallTextStyle(),
        ),

        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 650) {
              return Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: _buildDonutChart(context, categoryExpenses),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 7,
                    child: _buildCategoryList(context, categoryExpenses),
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildDonutChart(context, categoryExpenses),
                const SizedBox(height: 24),
                _buildCategoryList(context, categoryExpenses),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildDonutChart(
    BuildContext context,
    Map<String, double> categoryExpenses,
  ) {
    final totalExpense = categoryExpenses.values.fold(
      0.0,
      (sum, amount) => sum + amount,
    );

    final categoryEntries = categoryExpenses.entries.toList();

    categoryEntries.sort((a, b) => b.value.compareTo(a.value));

    final itemCount = categoryEntries.length;

    return Column(
      children: [
        SizedBox(
          width: 230,
          height: 230,
          child: CustomPaint(
            painter: ExpenseDonutPainter(categoryExpenses: categoryExpenses),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'SPENT',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: Color(0xFF43474C),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    '₹${totalExpense.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF000F1D),
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    '$itemCount ${itemCount == 1 ? 'item' : 'categories'}',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF73777D),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        _buildDonutLegend(categoryEntries),
      ],
    );
  }

  Widget _buildDonutLegend(List<MapEntry<String, double>> categories) {
    if (categories.isEmpty) {
      return const SizedBox();
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        if (categories.isNotEmpty)
          _legendItem(
            getCategoryColor(categories[0].key),
            'Top: ${categories[0].key}',
          ),

        if (categories.length > 1)
          _legendItem(
            getCategoryColor(categories[1].key),
            '2nd: ${categories[1].key}',
          ),
      ],
    );
  }

  Widget _buildCategoryList(
    BuildContext context,
    Map<String, double> categoryExpenses,
  ) {
    if (categoryExpenses.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'No expenses this month',
            style: TextStyle(fontSize: 14, color: Color(0xFF73777D)),
          ),
        ),
      );
    }

    final transactionCubit = context.read<TransactionCubit>();

    final categoryCounts = transactionCubit
        .getCurrentMonthExpenseCountByCategory();

    final totalExpense = categoryExpenses.values.fold(
      0.0,
      (sum, amount) => sum + amount,
    );

    final sortedCategories = categoryExpenses.entries.toList();

    sortedCategories.sort((a, b) => b.value.compareTo(a.value));

    return Column(
      children: sortedCategories.map((entry) {
        final category = entry.key;
        final amount = entry.value;

        final count = categoryCounts[category] ?? 0;

        final percentage = totalExpense == 0
            ? 0
            : (amount / totalExpense) * 100;

        final average = count == 0 ? 0 : amount / count;

        return _categoryItem(
          icon: getCategoryIcon(category),
          iconColor: getCategoryColor(category),
          title: category,
          percentage: '${percentage.toStringAsFixed(1)}%',
          subtitle: '$count transactions • Avg ₹${average.toStringAsFixed(0)}',
          amount: '₹${amount.toStringAsFixed(0)}',
        );
      }).toList(),
    );
  }

  Widget _categoryItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String percentage,
    required String subtitle,
    required String amount,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000F1D),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5EEFF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          percentage,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF43474C),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    style: _smallTextStyle(),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Text(
              amount,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF000F1D),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _percentageBadge({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(40),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _budgetText(String title, String value) {
    return Row(
      children: [
        Text(title, style: _smallTextStyle()),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0B1C30),
          ),
        ),
      ],
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(text, style: _smallTextStyle()),
      ],
    );
  }

  TextStyle _smallTextStyle() {
    return const TextStyle(fontSize: 12, color: Color(0xFF73777D));
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0x2273777D)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0D000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    );
  }
}

class ExpenseDonutPainter extends CustomPainter {
  final Map<String, double> categoryExpenses;

  ExpenseDonutPainter({required this.categoryExpenses});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final radius = size.width * 0.35;

    final backgroundPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.butt
      ..color = const Color(0xFFEFF4FF);

    canvas.drawCircle(center, radius, backgroundPaint);

    if (categoryExpenses.isEmpty) {
      return;
    }

    final totalExpense = categoryExpenses.values.fold(
      0.0,
      (sum, amount) => sum + amount,
    );

    if (totalExpense == 0) {
      return;
    }

    final categories = categoryExpenses.entries.toList();

    categories.sort((a, b) => b.value.compareTo(a.value));

    double startAngle = -math.pi / 2;

    for (final category in categories) {
      final percentage = category.value / totalExpense;

      final sweepAngle = 2 * math.pi * percentage;

      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18
        ..strokeCap = StrokeCap.butt
        ..color = _getCategoryColor(category.key);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
      case 'food & dining':
        return const Color(0xFF0D2538);

      case 'shopping':
        return const Color(0xFF006C4A);

      case 'bills':
      case 'bills & utilities':
        return const Color(0xFF4B6176);

      case 'transport':
      case 'transportation':
        return const Color(0xFF82F5C1);

      case 'entertainment':
        return const Color(0xFFD3E4FE);

      case 'health':
        return const Color(0xFF8B5CF6);

      case 'education':
        return const Color(0xFFF59E0B);

      default:
        return const Color(0xFF73777D);
    }
  }

  @override
  bool shouldRepaint(covariant ExpenseDonutPainter oldDelegate) {
    return oldDelegate.categoryExpenses != categoryExpenses;
  }
}
