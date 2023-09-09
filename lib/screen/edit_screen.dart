import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_products/models/product.dart';
import 'package:flutter_products/providers/product_form_provider.dart';
import 'package:flutter_products/services/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final product = productService.selectedProduct;

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(product: product),
      child: _ProductScreenBody(product: product),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!productForm.isValid) return;

          await productService.saveOrCreateProduct(productForm.product);
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
      body: CustomScrollView(
        slivers: [_EditAppBar(url: product.picture), const _EditForm()],
      ),
    );
  }
}

class _EditForm extends StatelessWidget {
  const _EditForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  initialValue: product.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "*Required";
                    return null;
                  },
                  onChanged: (value) => product.name = value,
                  decoration: const InputDecoration(label: Text("Name")),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  initialValue: product.price.toString(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      product.price = 0;
                    } else {
                      product.price = double.parse(value);
                    }
                  },
                  decoration: const InputDecoration(
                      label: Text("Price"), suffixText: "USD"),
                ),
                const SizedBox(
                  height: 12,
                ),
                SwitchListTile(
                  value: product.available,
                  onChanged: productForm.toggleAvailable,
                  dense: true,
                  title: const Text("In Stock"),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class _EditAppBar extends StatelessWidget {
  final String? url;

  const _EditAppBar({
    super.key,
    this.url,
  });

  Future loadImage(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? file =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (file == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Missing Image")));
      return;
    }

    ProductService provider =
        Provider.of<ProductService>(context, listen: false);
    provider.changeImage(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      expandedHeight: 300,
      actions: [
        IconButton(
            onPressed: () => loadImage(context),
            icon: const Icon(Icons.camera_alt))
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: const Text("Edit"),
        background: Container(
          color: Colors.white,
          child: _BackgroundImage(
            url: url,
          ),
        ),
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage({
    super.key,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      child: ColorFiltered(
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
        child: getImage(),
      ),
    );
  }

  Widget getImage() {
    if (url == null) {
      return Image.network(
        "https://fakeimg.pl/600x400",
        fit: BoxFit.cover,
      );
    }

    if (url!.startsWith("http")) {
      return FadeInImage.assetNetwork(
        placeholder: "assets/img_loading.gif",
        image: url!,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(url!),
        fit: BoxFit.cover,
      );
    }
  }
}
