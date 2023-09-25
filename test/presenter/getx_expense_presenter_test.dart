import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:onfly_flutter/data/models/hive_model/expense_model_hive.dart';
import 'package:onfly_flutter/data/usecases/hive_usecases/expense_hive.dart';
import 'package:onfly_flutter/presentation/presenters/getx_expense_presenter.dart';
import 'package:onfly_flutter/utils/injection_config.dart';

class MockExpenseRepository extends Mock implements ExpenseRepository {}

void main() {
  group('GetXExpensePresenter', () {
    late GetXExpensePresenter presenter;
    late MockExpenseRepository mockRepository;

    setUp(() {
      configureInjection();
      mockRepository = MockExpenseRepository();
      Get.put<ExpenseRepository>(mockRepository); // Registre o mock no GetIt.
      presenter = GetXExpensePresenter();
    });

    tearDown(() {
      Get.reset(); // Limpe todas as instâncias registradas no GetIt após cada teste.
    });

    test('addExpense should add an expense to the list', () async {
      final mockExpense = ExpenseModelHive(
          description: 'Aluguel',
          amount: 1000.0,
          expenseDate: '2023, 9, 20,',
          indefier: 0,
          isSync: false,
          latitude: '80000',
          longitude: '8000');

      await presenter.addExpense(mockExpense);

      expect(presenter.expenses, contains(mockExpense));
    });

    test('startEditing should set editingExpense', () {
      final mockExpense = ExpenseModelHive(
          description: 'Aluguel',
          amount: 1000.0,
          expenseDate: '2023, 9, 20,',
          indefier: 0,
          isSync: false,
          latitude: '80000',
          longitude: '8000');

      presenter.startEditing(mockExpense);

      expect(presenter.editingExpense, equals(mockExpense));
    });

    test('stopEditing should reset editingExpense', () {
      final mockExpense = ExpenseModelHive(
          description: 'Aluguel',
          amount: 1000.0,
          expenseDate: '2023, 9, 20,',
          indefier: 0,
          isSync: false,
          latitude: '80000',
          longitude: '8000');

      presenter.startEditing(mockExpense);
      presenter.stopEditing();

      expect(presenter.editingExpense, isNull);
    });

    test('isEditing should return true when editing the expense', () {
      final mockExpense = ExpenseModelHive(
          description: 'Aluguel',
          amount: 1000.0,
          expenseDate: '2023, 9, 20,',
          indefier: 0,
          isSync: false,
          latitude: '80000',
          longitude: '8000');

      presenter.startEditing(mockExpense);

      expect(presenter.isEditing(mockExpense), isTrue);
    });

    // Você pode criar testes semelhantes para os outros métodos da classe.

    test('navigationHomePage should set navigateTo', () {
      presenter.navigationHomePage();

      expect(presenter.navigateToStream, emits('/home-page'));
    });
  });
}
