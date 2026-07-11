import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/bible_verse.dart';
import '../models/daily_gospel.dart';
import '../models/prayer_item.dart';
import 'package:flutter/material.dart';

class AppData {
  static const Color navy = Color(0xFF071A33);
  static const Color navy2 = Color(0xFF0E2A52);
  static const Color gold = Color(0xFFD8B15A);

  static const List<DailyGospel> gospels = [
    DailyGospel(
      reference: 'Juan 15, 5',
      title: 'Permanecer en Cristo',
      explanation: 'Jesús enseña que la vida de fe da fruto cuando permanecemos unidos a Él.',
    ),
    DailyGospel(
      reference: 'Mateo 5, 14',
      title: 'Ser luz para otros',
      explanation: 'La fe se nota en las acciones diarias: respeto, servicio y esperanza.',
    ),
    DailyGospel(
      reference: 'Lucas 6, 31',
      title: 'La regla de oro',
      explanation: 'Trata a los demás como quieres ser tratado: una guía simple y poderosa.',
    ),
    DailyGospel(
      reference: 'Marcos 10, 45',
      title: 'Servir con amor',
      explanation: 'En Jesús, servir no es perder; es amar de verdad y crecer en humildad.',
    ),
  ];

  static const List<String> challenges = [
    'Haz una buena acción hoy sin esperar reconocimiento.',
    'Reza por un amigo o familiar antes de dormir.',
    'Lee un versículo bíblico antes de usar el celular.',
    'Agradece a Dios por tres cosas al terminar el día.',
    'Ofrece ayuda en casa sin que te lo pidan.',
    'Evita una queja y reemplázala por una palabra amable.',
  ];

  static const List<PrayerItem> prayers = [
    PrayerItem(
      title: 'Antes de estudiar',
      icon: Icons.school,
      text: 'Señor, ilumina mi mente, dame concentración y paz. Ayúdame a aprender con esfuerzo y humildad. Amén.',
    ),
    PrayerItem(
      title: 'Antes de dormir',
      icon: Icons.bedtime,
      text: 'Dios mío, gracias por este día. Perdona mis fallas, bendice a mi familia y dame un descanso tranquilo. Amén.',
    ),
    PrayerItem(
      title: 'Antes de un examen',
      icon: Icons.psychology_alt,
      text: 'Espíritu Santo, acompáñame en este examen. Dame calma, claridad y confianza para hacer mi mejor esfuerzo. Amén.',
    ),
    PrayerItem(
      title: 'Por un amigo',
      icon: Icons.favorite,
      text: 'Señor, bendice a mi amigo, cuida su corazón y guíalo por caminos de paz, alegría y esperanza. Amén.',
    ),
  ];

  static const String featuredVerseText = 'Todo lo puedo en Cristo que me fortalece. — Filipenses 4, 13';

  static const BibleVerse featuredVerse = BibleVerse(
    testament: 'NT',
    book: 'Filipenses',
    chapter: 4,
    verse: 13,
    reference: 'Filipenses 4, 13',
    text: 'Todo lo puedo en Cristo que me fortalece.',
  );

  static Future<List<BibleVerse>> loadBibleVerses() async {
    final raw = await rootBundle.loadString('assets/bible/sample_bible.json');
    final map = jsonDecode(raw) as Map<String, dynamic>;
    final list = (map['verses'] as List<dynamic>);
    return list
        .map((e) => BibleVerse.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();
  }
}
