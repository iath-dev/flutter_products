import 'package:flutter/material.dart';
import 'package:flutter_products/providers/providers.dart';
import 'package:flutter_products/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              CardContainer(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ChangeNotifierProvider(
                        create: (_) => LoginProvider(),
                        child: const _LoginForm(),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Log in in the application",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: true);

    return Form(
        key: provider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration("Email", Icons.email),
              onChanged: (value) => provider.email = value,
              validator: (value) {
                return RegExp('^[A-Za-z0-9+_.-]+@(.+)').hasMatch(value ?? "")
                    ? null
                    : "Invalid input";
              },
            ),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              decoration: _inputDecoration("Password", Icons.lock),
              onChanged: (value) => provider.password = value,
              validator: (value) => (value != null && value.length >= 6)
                  ? null
                  : "Invalid password",
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: provider.loading
                    ? null
                    : () async {
                        if (!provider.isValid && !provider.loading) return;

                        provider.loading = true;

                        await Future.delayed(const Duration(seconds: 5));

                        provider.loading = false;

                        Navigator.pushReplacementNamed(context, "home");
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: _loadingText(provider),
                ))
          ],
        ));
  }

  Widget _loadingText(LoginProvider provider) {
    return provider.loading
        ? SizedBox.fromSize(
            size: const Size.fromRadius(6),
            child: const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
        : const Text("Login");
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(labelText: hint, prefixIcon: Icon(icon));
  }
}
