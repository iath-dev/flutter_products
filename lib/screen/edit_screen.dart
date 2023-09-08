import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save),
      ),
      body: const CustomScrollView(
        slivers: [_EditAppBar(), _EditForm()],
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
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(label: Text("Name")),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    label: Text("Price"), suffixText: "COP"),
              ),
              const SizedBox(
                height: 12,
              ),
              SwitchListTile(
                value: true,
                onChanged: (value) {},
                dense: true,
                title: const Text("In Stock"),
              )
            ],
          ),
        )
      ]),
    );
  }
}

class _EditAppBar extends StatelessWidget {
  const _EditAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      expandedHeight: 300,
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt))
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: const Text("Edit"),
        background: Container(
          color: Colors.white,
          child: const _BackgroundImage(),
        ),
      ),
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      child: FadeInImage.assetNetwork(
        placeholder: "assets/img_loading.gif",
        image: "https://fakeimg.pl/600x400",
        fit: BoxFit.cover,
      ),
    );
  }
}
