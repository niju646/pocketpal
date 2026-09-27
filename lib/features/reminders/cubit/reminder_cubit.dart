import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/features/reminders/data/models/reminder_model.dart';
import 'package:pocket_pal/features/reminders/data/reminder_local_storage.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  ReminderCubit() : super(const ReminderInitial()) {
    loadReminders();
  }

  final ReminderLocalStorage localStorage = ReminderLocalStorage();

  List<ReminderModel> reminders = [];

  // Load reminders
  void loadReminders() {
    reminders = localStorage.getReminders();

    emit(ReminderInitial(reminders: reminders));
  }

  // Add reminder
  Future<void> addReminder({
    required String title,
    required double amount,
    required DateTime date,
  }) async {
    emit(ReminderAdding(reminders: reminders));
    try {
      final reminder = ReminderModel(title: title, amount: amount, date: date);

      await localStorage.addReminder(reminder);

      reminders.insert(0, reminder);

      emit(ReminderAdded(reminders: reminders));
    } catch (e) {
      emit(ReminderError(e.toString(), reminders: reminders));
    }
  }

  // Get reminders
  List<ReminderModel> getReminders() {
    return reminders;
  }

  //delete reminders
  Future<void> deleteReminder(ReminderModel reminder) async {
    emit(ReminderDeleting(reminders: reminders));

    try {
      await localStorage.deleteReminder(reminder);

      reminders.remove(reminder);

      emit(ReminderDeleted(reminders: reminders));
    } catch (e) {
      emit(ReminderError(e.toString(), reminders: reminders));
    }
  }
}
