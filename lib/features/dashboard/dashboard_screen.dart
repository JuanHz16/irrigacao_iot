import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/widgets/pump_status_card.dart';
import '../../shared/widgets/moisture_gauge.dart';
import 'dashboard_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboard =
        Provider.of<DashboardProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [
            PumpStatusCard(
              pumpOn: dashboard.pumpOn,
            ),

            const SizedBox(height: 16),

            MoistureGauge(
              moisture:
                  dashboard.moistureValue,
            ),

            const SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.sensors,
                ),
                title: const Text(
                  'Sensor',
                ),
                subtitle: Text(
                  dashboard.sensorActive
                      ? 'Ativo'
                      : 'Desativado',
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.loop,
                ),
                title: const Text(
                  'Modo Contínuo',
                ),
                subtitle: Text(
                  dashboard.continuousMode
                      ? 'Ativado'
                      : 'Desativado',
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Últimas Leituras',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ...dashboard.lastReadings.map(
              (reading) => Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.water_drop,
                  ),
                  title: Text(
                    '$reading%',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}