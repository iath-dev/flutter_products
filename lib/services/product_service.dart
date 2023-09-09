import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_products/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl = "inventory-app-f1731-default-rtdb.firebaseio.com";
  final List<Product> _products = [];

  File? newFile;

  Product? _selectedProduct;
  bool isLoading = false;

  Product get selectedProduct => _selectedProduct!;
  set selectedProduct(Product value) => _selectedProduct = value;

  ProductService() {
    loadProducts();
  }

  List<Product> get products => _products;

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, "products.json");
    final res = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(res.body);

    productsMap.forEach((key, value) {
      final product = Product.fromJson(value);
      product.id = key;

      _products.add(product);
    });

    isLoading = false;
    notifyListeners();

    return _products;
  }

  Future saveOrCreateProduct(Product product) async {
    final img = await uploadImage();

    if (img != null) product.picture = img;

    if (product.id == null) {
      createProduct(product);
    } else {
      await updateProduct(product);
    }

    newFile = null;
  }

  createProduct(Product product) async {
    final url = Uri.https(_baseUrl, "products.json");
    final res = await http.post(url, body: product.toRawJson());

    product.id = json.decode(res.body)["name"];

    _products.add(product);
    notifyListeners();
  }

  updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, "products/${product.id}.json");
    await http.put(url, body: product.toRawJson());

    final index = _products.indexWhere((element) => element.id == product.id);

    _products[index] = product;
    notifyListeners();
  }

  changeImage(String path) {
    selectedProduct.picture = path;
    newFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newFile == null) return null;

    final url = Uri.parse(
        "https://api.cloudinary.com/v1_1/dw7r43npi/image/upload?upload_preset=pogvgyq0");

    final uploadRequest = http.MultipartRequest("POST", url);
    final file = await http.MultipartFile.fromPath("file", newFile!.path);

    uploadRequest.files.add(file);

    final streamResponse = await uploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) return null;

    return json.decode(resp.body)['secure_url'];
  }
}
