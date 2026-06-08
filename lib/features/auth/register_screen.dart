import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController =
      TextEditingController();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  final _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final auth =
        Provider.of<AuthProvider>(
      context,
      listen: false,
    );

    final success = await auth.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password:
          _passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Cadastro realizado com sucesso!',
          ),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Email já cadastrado.',
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
          'Cadastro',
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),

              const Icon(
                Icons.person_add,
                size: 100,
              ),

              const SizedBox(height: 30),

              TextFormField(
                controller:
                    _nameController,
                decoration:
                    const InputDecoration(
                  labelText: 'Nome',
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Informe seu nome';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller:
                    _emailController,
                keyboardType:
                    TextInputType.emailAddress,
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

                  if (!value.contains('@')) {
                    return 'Email inválido';
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

                  if (value.length < 6) {
                    return 'Mínimo 6 caracteres';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 15),

              TextFormField(
                controller:
                    _confirmPasswordController,
                obscureText: true,
                decoration:
                    const InputDecoration(
                  labelText:
                      'Confirmar Senha',
                  border:
                      OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value !=
                      _passwordController
                          .text) {
                    return 'As senhas não coincidem';
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
                          : _register,
                  child: auth.isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Cadastrar',
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}