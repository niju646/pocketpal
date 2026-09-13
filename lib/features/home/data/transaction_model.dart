class TransactionModel {
  final String title;
  final String category;
  final double amount;
  final String date;
  final bool isIncome;
  final String? description;

  TransactionModel({
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.isIncome,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category,
      'amount': amount,
      'date': date,
      'isIncome': isIncome,
      'description': description,
    };
  }

  factory TransactionModel.fromMap(Map<dynamic, dynamic> map) {
    return TransactionModel(
      title: map['title']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      amount: (map['amount'] as num?)?.toDouble() ?? 0,
      date: map['date']?.toString() ?? '',
      isIncome: map['isIncome'] ?? false,
      description: map['description']?.toString(),
    );
  }
}
