import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repositories/u_hub_repository.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    Provider<UHubRepository>(
      create: (_) => MockUHubRepository(),
      child: const UHubApp(),
    ),
  );
}

class UHubApp extends StatelessWidget {
  const UHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF102A43);
    const teal = Color(0xFF0E9384);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'U-Hub',
      locale: const Locale('ar'),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: teal, primary: navy),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        fontFamily: 'Arial',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        ),
      ),
      home: const Directionality(textDirection: TextDirection.rtl, child: HomeScreen()),
    );
  }
}
