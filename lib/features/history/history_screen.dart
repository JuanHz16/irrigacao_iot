import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'history_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() =>
      _HistoryScreenState();
}

class _HistoryScreenState
    extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      context
          .read<HistoryProvider>()
          .loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final history =
        Provider.of<HistoryProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Histórico',
        ),
      ),
      body: history.isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : ListView(
              padding:
                  const EdgeInsets.all(16),
              children: [
                const Text(
                  'Leituras de Umidade',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ...history.sensorReadings.map(
                  (reading) => Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.water_drop,
                      ),
                      title: Text(
                        '${(reading['moisture_value'] as num).toStringAsFixed(1)}%',
                      ),
                      subtitle: Text(
                        '${reading['reading_type']}',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Ativações da Bomba',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ...history.pumpActivations.map(
                  (activation) => Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.power,
                      ),
                      title: Text(
                        '${activation['trigger_type']}',
                      ),
                      subtitle: Text(
                        '${activation['started_at']}',
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}