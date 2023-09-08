import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.pushNamed(context, "edit"),
      title: const Text("Title"),
      subtitle: const Text(
        "Est non adipisicing reprehenderit adipisicing mollit amet sint ipsum sint eu enim esse et magna.",
        overflow: TextOverflow.ellipsis,
      ),
      leading: const _ItemImage(),
      trailing: const Text(
        "80.0 COP",
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}

class _ItemImage extends StatelessWidget {
  const _ItemImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: FadeInImage.assetNetwork(
        placeholder: "assets/img_loading.gif",
        image: "https://fakeimg.pl/600x400",
        fit: BoxFit.cover,
      ),
    );
  }
}
