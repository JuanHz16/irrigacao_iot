import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'setup_provider.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() =>
      _SetupScreenState();
}

class _SetupScreenState
    extends State<SetupScreen> {
  final _nameController =
      TextEditingController();

  final _ipController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final setup =
        Provider.of<SetupProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setup',
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller:
                  _nameController,
              decoration:
                  const InputDecoration(
                labelText:
                    'Nome do Dispositivo',
                border:
                    OutlineInputBorder(),
              ),
              onChanged:
                  setup.setDeviceName,
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  _ipController,
              decoration:
                  const InputDecoration(
                labelText:
                    'IP do ESP32',
                border:
                    OutlineInputBorder(),
              ),
              onChanged:
                  setup.setIpAddress,
            ),

            const SizedBox(height: 20),

            SwitchListTile(
              title: const Text(
                'Dispositivo Ativo',
              ),
              value: setup.active,
              onChanged:
                  setup.toggleActive,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child:
                  ElevatedButton.icon(
                icon: const Icon(
                  Icons.save,
                ),
                label: const Text(
                  'Salvar Dispositivo',
                ),
                onPressed:
                    setup.isLoading
                        ? null
                        : () async {
                            await setup
                                .saveDevice();

                            if (!context
                                .mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(
                                    context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Dispositivo salvo com sucesso',
                                ),
                              ),
                            );
                          },
              ),
            ),

            if (setup.isLoading)
              const Padding(
                padding:
                    EdgeInsets.only(
                  top: 20,
                ),
                child:
                    CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}