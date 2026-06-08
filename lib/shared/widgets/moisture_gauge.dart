import 'package:flutter/material.dart';

class MoistureGauge
    extends StatelessWidget {
  final double moisture;

  const MoistureGauge({
    super.key,
    required this.moisture,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Umidade Atual',
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 10),

            LinearProgressIndicator(
              value: moisture / 100,
            ),

            const SizedBox(height: 10),

            Text(
              '${moisture.toStringAsFixed(1)}%',
              style: const TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}