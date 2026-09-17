import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/core/shared/hive/data/transaction_local_storage.dart';
import 'package:pocket_pal/features/home/data/transaction_model.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(const TransactionInitial()) {
    loadTransactions();
  }
  double totalIncome = 0;
  double totalExpense = 0;

  List<TransactionModel> transactions = [];

  final TransactionLocalStorage localStorage = TransactionLocalStorage();

  void loadTransactions() {
    transactions = localStorage.getTransactions();

    totalIncome = 0;
    totalExpense = 0;

    for (final transaction in transactions) {
      if (transaction.isIncome) {
        totalIncome += transaction.amount;
      } else {
        totalExpense += transaction.amount;
      }
    }

    emit(
      TransactionInitial(totalIncome: totalIncome, totalExpense: totalExpense),
    );
  }

  //add income
  Future<void> addIncome({
    required double amount,
    required String category,
    required DateTime date,
    String? description,
  }) async {
    emit(IncomeAdding(totalIncome: totalIncome, totalExpense: totalExpense));

    try {
      final transaction = TransactionModel(
        title: category,
        category: category,
        amount: amount,
        date: date.toString(),
        isIncome: true,
        description: description,
      );

      await localStorage.addTransaction(transaction);

      totalIncome = totalIncome + amount;

      transactions.insert(0, transaction);

      log('total income after adding: $totalIncome');
      log('transactions count: ${transactions.length}');

      emit(IncomeAdded(totalIncome: totalIncome, totalExpense: totalExpense));
    } catch (e) {
      emit(
        IncomeError(
          e.toString(),
          totalIncome: totalIncome,
          totalExpense: totalExpense,
        ),
      );
    }
  }

  //substracting
  void substractIncome({
    required double amount,
    required String category,
    required DateTime date,
    String? description,
  }) {
    emit(
      IncomeSubstracting(totalIncome: totalIncome, totalExpense: totalExpense),
    );

    try {
      totalIncome = totalIncome - amount;

      emit(
        IncomeSubstracted(totalIncome: totalIncome, totalExpense: totalExpense),
      );
    } catch (e) {
      emit(
        IncomeError(
          e.toString(),
          totalIncome: totalIncome,
          totalExpense: totalExpense,
        ),
      );
    }
  }

  //get total income only
  void addIncomeTwo(double amount) {
    totalIncome = totalIncome + amount;
    log('totalIncome: $totalIncome');
    emit(IncomeAddedTwo(totalIncome: totalIncome, totalExpense: totalExpense));
  }

  double getIncome() {
    log('get income: $totalIncome');
    return totalIncome;
  }

  //expense
  Future<void> addExpense({
    required double amount,
    required String category,
    required DateTime date,
    String? description,
  }) async {
    emit(ExpenseAdding(totalIncome: totalIncome, totalExpense: totalExpense));

    try {
      final transaction = TransactionModel(
        title: category,
        category: category,
        amount: amount,
        date: date.toString(),
        isIncome: false,
        description: description,
      );

      await localStorage.addTransaction(transaction);

      totalExpense = totalExpense + amount;

      transactions.insert(0, transaction);

      log('total expense after adding: $totalExpense');
      log('transactions count: ${transactions.length}');

      emit(ExpenseAdded(totalIncome: totalIncome, totalExpense: totalExpense));
    } catch (e) {
      emit(
        ExpenseError(
          e.toString(),
          totalIncome: totalIncome,
          totalExpense: totalExpense,
        ),
      );
    }
  }

  double getExpense() {
    log('get expense: $totalExpense');
    return totalExpense;
  }

  double getBalance() {
    log('get balance: ${totalIncome - totalExpense}');
    return totalIncome - totalExpense;
  }

  List<TransactionModel> getTransactions() {
    return transactions;
  }

  //delete data
  Future<void> clearAllData() async {
    emit(DataClearing(totalIncome: totalIncome, totalExpense: totalExpense));

    try {
      await localStorage.clearAllTransactions();

      transactions.clear();

      totalIncome = 0;
      totalExpense = 0;

      emit(const DataCleared(totalIncome: 0, totalExpense: 0));
    } catch (e) {
      emit(
        DataClearError(
          e.toString(),
          totalIncome: totalIncome,
          totalExpense: totalExpense,
        ),
      );
    }
  }

  //current monthly expense
  double getCurrentMonthExpense() {
    final now = DateTime.now();

    double monthlyExpense = 0;

    for (final transaction in transactions) {
      if (!transaction.isIncome) {
        final transactionDate = DateTime.parse(transaction.date);

        if (transactionDate.year == now.year &&
            transactionDate.month == now.month) {
          monthlyExpense += transaction.amount;
        }
      }
    }

    log('current month expense: $monthlyExpense');

    return monthlyExpense;
  }

  double getPreviousMonthExpense() {
    final now = DateTime.now();

    DateTime previousMonth;

    if (now.month == 1) {
      previousMonth = DateTime(now.year - 1, 12);
    } else {
      previousMonth = DateTime(now.year, now.month - 1);
    }

    double previousExpense = 0;

    for (final transaction in transactions) {
      if (!transaction.isIncome) {
        final transactionDate = DateTime.parse(transaction.date);

        if (transactionDate.year == previousMonth.year &&
            transactionDate.month == previousMonth.month) {
          previousExpense += transaction.amount;
        }
      }
    }

    return previousExpense;
  }

  double getMonthlyExpenseChangePercentage() {
    final currentExpense = getCurrentMonthExpense();
    final previousExpense = getPreviousMonthExpense();

    if (previousExpense == 0) {
      return 0;
    }

    return ((currentExpense - previousExpense) / previousExpense) * 100;
  }

  Map<String, double> getCurrentMonthExpensesByCategory() {
    final now = DateTime.now();

    Map<String, double> categoryExpenses = {};

    for (final transaction in transactions) {
      if (!transaction.isIncome) {
        final transactionDate = DateTime.parse(transaction.date);

        if (transactionDate.year == now.year &&
            transactionDate.month == now.month) {
          if (categoryExpenses.containsKey(transaction.category)) {
            categoryExpenses[transaction.category] =
                categoryExpenses[transaction.category]! + transaction.amount;
          } else {
            categoryExpenses[transaction.category] = transaction.amount;
          }
        }
      }
    }

    return categoryExpenses;
  }

  Map<String, int> getCurrentMonthExpenseCountByCategory() {
    final now = DateTime.now();

    Map<String, int> categoryCounts = {};

    for (final transaction in transactions) {
      if (!transaction.isIncome) {
        final transactionDate = DateTime.parse(transaction.date);

        if (transactionDate.year == now.year &&
            transactionDate.month == now.month) {
          if (categoryCounts.containsKey(transaction.category)) {
            categoryCounts[transaction.category] =
                categoryCounts[transaction.category]! + 1;
          } else {
            categoryCounts[transaction.category] = 1;
          }
        }
      }
    }

    return categoryCounts;
  }
}
