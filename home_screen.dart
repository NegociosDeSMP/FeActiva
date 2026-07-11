import 'dart:math';
import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../models/daily_gospel.dart';
import '../services/audio_service.dart';
import '../widgets/feactiva_cards.dart';
import 'bible_screen.dart';
import 'prayers_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final AudioService audioService;
  const HomeScreen({super.key, required this.audioService});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _gospelIndex = 0;
  int _challengeIndex = 0;
  int _bottomIndex = 0;

  List<Widget> get _pages => [
    _HomeContent(
      gospel: AppData.gospels[_gospelIndex],
      challenge: AppData.challenges[_challengeIndex],
      onNextGospel: () => setState(() => _gospelIndex = (_gospelIndex + 1) % AppData.gospels.length),
      onNextChallenge: () => setState(() => _challengeIndex = Random().nextInt(AppData.challenges.length)),
      onPlayMusic: widget.audioService.toggleBackgroundMusic,
      onOpenBible: () => setState(() => _bottomIndex = 1),
      onOpenPrayers: () => setState(() => _bottomIndex = 2),
    ),
    BibleScreen(),
    PrayersScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _bottomIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _bottomIndex,
        onDestinationSelected: (value) => setState(() => _bottomIndex = value),
        backgroundColor: const Color(0xFF081A33),
        indicatorColor: const Color(0xFFD8B15A).withOpacity(.22),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'Biblia'),
          NavigationDestination(icon: Icon(Icons.volunteer_activism_outlined), label: 'Oración'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Ajustes'),
        ],
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  final DailyGospel gospel;
  final String challenge;
  final VoidCallback onNextGospel;
  final VoidCallback onNextChallenge;
  final VoidCallback onPlayMusic;
  final VoidCallback onOpenBible;
  final VoidCallback onOpenPrayers;

  const _HomeContent({
    required this.gospel,
    required this.challenge,
    required this.onNextGospel,
    required this.onNextChallenge,
    required this.onPlayMusic,
    required this.onOpenBible,
    required this.onOpenPrayers,
  });

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(colors: [Color(0xFF10284C), Color(0xFF173A6C)]),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0x22D8B15A),
                        child: Icon(Icons.auto_awesome, color: Color(0xFFD8B15A), size: 34),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('FeActiva', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                            SizedBox(height: 4),
                            Text('Evangelio, reto y oración para jóvenes', style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SectionTitle(title: 'Evangelio del día', actionText: 'Cambiar', onTap: widget.onNextGospel),
              const SizedBox(height: 10),
              GospelCard(gospel: widget.gospel, onTap: widget.onNextGospel),
              const SizedBox(height: 18),
              SectionTitle(title: 'Reto espiritual', actionText: 'Nuevo reto', onTap: widget.onNextChallenge),
              const SizedBox(height: 10),
              ChallengeCard(challenge: widget.challenge, onTap: widget.onNextChallenge),
              const SizedBox(height: 18),
              const SectionTitle(title: 'Oraciones rápidas'),
              const SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.35,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: AppData.prayers.map(
                  (p) => PrayerQuickCard(prayer: p, onTap: widget.onOpenPrayers),
                ).toList(),
              ),
              const SizedBox(height: 18),
              const SectionTitle(title: 'Accesos rápidos'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _Shortcut(
                      icon: Icons.menu_book_rounded,
                      title: 'Biblia',
                      subtitle: 'Buscar versículos',
                      onTap: widget.onOpenBible,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _Shortcut(
                      icon: Icons.music_note_rounded,
                      title: 'Música',
                      subtitle: 'Fondo católico',
                      onTap: widget.onPlayMusic,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Versículo destacado', style: TextStyle(color: Color(0xFFD8B15A), fontWeight: FontWeight.w700)),
                      SizedBox(height: 8),
                      Text(AppData.featuredVerseText, style: TextStyle(height: 1.5)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Shortcut extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _Shortcut({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFD8B15A).withOpacity(.15),
                ),
                child: Icon(icon, color: const Color(0xFFD8B15A)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 3),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
