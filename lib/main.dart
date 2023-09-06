import 'package:flutter/material.dart';
import 'package:flutter_products/providers/login_provider.dart';
import 'package:flutter_products/router/router.dart';
import 'package:flutter_products/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [ChangeNotifierProvider(create: (_) => LoginProvider())],
    //   child: const MainApp(),
    // );
    return const MainApp();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRoutes.initialRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      routes: AppRoutes.getAppRoutes(),
    );
  }
}
