import 'package:flutter/material.dart';
import 'data/app_data.dart';
import 'screens/home_screen.dart';
import 'services/audio_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FeActivaApp());
}

class FeActivaApp extends StatefulWidget {
  const FeActivaApp({super.key});

  @override
  State<FeActivaApp> createState() => _FeActivaAppState();
}

class _FeActivaAppState extends State<FeActivaApp> {
  final AudioService _audioService = AudioService();

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const gold = AppData.gold;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FeActiva',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
        ).copyWith(
          primary: gold,
          secondary: const Color(0xFF7DB7FF),
          surface: AppData.navy2,
          onPrimary: Colors.black,
        ),
        scaffoldBackgroundColor: AppData.navy,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF10284C),
          elevation: 8,
          shadowColor: Colors.black54,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
          headlineMedium: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          titleLarge: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: HomeScreen(audioService: _audioService),
    );
  }
}
