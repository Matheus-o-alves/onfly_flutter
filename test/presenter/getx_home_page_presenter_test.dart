import 'package:flutter_test/flutter_test.dart';

import 'package:onfly_flutter/data/models/hive_model/expense_model_hive.dart';
import 'package:onfly_flutter/presentation/presenters/getx_home_page_presenter.dart';

void main() {
  group('GetXHomePagePresenter Tests', () {
    test('initExpenseDatabase should initialize expenses list', () async {
      final presenter = GetXHomePagePresenter();

      await presenter.initExpenseDatabase();

      expect(presenter.expenses, isEmpty);
    });

    test('updateExpense should update an expense', () async {
      final presenter = GetXHomePagePresenter();
      final initialExpense = ExpenseModelHive(
          description: 'Aluguel',
          amount: 1000.0,
          expenseDate: '2023, 9, 20,',
          indefier: 0,
          isSync: false,
          latitude: '80000',
          longitude: '8000');
      presenter.expenses.add(initialExpense);

      final updatedExpense = ExpenseModelHive(
          description: 'Aluguel',
          amount: 1000.0,
          expenseDate: '2023, 9, 20,',
          indefier: 0,
          isSync: false,
          latitude: '80000',
          longitude: '8000');

      await presenter.updateExpense(0, updatedExpense);

      expect(presenter.expenses[0], equals(updatedExpense));
    });

    test('deleteExpense should delete an expense', () async {
      final presenter = GetXHomePagePresenter();
      final expenseToDelete = ExpenseModelHive(
          description: 'Aluguel',
          amount: 1000.0,
          expenseDate: '2023, 9, 20,',
          indefier: 0,
          isSync: false,
          latitude: '80000',
          longitude: '8000');
      presenter.expenses.add(expenseToDelete);

      await presenter.deleteExpense(0);

      expect(presenter.expenses, isEmpty);
    });

    test('navigateToExpenseDetails should navigate to expense details', () {
      final presenter = GetXHomePagePresenter();
      final expense = ExpenseModelHive(
          description: 'Aluguel',
          amount: 1000.0,
          expenseDate: '2023, 9, 20,',
          indefier: 0,
          isSync: false,
          latitude: '80000',
          longitude: '8000');

      presenter.navigateToExpenseDetails(expense);
    });
  });
}
