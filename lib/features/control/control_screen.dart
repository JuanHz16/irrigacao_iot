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
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Text(
              control.pumpOn
                  ? 'Bomba Ligada'
                  : 'Bomba Desligada',
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                control.togglePump();
              },
              child: const Text(
                'Alternar Bomba',
              ),
            ),
          ],
        ),
      ),
    );
  }
}