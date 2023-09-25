import '../../domain/entities/expense_entity.dart';
import '../http/http.dart';

class ExpenseModel {
  final String description;
  final String expenseDate;
  final double amount;
  final String latitude;
  final String longitude;

  ExpenseModel({
    required this.description,
    required this.expenseDate,
    required this.amount,
    required this.latitude,
    required this.longitude,
  });

  factory ExpenseModel.fromJson(Map json) {
    final requiredKeys = [
      'description',
      'expense_date',
      'amount',
      'latitude',
      'longitude'
    ];
    for (final key in requiredKeys) {
      if (!json.containsKey(key)) {
        throw HttpError.invalidData;
      }
    }
    return ExpenseModel(
      description: json['description'] as String,
      expenseDate: json['expense_date'] as String,
      amount: json['amount'] as double,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );
  }

  Map toJson() => {
        'description': description,
        'expense_date': expenseDate,
        'amount': amount,
        'latitude': latitude,
        'longitude': longitude,
      };

  ExpenseEntity toEntity() => ExpenseEntity(
        description: description,
        expenseDate: expenseDate,
        amount: amount,
        latitude: latitude,
        longitude: longitude,
      );
}

class ExpenseModelAux {
  final String description;
  final String expenseDate;
  final String amount;
  final String latitude;
  final String longitude;

  ExpenseModelAux({
    required this.description,
    required this.expenseDate,
    required this.amount,
    required this.latitude,
    required this.longitude,
  });

  factory ExpenseModelAux.fromJson(Map json) {
    final requiredKeys = [
      'description',
      'expense_date',
      'amount',
      'latitude',
      'longitude'
    ];
    for (final key in requiredKeys) {
      if (!json.containsKey(key)) {
        throw HttpError.invalidData;
      }
    }
    return ExpenseModelAux(
      description: json['description'] as String,
      expenseDate: json['expense_date'] as String,
      amount: json['amount'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );
  }

  Map toJson() => {
        'description': description,
        'expense_date': expenseDate,
        'amount': amount,
        'latitude': latitude,
        'longitude': longitude,
      };

  ExpenseEntityAux toEntity() => ExpenseEntityAux(
        description: description,
        expenseDate: expenseDate,
        amount: amount,
        latitude: latitude,
        longitude: longitude,
      );
}
