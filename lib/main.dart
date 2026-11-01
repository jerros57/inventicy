import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initialize();
  runApp(const StockFlowProApp());
}

class StockFlowProApp extends StatelessWidget {
  const StockFlowProApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primarySlate = Color(0xFF0F172A);
    const secondaryTeal = Color(0xFF0D9488);

    return MaterialApp(
      title: 'StockFlow Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primarySlate,
          primary: primarySlate,
          secondary: secondaryTeal,
          surface: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        appBarTheme: const AppBarTheme(
          backgroundColor: primarySlate,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

/// Alias para compatibilidad con implementaciones y pruebas previas
typedef InventicyApp = StockFlowProApp;
