import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:onfly_flutter/data/models/hive_model/expense_model_hive.dart';
import 'package:onfly_flutter/data/usecases/hive_usecases/expense_hive.dart';

class MockExpenseBox extends Mock implements Box<ExpenseModelHive> {}

void main() {
  group('HiveExpenseRepository', () {
    late HiveExpenseRepository repository;
    late Box<ExpenseModelHive> mockExpenseBox;

    setUpAll(() async {
      await Hive.initFlutter(); // Inicialize Hive para testes.
    });

    setUp(() {
      mockExpenseBox = MockExpenseBox();
      repository = HiveExpenseRepository(mockExpenseBox);
    });

    test('getAllExpenses should return a list of expenses', () async {
      final mockExpenses = [
        ExpenseModelHive(
            description: 'Aluguel',
            amount: 1000.0,
            expenseDate: '2023, 9, 20,',
            indefier: 0,
            isSync: false,
            latitude: '80000',
            longitude: '8000'),
        ExpenseModelHive(
            description: 'Aluguel',
            amount: 1000.0,
            expenseDate: '2023, 9, 20,',
            indefier: 1,
            isSync: false,
            latitude: '80000',
            longitude: '8000'),
      ];

      when(mockExpenseBox.values).thenReturn(mockExpenses);

      final expenses = await repository.getAllExpenses();

      expect(expenses, mockExpenses);
    });

    test('addExpense should add an expense to the box', () async {
      final mockExpense = ExpenseModelHive(
          description: 'Aluguel',
          amount: 1000.0,
          expenseDate: '2023, 9, 20,',
          indefier: 0,
          isSync: false,
          latitude: '80000',
          longitude: '8000');

      await repository.addExpense(mockExpense);

      verify(mockExpenseBox.add(mockExpense));
    });

    // test('updateExpense should update an expense in the box', () async {
    //   final mockId = 1; // Preencha com um ID fictício.
    //   final mockUpdatedExpense = ExpenseModelHive(description: 'Aluguel',
    //       amount: 1000.0,
    //       expenseDate: '2023, 9, 20,',
    //       indefier: 0,
    //       isSync: false,
    //       latitude: '80000',
    //       longitude: '8000');

    //   when(mockExpenseBox.values).thenReturn([
    //     ExpenseModelHive(/* Preencha com os dados fictícios */),
    //     ExpenseModelHive(/* Preencha com os dados fictícios */),
    //   ]);

    //   await repository.updateExpense(mockId, mockUpdatedExpense);

    //   verify(mockExpenseBox.putAt(any, mockUpdatedExpense)); // Verifique se a função putAt foi chamada com o expense correto.
    // });

    test('deleteExpense should delete an expense from the box', () async {
      final mockIndex = 1; // Preencha com o índice fictício.

      await repository.deleteExpense(mockIndex);

      verify(mockExpenseBox.deleteAt(mockIndex));
    });
  });
}
