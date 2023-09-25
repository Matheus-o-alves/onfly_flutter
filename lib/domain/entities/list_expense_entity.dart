import 'package:onfly_flutter/domain/entities/expense_entity.dart';

class DataEntity {
  final int? page;
  final int? perPage;
  final int? totalItems;
  final int? totalPages;
  final List<ExpenseEntity>? items;

  const DataEntity({
    this.page,
    this.perPage,
    this.totalItems,
    this.totalPages,
    this.items,
  });
}
