import 'package:flutter/material.dart';
import 'package:irrigacao_iot/features/navigation/main_navigation_screen.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final auth =
        Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final success = await auth.login(
      email: _emailController.text.trim(),
      password:
          _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const MainNavigationScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Email ou senha inválidos',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth =
        Provider.of<AuthProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.water_drop,
                size: 100,
              ),

              const SizedBox(height: 30),

              TextFormField(
                controller:
                    _emailController,
                decoration:
                    const InputDecoration(
                  labelText: 'Email',
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Informe o email';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller:
                    _passwordController,
                obscureText: true,
                decoration:
                    const InputDecoration(
                  labelText: 'Senha',
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Informe a senha';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      auth.isLoading
                          ? null
                          : _login,
                  child: auth.isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Entrar',
                        ),
                ),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const RegisterScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Criar conta',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}