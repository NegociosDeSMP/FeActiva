import 'package:flutter/material.dart';
import '../data/app_data.dart';

class PrayersScreen extends StatelessWidget {
  const PrayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppData.navy, Color(0xFF081A33), Color(0xFF071423)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          children: [
            const Text('Oraciones', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('Oraciones cortas para el día a día.', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 16),
            ...AppData.prayers.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Card(
                  child: ExpansionTile(
                    leading: Icon(p.icon, color: const Color(0xFFD8B15A)),
                    title: Text(p.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(p.text, style: const TextStyle(height: 1.5, color: Colors.white70)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
