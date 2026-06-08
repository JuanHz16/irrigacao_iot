import 'package:flutter/material.dart';
import 'core/database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final db = DatabaseHelper.instance;

    await db.database;

    print('✅ Banco criado com sucesso!');
  } catch (e) {
    print('❌ Erro ao criar banco: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Teste'),
        ),
      ),
    );
  }
}