import 'package:hive/hive.dart';
part 'expense_model_hive.g.dart';

@HiveType(typeId: 0)
class ExpenseModelHive extends HiveObject {
  @HiveField(0)
  final String description;

  @HiveField(1)
  final String expenseDate;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final String latitude;

  @HiveField(4)
  final String longitude;

  @HiveField(5)
  final int indefier;
  @HiveField(6)
  final bool isSync;

  ExpenseModelHive(
      {required this.description,
      required this.expenseDate,
      required this.amount,
      required this.latitude,
      required this.longitude,
      required this.indefier,
      required this.isSync});
}
