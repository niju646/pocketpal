import 'package:hive/hive.dart';
import 'package:pocket_pal/features/reminders/data/models/reminder_model.dart';

class ReminderLocalStorage {
  final Box box = Hive.box('reminders');

  Future<void> addReminder(ReminderModel reminder) async {
    await box.add(reminder.toMap());
  }

  List<ReminderModel> getReminders() {
    final data = box.values.toList();

    return data.map((item) {
      return ReminderModel.fromMap(item);
    }).toList();
  }

  Future<void> clearAllReminders() async {
    await box.clear();
  }

  Future<void> deleteReminder(ReminderModel reminder) async {
    for (final key in box.keys) {
      final data = box.get(key);

      if (data == null) {
        continue;
      }

      final storedReminder = ReminderModel.fromMap(data);

      if (storedReminder.title == reminder.title &&
          storedReminder.amount == reminder.amount &&
          storedReminder.date == reminder.date) {
        await box.delete(key);
        break;
      }
    }
  }
}
