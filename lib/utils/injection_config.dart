import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:onfly_flutter/data/models/hive_model/expense_model_hive.dart';

import '../infra/http/database/expense_hive.dart';

void configureInjection() {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<Box<ExpenseModelHive>>(
      () => Hive.box<ExpenseModelHive>('expenses'));

  getIt.registerLazySingleton<ExpenseRepository>(
      () => HiveExpenseRepository(getIt<Box<ExpenseModelHive>>()));
}
