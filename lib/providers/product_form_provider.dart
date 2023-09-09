import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_products/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Product product;
  bool _loading = false;

  File? newFile;
  bool get isValid => formKey.currentState?.validate() ?? false;

  set loading(value) {
    _loading = value;
    notifyListeners();
  }

  ProductFormProvider({required this.product});

  toggleAvailable(bool value) {
    product.available = value;

    notifyListeners();
  }
}
