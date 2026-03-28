import 'package:equatable/equatable.dart';

class QuranSearchResultModel extends Equatable {
  final int surahNumber;
  final String surahName;
  final int verseNumber;
  final String text;

  const QuranSearchResultModel({
    required this.surahNumber,
    required this.surahName,
    required this.verseNumber,
    required this.text,
  });

  factory QuranSearchResultModel.fake() => const QuranSearchResultModel(
    surahNumber: 1,
    surahName: 'Al-Fatihah',
    verseNumber: 1,
    text: 'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
  );

  factory QuranSearchResultModel.fromJson(Map<String, dynamic> json) =>
      QuranSearchResultModel(
        surahNumber: json['surahNumber'] as int,
        surahName: json['surahName'] as String,
        verseNumber: json['verseNumber'] as int,
        text: json['text'] as String,
      );

  Map<String, dynamic> toJson() => {
    'surahNumber': surahNumber,
    'surahName': surahName,
    'verseNumber': verseNumber,
    'text': text,
  };

  @override
  List<Object?> get props => [surahNumber, surahName, verseNumber, text];
}
