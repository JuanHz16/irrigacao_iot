import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'control_provider.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final control =
        Provider.of<ControlProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Controle',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: SwitchListTile(
                title: const Text(
                  'Bomba de Água',
                ),
                subtitle: Text(
                  control.dashboard.pumpOn
                      ? 'Ligada'
                      : 'Desligada',
                ),
                value:
                    control.dashboard.pumpOn,
                onChanged: (_) async {
                  await control
                      .togglePump();
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.water_drop,
                ),
                label: const Text(
                  'Leitura Rápida',
                ),
                onPressed:
                    control.isLoading
                        ? null
                        : () async {
                            final moisture =
                                await control
                                    .quickRead();

                            if (!context
                                .mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(
                                    context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Umidade: ${moisture.toStringAsFixed(1)}%',
                                ),
                              ),
                            );
                          },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.power_off,
                ),
                label: const Text(
                  'Desligar Sistema',
                ),
                onPressed:
                    control.isLoading
                        ? null
                        : () async {
                            await control
                                .disableSystem();

                            if (!context
                                .mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(
                                    context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Sistema desligado',
                                ),
                              ),
                            );
                          },
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: Icon(
                  control.sensorEnabled
                      ? Icons.sensors
                      : Icons.sensors_off,
                ),
                title: const Text(
                  'Sensor',
                ),
                subtitle: Text(
                  control.sensorEnabled
                      ? 'Ativo'
                      : 'Desativado',
                ),
              ),
            ),

            if (control.isLoading)
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