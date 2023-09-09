import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _token = "AIzaSyDNYBsGCVQDePnFRly286CrdMTLax_oJkw";
  final String _baseUrl = "identitytoolkit.googleapis.com";

  final storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));

  Future<String> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };

    final url = Uri.https(_baseUrl, 'v1/accounts:signUp', {'key': _token});
    final resp = await http.post(url, body: json.encode(authData));

    if (resp.statusCode == 200) {
      final res = json.decode(resp.body);

      await storage.write(key: "token", value: res['idToken']);
      return res['idToken'];
    }

    return "";
  }

  Future<String> loginUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true
    };

    final url =
        Uri.https(_baseUrl, 'v1/accounts:signInWithPassword', {'key': _token});
    final resp = await http.post(url, body: json.encode(authData));

    if (resp.statusCode == 200) {
      final res = json.decode(resp.body);

      await storage.write(key: "token", value: res['idToken']);
      return res['idToken'];
    }

    return "";
  }

  Future logout() async {
    await storage.delete(key: "token");
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: "token") ?? "";
  }
}
