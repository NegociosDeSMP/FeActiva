import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/app_data.dart';
import '../models/bible_verse.dart';
import '../widgets/feactiva_cards.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({super.key});

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

enum TestamentFilter { all, old, newTestament }

class _BibleScreenState extends State<BibleScreen> {
  final TextEditingController _controller = TextEditingController();
  TestamentFilter _filter = TestamentFilter.all;
  List<BibleVerse> _all = [];
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final verses = await AppData.loadBibleVerses();
    if (!mounted) return;
    setState(() => _all = verses);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<BibleVerse> get _results {
    return _all.where((v) {
      final q = _query.isEmpty ||
          v.reference.toLowerCase().contains(_query) ||
          v.book.toLowerCase().contains(_query) ||
          v.text.toLowerCase().contains(_query);
      final f = switch (_filter) {
        TestamentFilter.all => true,
        TestamentFilter.old => v.testament == 'AT',
        TestamentFilter.newTestament => v.testament == 'NT',
      };
      return q && f;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppData.navy, Color(0xFF081A33)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text('Biblia', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
                decoration: InputDecoration(
                  hintText: 'Buscar libro, capítulo o palabra...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color(0xFF10284C),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ChoiceChip(label: const Text('Todo'), selected: _filter == TestamentFilter.all, onSelected: (_) => setState(() => _filter = TestamentFilter.all)),
                  ChoiceChip(label: const Text('Antiguo'), selected: _filter == TestamentFilter.old, onSelected: (_) => setState(() => _filter = TestamentFilter.old)),
                  ChoiceChip(label: const Text('Nuevo'), selected: _filter == TestamentFilter.newTestament, onSelected: (_) => setState(() => _filter = TestamentFilter.newTestament)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _all.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : _results.isEmpty
                      ? const Center(child: Text('No se encontraron resultados', style: TextStyle(color: Colors.white70)))
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
                          itemCount: _results.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (_, i) {
                            final v = _results[i];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(child: Text(v.reference, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800))),
                                        Text(v.testament, style: const TextStyle(color: Color(0xFFD8B15A), fontWeight: FontWeight.w700)),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(v.text, style: const TextStyle(height: 1.45, color: Colors.white70)),
                                    const SizedBox(height: 12),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton.icon(
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(text: v.text));
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Versículo copiado')));
                                        },
                                        icon: const Icon(Icons.copy),
                                        label: const Text('Copiar'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
