import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config_provider.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() =>
      _ConfigScreenState();
}

class _ConfigScreenState
    extends State<ConfigScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<ConfigProvider>()
          .loadConfig();
    });
  }

  @override
  Widget build(BuildContext context) {
    final config =
        Provider.of<ConfigProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuração',
        ),
      ),
      body: config.isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding:
                  const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      title: const Text(
                        'Intervalo de Leitura',
                      ),
                      subtitle: Text(
                        '${config.intervalHours} horas',
                      ),
                    ),
                  ),

                  Slider(
                    value: config.intervalHours
                        .toDouble(),
                    min: 1,
                    max: 12,
                    divisions: 11,
                    label:
                        '${config.intervalHours}',
                    onChanged: (value) {
                      config.setInterval(
                        value.toInt(),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  Card(
                    child: ListTile(
                      title: const Text(
                        'Limite de Umidade',
                      ),
                      subtitle: Text(
                        '${config.moistureThreshold.toStringAsFixed(0)}%',
                      ),
                    ),
                  ),

                  Slider(
                    value:
                        config.moistureThreshold,
                    min: 10,
                    max: 100,
                    divisions: 18,
                    label:
                        '${config.moistureThreshold.toStringAsFixed(0)}%',
                    onChanged: (value) {
                      config.setThreshold(
                        value,
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  Card(
                    child: SwitchListTile(
                      title: const Text(
                        'Sensor Ativo',
                      ),
                      value:
                          config.sensorEnabled,
                      onChanged: (value) {
                        config.toggleSensor(
                          value,
                        );
                      },
                    ),
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
                        'Salvar Configuração',
                      ),
                      onPressed: () async {
                        await config
                            .saveConfig();

                        if (!context.mounted) {
                          return;
                        }

                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Configuração salva com sucesso',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}