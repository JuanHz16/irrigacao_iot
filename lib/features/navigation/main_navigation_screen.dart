import 'package:flutter/material.dart';
import '../config/config_screen.dart';
import '../setup/setup_screen.dart';
import '../control/control_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../history/history_screen.dart';
import '../reports/reports_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const DashboardScreen(),
    const ControlScreen(),
    const ConfigScreen(),
    const HistoryScreen(),
    const SetupScreen(),
    const ReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.blue,

        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings_remote),
            label: 'Controle',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),

          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.router), label: 'Setup'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Relatórios',
          ),
        ],
      ),
    );
  }
}
