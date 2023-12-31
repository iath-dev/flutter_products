import 'package:flutter/material.dart';
import 'package:flutter_products/models/models.dart';
import 'package:flutter_products/screen/screen.dart';

class AppRoutes {
  static const String initialRoute = "login";

  static final mainRoutes = <NavItem>[
    NavItem(
      route: "login",
      screen: const LoginScreen(),
    ),
    NavItem(
      route: "register",
      screen: const RegisterScreen(),
    ),
    ...menuOptions
  ];

  static final menuOptions = <NavItem>[
    NavItem(
        route: "home",
        screen: const HomeScreen(),
        label: "Home",
        icon: Icons.home),
    NavItem(
        route: "edit",
        screen: const EditScreen(),
        label: "Edit",
        icon: Icons.edit_square),
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
