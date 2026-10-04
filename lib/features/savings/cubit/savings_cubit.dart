import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/features/savings/data/models/savings_model.dart';
import 'package:pocket_pal/features/savings/data/savings_local_storage.dart';
import 'savings_state.dart';

class SavingsCubit extends Cubit<SavingsState> {
  SavingsCubit() : super(const SavingsInitial()) {
    loadSavings();
  }

  final SavingsLocalStorage localStorage = SavingsLocalStorage();

  List<SavingsModel> savings = [];

  // Load savings from Hive
  void loadSavings() {
    try {
      emit(SavingsLoading(totalSavings: state.totalSavings, savings: savings));

      savings = localStorage.getSavings();

      double total = 0;

      for (final saving in savings) {
        total += saving.amount;
      }

      emit(SavingsLoaded(totalSavings: total, savings: savings));
    } catch (e) {
      emit(
        SavingsError(
          message: e.toString(),
          totalSavings: state.totalSavings,
          savings: savings,
        ),
      );
    }
  }

  // Add new saving
  Future<void> addSavings({
    required double amount,
    required DateTime date,
    String note = '',
  }) async {
    try {
      final saving = SavingsModel(amount: amount, date: date, note: note);

      await localStorage.addSavings(saving);

      savings.add(saving);

      final newTotal = state.totalSavings + amount;

      emit(SavingsAdded(totalSavings: newTotal, savings: savings));
    } catch (e) {
      emit(
        SavingsError(
          message: e.toString(),
          totalSavings: state.totalSavings,
          savings: savings,
        ),
      );
    }
  }

  // Clear all savings
  Future<void> clearAllSavings() async {
    try {
      await localStorage.clearAllSavings();

      savings.clear();

      emit(const SavingsLoaded(totalSavings: 0, savings: []));
    } catch (e) {
      emit(
        SavingsError(
          message: e.toString(),
          totalSavings: state.totalSavings,
          savings: savings,
        ),
      );
    }
  }
}
