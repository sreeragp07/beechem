import 'dart:convert';

import 'package:beechem/models/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<Login> loginUser({required String email, required String password}) async {
    const String url = "https://beechem.ishtech.live/api/login";
    final body = {
      "email": email,
      "password": password,
      "mob_user": 1, // mobile login
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        debugPrint(response.body);
        return Login.fromJson(jsonDecode(response.body));
      } else {
        debugPrint(response.body);
        throw Exception("Login failed: ${response.body}");
      }
    } catch (e) {
      throw Exception("Login failed");
    }
  }
}
