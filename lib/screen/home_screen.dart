import 'package:flutter/material.dart';
import 'package:flutter_products/helpers/helpers.dart';
import 'package:flutter_products/models/models.dart';
import 'package:flutter_products/screen/screen.dart';
import 'package:flutter_products/services/services.dart';
import 'package:flutter_products/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortBy = ['title', 'date', 'price'];

    final productsService = Provider.of<ProductService>(context, listen: true);

    if (productsService.isLoading) {
      return const SplashScreen();
    }

    final products = productsService.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory"),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: (context) =>
                sortBy.map((e) => PopupMenuItem(child: Text("By $e"))).toList(),
          ),
          IconButton(
            onPressed: () =>
                showSearch(context: context, delegate: ProductsDelegate()),
            icon: const Icon(Icons.search),
            splashRadius: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
            splashRadius: 20,
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: products.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => ListItem(
          product: products[index],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            productsService.selectedProduct =
                Product(available: false, name: "", price: 0.0);

            Navigator.pushNamed(context, "edit");
          },
          child: const Icon(Icons.add)),
    );
  }
}
