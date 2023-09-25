import '../../data/models/expense_model.dart';

abstract class ListExpenseRequest {
  Future<List<ExpenseModel>> fetchExpenses();
}
