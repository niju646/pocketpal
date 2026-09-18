import 'package:hive/hive.dart';
import 'package:pocket_pal/features/home/data/transaction_model.dart';

class TransactionLocalStorage {
  final Box box = Hive.box('transactions');

  Future<void> addTransaction(TransactionModel transaction) async {
    await box.add(transaction.toMap());
  }

  List<TransactionModel> getTransactions() {
    final data = box.values.toList();

    return data.map((item) {
      return TransactionModel.fromMap(item);
    }).toList();
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    for (final key in box.keys) {
      final data = box.get(key);

      final storedTransaction = TransactionModel.fromMap(data);

      if (storedTransaction.date == transaction.date &&
          storedTransaction.amount == transaction.amount &&
          storedTransaction.category == transaction.category &&
          storedTransaction.isIncome == transaction.isIncome) {
        await box.delete(key);
        break;
      }
    }
  }

  Future<void> clearAllTransactions() async {
    await box.clear();
  }
}
