import 'package:equatable/equatable.dart';

class BookmarkModel extends Equatable {
  final int surahNumber;
  final int verseNumber;
  final int pageNumber;
  final DateTime createdAt;

  const BookmarkModel({
    required this.surahNumber,
    required this.verseNumber,
    required this.pageNumber,
    required this.createdAt,
  });

  factory BookmarkModel.fake() => BookmarkModel(
    surahNumber: 1,
    verseNumber: 1,
    pageNumber: 1,
    createdAt: DateTime.now(),
  );

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
    surahNumber: json['surahNumber'] as int,
    verseNumber: json['verseNumber'] as int,
    pageNumber: json['pageNumber'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'surahNumber': surahNumber,
    'verseNumber': verseNumber,
    'pageNumber': pageNumber,
    'createdAt': createdAt.toIso8601String(),
  };

  @override
  List<Object?> get props => [surahNumber, verseNumber, pageNumber, createdAt];
}
