import 'package:flutter/material.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/repo_result.dart';
import '../../data/models/bookmark_model.dart';
import '../../data/models/quran_search_result_model.dart';
import '../../data/repositories/quran_repository.dart';

class QuranProvider extends ChangeNotifier {
  final QuranRepository _repository;

  QuranProvider(this._repository);

  LoadStatus _status = LoadStatus.initial;
  LoadStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<BookmarkModel> _bookmarks = [];
  List<BookmarkModel> get bookmarks => _bookmarks;

  List<QuranSearchResultModel> _searchResults = [];
  List<QuranSearchResultModel> get searchResults => _searchResults;

  int _lastReadPage = 1;
  int get lastReadPage => _lastReadPage;

  Future<void> initBookmarks() async {
    _status = LoadStatus.loading;
    notifyListeners();

    final result = await _repository.getBookmarks();
    if (result is RepoSuccess<List<BookmarkModel>>) {
      _bookmarks = result.data;
      _status = LoadStatus.success;
    } else if (result is RepoFailure) {
      _errorMessage = (result as RepoFailure).message;
      _status = LoadStatus.failure;
    }

    final pageResult = await _repository.getLastReadPage();
    if (pageResult is RepoSuccess<int>) {
      _lastReadPage = pageResult.data;
    }

    notifyListeners();
  }

  Future<void> toggleBookmark(
    int surahNumber,
    int verseNumber,
    int pageNumber,
  ) async {
    final exists = _bookmarks.any(
      (b) => b.surahNumber == surahNumber && b.verseNumber == verseNumber,
    );
    if (exists) {
      await _repository.removeBookmark(surahNumber, verseNumber);
      _bookmarks.removeWhere(
        (b) => b.surahNumber == surahNumber && b.verseNumber == verseNumber,
      );
    } else {
      final bookmark = BookmarkModel(
        surahNumber: surahNumber,
        verseNumber: verseNumber,
        pageNumber: pageNumber,
        createdAt: DateTime.now(),
      );
      await _repository.saveBookmark(bookmark);
      _bookmarks.add(bookmark);
    }
    notifyListeners();
  }

  bool isBookmarked(int surahNumber, int verseNumber) {
    return _bookmarks.any(
      (b) => b.surahNumber == surahNumber && b.verseNumber == verseNumber,
    );
  }

  Future<void> saveLastReadPage(int pageNumber) async {
    _lastReadPage = pageNumber;
    await _repository.saveLastReadPage(pageNumber);
    notifyListeners();
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _status = LoadStatus.loading;
    notifyListeners();

    final result = await _repository.searchQuran(query);
    if (result is RepoSuccess<List<QuranSearchResultModel>>) {
      _searchResults = result.data;
      _status = LoadStatus.success;
    } else if (result is RepoFailure) {
      _errorMessage = (result as RepoFailure).message;
      _status = LoadStatus.failure;
    }

    notifyListeners();
  }
}
