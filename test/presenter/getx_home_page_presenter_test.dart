import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onfly_flutter/data/models/hive_model/expense_model_hive.dart';
import 'package:onfly_flutter/data/usecases/hive_usecases/expense_hive.dart';
import 'package:onfly_flutter/presentation/presenters/getx_home_page_presenter.dart';
import 'package:onfly_flutter/utils/injection_config.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  group('HiveExpenseRepository Tests', () {
    late Box<ExpenseModelHive> expenseBox;
    late HiveExpenseRepository expenseRepository;

    setUp(() async {
      // Inicialize o Hive
      await Hive.initFlutter();

      // Abra a caixa (box) com um nome único para os testes
      expenseBox = await Hive.openBox<ExpenseModelHive>('test_expenses');

      // Crie uma instância do HiveExpenseRepository
      expenseRepository = HiveExpenseRepository(expenseBox);
    });

    tearDown(() async {
      // Limpe a caixa após cada teste
      await expenseBox.clear();
    });

    test('Teste de adição de despesa', () async {
      final expense = ExpenseModelHive(
        indefier: 1,
        description: 'Test Expense',
        amount: 100.0,
        expenseDate: '2023-09-24',
        latitude: '12.345',
        longitude: '67.890',
        isSync: false,
      );

      await expenseRepository.addExpense(expense);

      final savedExpenses = await expenseRepository.getAllExpenses();

      expect(savedExpenses.length, 1);
      expect(savedExpenses[0].description, 'Test Expense');
      expect(savedExpenses[0].amount, 100.0);
      expect(savedExpenses[0].expenseDate, '2023-09-24');
      expect(savedExpenses[0].latitude, '12.345');
      expect(savedExpenses[0].longitude, '67.890');
      expect(savedExpenses[0].isSync, false);
    });

    test('Teste de atualização de despesa', () async {
      final initialExpense = ExpenseModelHive(
        indefier: 2,
        description: 'Initial Expense',
        amount: 200.0,
        expenseDate: '2023-09-25',
        latitude: '11.111',
        longitude: '66.666',
        isSync: true,
      );

      await expenseRepository.addExpense(initialExpense);

      final updatedExpense = ExpenseModelHive(
        indefier: 2,
        description: 'Updated Expense',
        amount: 300.0,
        expenseDate: '2023-09-26',
        latitude: '22.222',
        longitude: '77.777',
        isSync: false,
      );

      await expenseRepository.updateExpense(
          initialExpense.indefier, updatedExpense);

      final savedExpenses = await expenseRepository.getAllExpenses();

      expect(savedExpenses.length, 1);
      expect(savedExpenses[0].description, 'Updated Expense');
      expect(savedExpenses[0].amount, 300.0);
      expect(savedExpenses[0].expenseDate, '2023-09-26');
      expect(savedExpenses[0].latitude, '22.222');
      expect(savedExpenses[0].longitude, '77.777');
      expect(savedExpenses[0].isSync, false);
    });

    test('Teste de exclusão de despesa', () async {
      final expense = ExpenseModelHive(
        indefier: 3,
        description: 'Expense to Delete',
        amount: 50.0,
        expenseDate: '2023-09-27',
        latitude: '33.333',
        longitude: '88.888',
        isSync: true,
      );

      await expenseRepository.addExpense(expense);

      final savedExpensesBeforeDelete =
          await expenseRepository.getAllExpenses();
      expect(savedExpensesBeforeDelete.length, 1);

      await expenseRepository.deleteExpense(0);

      final savedExpensesAfterDelete = await expenseRepository.getAllExpenses();
      expect(savedExpensesAfterDelete.length, 0);
    });
  });
}
