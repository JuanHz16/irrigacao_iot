import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'reports_provider.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() =>
      _ReportsScreenState();
}

class _ReportsScreenState
    extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<ReportsProvider>()
          .loadReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reports =
        Provider.of<ReportsProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Relatórios',
        ),
      ),
      body: reports.isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : Padding(
              padding:
                  const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.analytics,
                      ),
                      title: const Text(
                        'Média de Umidade',
                      ),
                      subtitle: Text(
                        '${reports.averageMoisture.toStringAsFixed(1)}%',
                      ),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.arrow_upward,
                      ),
                      title: const Text(
                        'Maior Umidade',
                      ),
                      subtitle: Text(
                        '${reports.maxMoisture.toStringAsFixed(1)}%',
                      ),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.arrow_downward,
                      ),
                      title: const Text(
                        'Menor Umidade',
                      ),
                      subtitle: Text(
                        '${reports.minMoisture.toStringAsFixed(1)}%',
                      ),
                    ),
                  ),

                  Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.water,
                      ),
                      title: const Text(
                        'Acionamentos da Bomba',
                      ),
                      subtitle: Text(
                        '${reports.pumpActivations}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}