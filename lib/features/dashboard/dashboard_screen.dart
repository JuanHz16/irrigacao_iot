import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/widgets/moisture_gauge.dart';
import '../../shared/widgets/pump_status_card.dart';
import 'dashboard_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<DashboardProvider>()
          .loadDashboardData();
    });
  }

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

            if (dashboard.lastReadings
                .isEmpty)
              const Card(
                child: ListTile(
                  title: Text(
                    'Nenhuma leitura encontrada',
                  ),
                ),
              ),

            ...dashboard.lastReadings.map(
              (reading) => Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.water_drop,
                  ),
                  title: Text(
                    '${reading.toStringAsFixed(1)}%',
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