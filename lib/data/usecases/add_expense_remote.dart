import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecases/add_expense.dart';
import '../models/expense_model.dart';

class AddExpenseRemote implements AddExpense {
  @override
  Future<void> addExpense(ExpenseModelAux expenseModel) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final name = prefs.getString('name') ?? '';

    final url =
        "https://go-bd-api-3iyuzyysfa-uc.a.run.app/api/collections/expense_$name/records";

    try {
      await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: expenseModel.toJson(),
      );
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
