import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onfly_flutter/domain/usecases/login_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http/http_error.dart';

class RemoteAuthRequest implements AuthRequest {
  final String baseUrl =
      'https://go-bd-api-3iyuzyysfa-uc.a.run.app/api/collections/users/auth-with-password';

  @override
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    final requestPayload = {
      'identity': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestPayload),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        final token = jsonData['token'];
        final name = jsonData['record']['name'];

        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);
        prefs.setString('name', name);
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
    } catch (error) {
      throw HttpError.invalidMethod;
    }
  }
}
