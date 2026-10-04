import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_pal/core/shared/utlis/date_helper.dart';
import 'package:pocket_pal/core/theme/app_colors.dart';
import 'package:pocket_pal/features/home/widgets/common_empty_screen.dart';
import 'package:pocket_pal/features/reminders/cubit/reminder_cubit.dart';
import 'package:pocket_pal/features/reminders/widgets/reminder_card.dart';

class RemindersListingScreen extends StatelessWidget {
  const RemindersListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text(
          'All Reminders',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<ReminderCubit, ReminderState>(
                builder: (context, state) {
                  final reminders = state.reminders;

                  if (reminders.isEmpty) {
                    return CommonEmptyScreen(
                      icon: Icons.calendar_month,
                      title: "No Reminders",
                      message: 'Create a reminder to start',
                    );
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
