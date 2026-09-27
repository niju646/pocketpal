class ReminderModel {
  final String title;
  final double amount;
  final DateTime date;

  ReminderModel({
    required this.title,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {'title': title, 'amount': amount, 'date': date.toIso8601String()};
  }

  factory ReminderModel.fromMap(Map<dynamic, dynamic> map) {
    return ReminderModel(
      title: map['title']?.toString() ?? '',
      amount: (map['amount'] as num?)?.toDouble() ?? 0,
      date: map['date'] != null
          ? DateTime.parse(map['date'].toString())
          : DateTime.now(),
    );
  }
}
