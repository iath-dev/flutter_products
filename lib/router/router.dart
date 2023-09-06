import 'package:flutter/material.dart';
import 'package:flutter_products/models/models.dart';
import 'package:flutter_products/screen/screen.dart';

class AppRoutes {
  static const String initialRoute = "login";

  static final mainRoutes = <NavItem>[
    NavItem(
        route: "login",
        screen: const LoginScreen(),
        label: "Login",
        icon: Icons.settings),
    ...menuOptions
  ];

  static final menuOptions = <NavItem>[
    NavItem(
        route: "home",
        screen: const HomeScreen(),
        label: "Home",
        icon: Icons.home),
  ];

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    for (final option in mainRoutes) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const LoginScreen());
  }
}
