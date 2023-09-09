import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _PurpleBox(),
        const _BannerIcon(),
        child,
      ],
    );
  }
}

class _PurpleBox extends StatelessWidget {
  const _PurpleBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Stack(
        children: [
          Positioned(
            top: 10,
            right: 10,
            child: _Bubble(),
          ),
          Positioned(
            top: 20,
            left: -5,
            child: _Bubble(),
          ),
          Positioned(
            top: 120,
            left: 160,
            child: _Bubble(),
          ),
          Positioned(
            bottom: 10,
            left: 25,
            child: _Bubble(),
          ),
          Positioned(
            bottom: -5,
            right: 10,
            child: _Bubble(),
          ),
        ],
      ),
    );
  }
}

class _BannerIcon extends StatelessWidget {
  const _BannerIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: Color.fromRGBO(255, 255, 255, 0.07)),
    );
  }
}
