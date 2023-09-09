import 'package:flutter/material.dart';
import 'package:flutter_products/screen/screen.dart';
import 'package:flutter_products/services/services.dart';
import 'package:provider/provider.dart';

class CheckScreen extends StatelessWidget {
  const CheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<AuthService>(context);

    return FutureBuilder(
        future: service.readToken(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SplashScreen();
          }
          if (snapshot.data!.isEmpty) {
            Future.microtask(() => Navigator.pushNamed(context, "login"));
          }

          return const SplashScreen();
        });
  }
}
