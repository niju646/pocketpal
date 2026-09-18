part of 'transaction_cubit.dart';

@immutable
sealed class TransactionState {
  final double totalIncome;
  final double totalExpense;

  const TransactionState({this.totalIncome = 0, this.totalExpense = 0});

  double get balance => totalIncome - totalExpense;
}

final class TransactionInitial extends TransactionState {
  const TransactionInitial({super.totalIncome = 0, super.totalExpense = 0});
}

final class IncomeAdding extends TransactionState {
  const IncomeAdding({required super.totalIncome, required super.totalExpense});
}

final class IncomeAdded extends TransactionState {
  const IncomeAdded({required super.totalIncome, required super.totalExpense});
}

//income substracted
final class IncomeSubstracting extends TransactionState {
  const IncomeSubstracting({
    required super.totalIncome,
    required super.totalExpense,
  });
}

final class IncomeSubstracted extends TransactionState {
  const IncomeSubstracted({
    required super.totalIncome,
    required super.totalExpense,
  });
}

final class IncomeError extends TransactionState {
  final String message;

  const IncomeError(
    this.message, {
    super.totalIncome = 0,
    super.totalExpense = 0,
  });
}

//get income total count
final class TransactionInitialTwo extends TransactionState {
  const TransactionInitialTwo({super.totalIncome = 0, super.totalExpense = 0});
}

final class IncomeAddedTwo extends TransactionState {
  const IncomeAddedTwo({
    required super.totalIncome,
    required super.totalExpense,
  });
}

//expense
final class ExpenseAdding extends TransactionState {
  const ExpenseAdding({
    required super.totalIncome,
    required super.totalExpense,
  });
}

final class ExpenseAdded extends TransactionState {
  const ExpenseAdded({required super.totalIncome, required super.totalExpense});
}

final class ExpenseError extends TransactionState {
  final String message;

  const ExpenseError(
    this.message, {
    super.totalIncome = 0,
    super.totalExpense = 0,
  });
}

final class TransactionDeleteError extends TransactionState {
  final String message;

  const TransactionDeleteError(
    this.message, {
    super.totalIncome = 0,
    super.totalExpense = 0,
  });
}

//delete data
final class DataClearing extends TransactionState {
  const DataClearing({required super.totalIncome, required super.totalExpense});
}

final class DataCleared extends TransactionState {
  const DataCleared({required super.totalIncome, required super.totalExpense});
}

final class DataClearError extends TransactionState {
  final String message;

  const DataClearError(
    this.message, {
    super.totalIncome = 0,
    super.totalExpense = 0,
  });
}
