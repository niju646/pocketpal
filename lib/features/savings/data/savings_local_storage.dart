import 'package:hive/hive.dart';
import 'package:pocket_pal/features/savings/data/models/savings_model.dart';

class SavingsLocalStorage {
  final Box box = Hive.box('savings');

  Future<void> addSavings(SavingsModel savings) async {
    await box.add(savings.toMap());
  }

  List<SavingsModel> getSavings() {
    return box.values.map((item) {
      return SavingsModel.fromMap(item);
    }).toList();
  }

  Future<void> clearAllSavings() async {
    await box.clear();
  }
}
