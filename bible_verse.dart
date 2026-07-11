class BibleVerse {
  final String testament;
  final String book;
  final int chapter;
  final int verse;
  final String reference;
  final String text;

  const BibleVerse({
    required this.testament,
    required this.book,
    required this.chapter,
    required this.verse,
    required this.reference,
    required this.text,
  });

  factory BibleVerse.fromJson(Map<String, dynamic> json) => BibleVerse(
        testament: json['testament'] as String,
        book: json['book'] as String,
        chapter: json['chapter'] as int,
        verse: json['verse'] as int,
        reference: json['reference'] as String,
        text: json['text'] as String,
      );
}
