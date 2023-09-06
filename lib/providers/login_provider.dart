import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  bool _loading = false;

  bool get isValid => formKey.currentState?.validate() ?? false;
  String get email => _email;
  String get password => _password;
  bool get loading => _loading;

  set email(value) => _email = value;
  set password(value) => _password = value;

  set loading(value) {
    _loading = value;
    notifyListeners();
  }
}
