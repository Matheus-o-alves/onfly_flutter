import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:onfly_flutter/ui/pages/home/home_page.dart';

import '../../data/models/hive_model/expense_model_hive.dart';
import '../../infra/http/database/expense_hive.dart';

class GetXExpensePresenter extends GetxController {
  final ExpenseRepository _expenseRepository = GetIt.I.get<ExpenseRepository>();
  final RxList<ExpenseModelHive> expenses = RxList<ExpenseModelHive>();
  ExpenseModelHive? editingExpense;

  GetXExpensePresenter();

  @override
  void onInit() {
    super.onInit();
    initExpenseDatabase();
  }

  final _navigateTo = Rx<String?>(null);

  Stream<String?> get navigateToStream => _navigateTo.stream;

  Future<void> navigationHomePage() async {
    _navigateTo.value = '/home-page';
  }

  Future<void> initExpenseDatabase() async {
    await getAllExpenses();
  }

  Future<void> addExpense(ExpenseModelHive expense) async {
    await _expenseRepository.addExpense(expense);
    expenses.add(expense);
  }

  void startEditing(ExpenseModelHive expense) {
    editingExpense = expense;
  }

  void stopEditing() {
    editingExpense = null;
  }

  bool isEditing(ExpenseModelHive expense) {
    return editingExpense == expense;
  }

  Future<void> updateExpense(
      int identifier, ExpenseModelHive updatedExpense) async {
    final index = expenses.indexOf(updatedExpense);

    await _expenseRepository.updateExpense(identifier, updatedExpense);
    expenses[identifier] = updatedExpense;
    stopEditing();
  }

  Future<void> deleteExpense(ExpenseModelHive expense) async {
    final index = expenses.indexOf(expense);
    if (index != -1) {
      await _expenseRepository.deleteExpense(index);
      expenses.removeAt(index);
    }
  }

  Future<void> getAllExpenses() async {
    final allExpenses = await _expenseRepository.getAllExpenses();
    expenses.assignAll(allExpenses);
  }

  void navigateProductList() {
    Get.to(() => HomePage());
  }
}
