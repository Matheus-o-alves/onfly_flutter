import 'package:onfly_flutter/data/models/expense_model.dart';

class ListExpenseModel {
  final int page;
  final int perPage;
  final int totalItems;
  final int totalPages;
  final List<ExpenseModel> items;

  ListExpenseModel({
    required this.page,
    required this.perPage,
    required this.totalItems,
    required this.totalPages,
    required this.items,
  });

  factory ListExpenseModel.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['items'] as List;
    final List<ExpenseModel> expenseItems = itemsJson
        .map((item) => ExpenseModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return ListExpenseModel(
      page: json['page'] as int,
      perPage: json['perPage'] as int,
      totalItems: json['totalItems'] as int,
      totalPages: json['totalPages'] as int,
      items: expenseItems,
    );
  }
}
