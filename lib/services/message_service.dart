import 'package:flutter/material.dart';

class MessageService {
  static GlobalKey<ScaffoldMessengerState> key =
      new GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String message) {
    final snackBar = new SnackBar(content: Text(message));

    key.currentState!.showSnackBar(snackBar);
  }
}
