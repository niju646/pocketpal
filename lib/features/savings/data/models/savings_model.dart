class SavingsModel {
  final double amount;
  final DateTime date;
  final String note;

  SavingsModel({required this.amount, required this.date, required this.note});

  Map<String, dynamic> toMap() {
    return {'amount': amount, 'date': date.toIso8601String(), 'note': note};
  }

  factory SavingsModel.fromMap(Map<dynamic, dynamic> map) {
    return SavingsModel(
      amount: (map['amount'] as num).toDouble(),
      date: DateTime.parse(map['date']),
      note: map['note'] ?? '',
    );
  }
}
