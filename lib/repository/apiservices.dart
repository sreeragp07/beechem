import 'dart:convert';

import 'package:beechem/models/login/login.dart';
import 'package:beechem/models/personaldetails/personaldetails.dart';
import 'package:beechem/models/personaldetailsaddresponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  // login api call
  Future<Login> loginUser({
    required String email,
    required String password,
  }) async {
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

  // personal details api call
  Future<PersonalDetails> fetchPersonalDetails() async {
    const String url = "https://beechem.ishtech.live/api/personnel-details";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      if (response.statusCode == 200) {
        debugPrint(response.body);
        return PersonalDetails.fromJson(jsonDecode(response.body));
      } else {
        debugPrint(response.body);
        throw Exception("Perssonal details api call failed: ${response.body}");
      }
    } catch (e) {
      throw Exception("Perssonal details api call failed");
    }
  }

  // add personal details api call
  Future<PersonalDetailsAddResponse> addPersonalDetails(
    {required String firstName,
    required String address,
    required String suburb,
    required String state,
    required String postcode,
    required String contactNumber,
    required String status,}
  ) async {
    const String url = "https://beechem.ishtech.live/api/personnel-details/add";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    final body = {
      "first_name": firstName,
      "address": address,
      "latitude": '',
      "longitude": '',
      "suburb": suburb,
      "state": state,
      "postcode": postcode,
      "country": '',
      "contact_number": contactNumber,
      "role_ids": '',
      "status": status,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(body),
      );
      debugPrint("---------------------------Request body :${jsonEncode(body)}----------------------");
      if (response.statusCode == 200) {
        debugPrint(response.body);
        return PersonalDetailsAddResponse.fromJson(jsonDecode(response.body));
      } else {
        debugPrint(response.body);
        throw Exception(
          "Add Perssonal details api call failed: ${response.body}",
        );
      }
    } catch (e) {
      throw Exception("Add Perssonal details api call failed");
    }
  }
}
