import 'package:flutter/material.dart';
import 'package:flutter_products/models/models.dart';
import 'package:flutter_products/services/product_service.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  final Product product;

  const ListItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    return ListTile(
      onTap: () {
        productService.selectedProduct = product.copy();
        Navigator.pushNamed(context, "edit");
      },
      title: Text(product.name),
      leading: _ItemImage(
        picture: product.picture,
      ),
      trailing: Text(
        "${product.price} US",
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}

class _ItemImage extends StatelessWidget {
  final String? picture;

  const _ItemImage({
    super.key,
    this.picture,
  });

  @override
  Widget build(BuildContext context) {
    print(picture);

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: FadeInImage.assetNetwork(
        width: 70,
        height: 40,
        placeholder: "assets/img_loading.gif",
        image: picture ?? "https://fakeimg.pl/600x400",
        fit: BoxFit.cover,
      ),
    );
  }
}
