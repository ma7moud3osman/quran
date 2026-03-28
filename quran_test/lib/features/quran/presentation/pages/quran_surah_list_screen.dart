import 'package:flutter/material.dart';
import 'package:qcf_quran_plus/qcf_quran_plus.dart';

class QuranSurahListScreen extends StatelessWidget {
  final int surahNumber;

  const QuranSurahListScreen({super.key, required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(getSurahNameArabic(surahNumber))),
      body: QuranSurahListView(
        surahNumber: surahNumber,
        isTajweed: false,
        highlights: const [],
      ),
    );
  }
}
