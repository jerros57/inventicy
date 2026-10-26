import 'package:flutter/material.dart';

void main() {
  runApp(const InventicyApp());
}

class InventicyApp extends StatelessWidget {
  const InventicyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventicy MVP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('Inventicy - Setup Inicial')),
      ),
    );
  }
}
