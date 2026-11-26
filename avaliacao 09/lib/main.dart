import 'package:flutter/material.dart';
import 'screens/passagens_screen.dart';

void main() {
  runApp(const CearaBusApp());
}

class CearaBusApp extends StatelessWidget {
  const CearaBusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CearáBus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const PassagensScreen(),
    );
  }
}