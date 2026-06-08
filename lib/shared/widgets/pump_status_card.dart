import 'package:flutter/material.dart';

class PumpStatusCard
    extends StatelessWidget {
  final bool pumpOn;

  const PumpStatusCard({
    super.key,
    required this.pumpOn,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          pumpOn
              ? Icons.power
              : Icons.power_off,
        ),
        title: const Text(
          'Status da Bomba',
        ),
        subtitle: Text(
          pumpOn
              ? 'Ligada'
              : 'Desligada',
        ),
      ),
    );
  }
}