import 'package:flutter/material.dart';
import 'features/control/control_provider.dart';
import 'features/config/config_provider.dart';
import 'features/setup/setup_provider.dart';
import 'package:provider/provider.dart';
import 'features/history/history_provider.dart';
import 'features/auth/auth_provider.dart';
import 'features/auth/login_screen.dart';
import 'features/dashboard/dashboard_provider.dart';
import 'features/reports/reports_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ConfigProvider()),
        ChangeNotifierProvider(create: (_) => ReportsProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => SetupProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProxyProvider<DashboardProvider, ControlProvider>(
          create: (context) =>
              ControlProvider(context.read<DashboardProvider>()),
          update: (context, dashboard, previous) =>
              previous ?? ControlProvider(dashboard),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Irrigação IoT',
      home: const LoginScreen(),
    );
  }
}
