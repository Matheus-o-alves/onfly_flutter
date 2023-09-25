import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/hive_model/expense_model_hive.dart';

abstract class ExpenseRepository {
  Future<List<ExpenseModelHive>> getAllExpenses();
  Future<void> addExpense(ExpenseModelHive expense);
  Future<void> updateExpense(int identifier, ExpenseModelHive updatedExpense);
  Future<void> deleteExpense(int index);
}

class HiveExpenseRepository implements ExpenseRepository {
  final Box<ExpenseModelHive> _expenseBox;

  HiveExpenseRepository(this._expenseBox);

  @override
  Future<List<ExpenseModelHive>> getAllExpenses() async {
    return _expenseBox.values.toList();
  }

  @override
  Future<void> addExpense(ExpenseModelHive expense) async {
    await _expenseBox.add(expense);
  }

  @override
  Future<void> updateExpense(int id, ExpenseModelHive updatedExpense) async {
    final index = _expenseBox.values
        .toList()
        .indexWhere((expense) => expense.indefier == id);
    if (index != -1) {
      await _expenseBox.putAt(index, updatedExpense);
    }
  }

  @override
  Future<void> deleteExpense(int index) async {
    await _expenseBox.deleteAt(index);
  }
}
