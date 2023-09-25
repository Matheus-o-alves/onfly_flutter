import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:onfly_flutter/data/models/expense_model.dart';
import 'package:onfly_flutter/data/models/hive_model/expense_model_hive.dart';
import 'package:onfly_flutter/data/usecases/add_expense_remote.dart';

import '../../infra/http/database/expense_hive.dart';
import '../../data/usecases/remote_list_expense.dart';
import '../../ui/pages/expense/expense_page.dart';

class GetXHomePagePresenter extends GetxController {
  var isLoading = true.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var isSynced = false.obs;
  var searchQuery = ''.obs;
  final _navigateTo = Rx<String?>(null);

  Stream<String?> get navigateToStream => _navigateTo.stream;

  ExpenseRepository expenseRepository = GetIt.I.get<ExpenseRepository>();
  var expenses = <ExpenseModelHive>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    isSynced.value = false;
    await initExpenseDatabase();
    await syncExpenses();
    await getAllExpenses();
  }

  Future<void> initExpenseDatabase() async {
    await getAllExpenses();
  }

  Future<void> syncExpenses() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      List<ExpenseModelHive> fetchedExpenses =
          await expenseRepository.getAllExpenses();

      if (searchQuery.value.isNotEmpty) {
        fetchedExpenses = fetchedExpenses
            .where((expense) => expense.description
                .toLowerCase()
                .contains(searchQuery.value.toLowerCase()))
            .toList();
      }

      expenses.clear();
      expenses.addAll(fetchedExpenses);
      isSynced.value = true;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Erro inesperado: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getAllExpenses() async {
    expenses.clear();
    expenses.addAll(await expenseRepository.getAllExpenses());
  }

  Future<void> updateExpense(int index, ExpenseModelHive updatedExpense) async {
    await expenseRepository.updateExpense(index, updatedExpense);
    expenses[index] = updatedExpense;
  }

  Future<void> deleteExpense(int index) async {
    await expenseRepository.deleteExpense(index);
    expenses.removeAt(index);
  }

  void navigateToExpenseDetails(ExpenseModelHive expense) {
    Get.to(() => ExpensePage(
          initialExpense: expense,
        ));
  }

  Future<void> syncExpensesToAPI() async {
    try {
      final allExpenses = expenses.toList();

      final apiExpenses = allExpenses.map(convertHiveToExpenseModel).toList();

      final addExpenseRemote = AddExpenseRemote();

      for (final expense in apiExpenses) {
        await addExpenseRemote.addExpense(expense);
      }

      for (final expense in allExpenses) {
        final updatedExpense = ExpenseModelHive(
            description: expense.description,
            expenseDate: expense.expenseDate,
            amount: expense.amount,
            latitude: expense.latitude,
            longitude: expense.longitude,
            indefier: expense.indefier,
            isSync: true);

        await expenseRepository.updateExpense(
            updatedExpense.indefier, updatedExpense);
      }
    } catch (e) {
      Get.snackbar(
        'Erro na sincronização',
        'Ocorreu um erro ao sincronizar as despesas: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  ExpenseModelAux convertHiveToExpenseModel(ExpenseModelHive hiveExpense) {
    return ExpenseModelAux(
      description: hiveExpense.description,
      expenseDate: hiveExpense.expenseDate,
      amount: hiveExpense.amount.toString(),
      latitude: hiveExpense.latitude,
      longitude: hiveExpense.longitude,
    );
  }

  Future<void> syncGetExpensesToAPI() async {
    var random = Random();
    int randomInt = random.nextInt(100);
    try {
      final listExpenseRemote = ListExpenseRemote();

      final apiExpenses = await listExpenseRemote.fetchExpenses();

      final hiveExpenses = apiExpenses.map((expense) {
        return ExpenseModelHive(
            description: expense.description,
            expenseDate: expense.expenseDate,
            amount: expense.amount,
            latitude: expense.latitude,
            longitude: expense.longitude,
            indefier: randomInt,
            isSync: false);
      }).toList();

      for (final hiveExpense in hiveExpenses) {
        await expenseRepository.addExpense(hiveExpense);
      }

      expenses.assignAll(hiveExpenses);

      Get.snackbar(
        'Sincronização concluída',
        'Todas as despesas foram sincronizadas com sucesso!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Erro na sincronização',
        'Ocorreu um erro ao sincronizar as despesas: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
