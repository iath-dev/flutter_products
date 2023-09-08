import 'package:flutter/material.dart';
import 'package:flutter_products/helpers/helpers.dart';
import 'package:flutter_products/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortBy = ['title', 'date', 'price'];

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
        ],
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) => const ListItem(),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}
