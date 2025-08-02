import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/onboarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const SauteAndSimmerApp());
}

class SauteAndSimmerApp extends StatelessWidget {
  const SauteAndSimmerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sauté & Simmer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ).copyWith(
          secondary: const Color(0xFF8B0F0F),
        ),
        fontFamily: 'Archivo', // Using Archivo font
        scaffoldBackgroundColor: const Color(0xFFFFF1F1),
      ),
      home: const OnboardingScreen(),
    );
  }
}