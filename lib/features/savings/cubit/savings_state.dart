import 'package:pocket_pal/features/savings/data/models/savings_model.dart';

abstract class SavingsState {
  final double totalSavings;
  final List<SavingsModel> savings;

  const SavingsState({this.totalSavings = 0, this.savings = const []});
}

class SavingsInitial extends SavingsState {
  const SavingsInitial({super.totalSavings, super.savings});
}

class SavingsLoading extends SavingsState {
  const SavingsLoading({super.totalSavings, super.savings});
}

class SavingsAdded extends SavingsState {
  const SavingsAdded({required super.totalSavings, required super.savings});
}

class SavingsLoaded extends SavingsState {
  const SavingsLoaded({required super.totalSavings, required super.savings});
}

class SavingsError extends SavingsState {
  final String message;

  const SavingsError({
    required this.message,
    super.totalSavings,
    super.savings,
  });
}
