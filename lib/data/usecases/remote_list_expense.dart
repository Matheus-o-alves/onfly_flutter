import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onfly_flutter/data/http/http_error.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecases/list_expense_request.dart';
import '../models/expense_model.dart';
import '../models/list_expense_model.dart';

class ListExpenseRemote implements ListExpenseRequest {
  @override
  Future<List<ExpenseModel>> fetchExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final name = prefs.getString('name') ?? '';

    final url =
        "https://go-bd-api-3iyuzyysfa-uc.a.run.app/api/collections/expense_$name/records";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

        final ListExpenseModel listExpenseModel =
            ListExpenseModel.fromJson(jsonData);

        return listExpenseModel.items;
      } else {
        if (response.statusCode == 400) {
          throw HttpError.badRequest;
        } else if (response.statusCode == 404) {
          throw HttpError.notFound;
        } else if (response.statusCode == 500) {
          throw HttpError.serverError;
        } else if (response.statusCode == 401) {
          throw HttpError.unauthorized;
        } else if (response.statusCode == 403) {
          throw HttpError.forbidden;
        } else {
          throw HttpError.invalidData;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
