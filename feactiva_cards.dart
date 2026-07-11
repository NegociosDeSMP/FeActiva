import 'package:flutter/material.dart';
import '../models/bible_verse.dart';
import '../models/daily_gospel.dart';
import '../models/prayer_item.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onTap;

  const SectionTitle({super.key, required this.title, this.actionText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800))),
        if (actionText != null && onTap != null)
          TextButton(onPressed: onTap, child: Text(actionText!)),
      ],
    );
  }
}

class GospelCard extends StatelessWidget {
  final DailyGospel gospel;
  final VoidCallback onTap;

  const GospelCard({super.key, required this.gospel, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(gospel.reference, style: const TextStyle(color: Color(0xFFD8B15A), fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(gospel.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              Text(gospel.explanation, style: const TextStyle(height: 1.45, color: Colors.white70)),
            ],
          ),
        ),
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final String challenge;
  final VoidCallback onTap;

  const ChallengeCard({super.key, required this.challenge, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: const Color(0xFFD8B15A).withOpacity(.15),
                ),
                child: const Icon(Icons.flag_circle, color: Color(0xFFD8B15A)),
              ),
              const SizedBox(width: 14),
              Expanded(child: Text(challenge, style: const TextStyle(fontSize: 16, height: 1.35))),
            ],
          ),
        ),
      ),
    );
  }
}

class PrayerQuickCard extends StatelessWidget {
  final PrayerItem prayer;
  final VoidCallback onTap;

  const PrayerQuickCard({super.key, required this.prayer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(prayer.icon, color: const Color(0xFFD8B15A), size: 30),
              const SizedBox(height: 10),
              Text(prayer.title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}

class BibleVerseCard extends StatelessWidget {
  final BibleVerse verse;

  const BibleVerseCard({super.key, required this.verse});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(verse.reference, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800))),
                Text(verse.testament, style: const TextStyle(color: Color(0xFFD8B15A), fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 10),
            Text(verse.text, style: const TextStyle(height: 1.45, color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}
