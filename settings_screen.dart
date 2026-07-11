import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF061227), Color(0xFF071A33)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          children: const [
            Text('Ajustes', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            SizedBox(height: 14),
            _InfoTile(
              icon: Icons.dark_mode,
              title: 'Modo oscuro',
              subtitle: 'Activado por defecto.',
            ),
            _InfoTile(
              icon: Icons.music_note,
              title: 'Música de fondo',
              subtitle: 'El MP3 está incluido como asset local.',
            ),
            _InfoTile(
              icon: Icons.wifi_off,
              title: 'Offline',
              subtitle: 'La Biblia completa puede cargarse desde JSON o SQLite.',
            ),
            _InfoTile(
              icon: Icons.security,
              title: 'Código limpio',
              subtitle: 'Estructura lista para Android Studio y APK.',
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFD8B15A)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white70)),
      ),
    );
  }
}
