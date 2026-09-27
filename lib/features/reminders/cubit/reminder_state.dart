part of 'reminder_cubit.dart';

abstract class ReminderState {
  final List<ReminderModel> reminders;

  const ReminderState({this.reminders = const []});
}

class ReminderInitial extends ReminderState {
  const ReminderInitial({super.reminders});
}

class ReminderAdding extends ReminderState {
  const ReminderAdding({super.reminders});
}

class ReminderAdded extends ReminderState {
  const ReminderAdded({super.reminders});
}

class ReminderError extends ReminderState {
  final String message;

  const ReminderError(this.message, {super.reminders});
}

class ReminderDeleting extends ReminderState {
  const ReminderDeleting({super.reminders});
}

class ReminderDeleted extends ReminderState {
  const ReminderDeleted({super.reminders});
}
