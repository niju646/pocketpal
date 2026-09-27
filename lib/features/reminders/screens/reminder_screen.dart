import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pocket_pal/core/shared/utlis/date_helper.dart';
import 'package:pocket_pal/features/reminders/cubit/reminder_cubit.dart';
import 'package:pocket_pal/features/reminders/widgets/reminder_add_card.dart';
import 'package:pocket_pal/features/reminders/widgets/reminder_card.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FF),
        title: Text(
          'Recurring Bills & Reminders',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text('Repeats every month automatically until deleted'),
              const SizedBox(height: 10),
              BlocListener<ReminderCubit, ReminderState>(
                listener: (context, state) {
                  if (state is ReminderAdded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Reminder created successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }

                  if (state is ReminderDeleted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Reminder deleted successfully'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }

                  if (state is ReminderError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(state.message),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: ReminderAddCard(
                  title: titleController,
                  amount: amountController,
                  date: dateController,
                  onPressed: () {
                    final title = titleController.text.trim();
                    final amountText = amountController.text.trim();
                    final dateText = dateController.text.trim();

                    // Check title
                    if (title.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter title'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    // Check amount
                    if (amountText.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter amount'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    // Convert amount
                    final amount = double.tryParse(amountText);

                    if (amount == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid amount'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    // Check date
                    if (dateText.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select a date'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    // Convert date
                    final date = DateFormat('dd/MM/yyyy').parse(dateText);

                    // Add reminder
                    context.read<ReminderCubit>().addReminder(
                      title: title,
                      amount: amount,
                      date: date,
                    );

                    // Clear fields
                    titleController.clear();
                    amountController.clear();
                    dateController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Reminder created'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Bills',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  TextButton(onPressed: () {}, child: const Text('See all')),
                ],
              ),

              BlocBuilder<ReminderCubit, ReminderState>(
                builder: (context, state) {
                  final reminders = state.reminders;

                  if (reminders.isEmpty) {
                    return const Center(child: Text('No reminders'));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reminders.length,
                    itemBuilder: (context, index) {
                      final reminder = reminders[index];
                      return ReminderCard(
                        amount: reminder.amount,
                        date: formatDate(reminder.date),
                        title: reminder.title,
                        ondelete: () {
                          context.read<ReminderCubit>().deleteReminder(
                            reminder,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
