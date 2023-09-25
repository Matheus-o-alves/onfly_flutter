class ExpenseEntity {
  final String? description;
  final String? expenseDate;
  final double? amount;
  final String? latitude;
  final String? longitude;

  const ExpenseEntity({
    this.description,
    this.expenseDate,
    this.amount,
    this.latitude,
    this.longitude,
  });

  List get props => [description, expenseDate, amount, latitude, longitude];
}

class ExpenseEntityAux {
  final String? description;
  final String? expenseDate;
  final String? amount;
  final String? latitude;
  final String? longitude;

  const ExpenseEntityAux({
    this.description,
    this.expenseDate,
    this.amount,
    this.latitude,
    this.longitude,
  });

  List get props => [description, expenseDate, amount, latitude, longitude];
}
