import 'package:onfly_flutter/data/models/expense_model.dart';

abstract class AddExpense {
  Future<void> addExpense(ExpenseModelAux expenseModel);
}
