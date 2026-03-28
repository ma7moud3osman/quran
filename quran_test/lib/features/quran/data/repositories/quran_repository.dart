import '../../../../core/utils/repo_result.dart';
import '../data_source/quran_local_data_source.dart';
import '../models/bookmark_model.dart';
import '../models/quran_search_result_model.dart';
import 'package:qcf_quran_plus/qcf_quran_plus.dart' as qcf;

class QuranRepository extends BaseRepository {
  final QuranLocalDataSource _localDataSource;

  QuranRepository(this._localDataSource);

  Future<RepoResult<List<BookmarkModel>>> getBookmarks() {
    return execute(() async {
      return _localDataSource.getBookmarks();
    });
  }

  Future<RepoResult<void>> saveBookmark(BookmarkModel bookmark) {
    return execute(() async {
      await _localDataSource.saveBookmark(bookmark);
    });
  }

  Future<RepoResult<void>> removeBookmark(int surahNumber, int verseNumber) {
    return execute(() async {
      await _localDataSource.removeBookmark(surahNumber, verseNumber);
    });
  }

  Future<RepoResult<int>> getLastReadPage() {
    return execute(() async {
      return _localDataSource.getLastReadPage();
    });
  }

  Future<RepoResult<void>> saveLastReadPage(int pageNumber) {
    return execute(() async {
      await _localDataSource.saveLastReadPage(pageNumber);
    });
  }

  Future<RepoResult<List<QuranSearchResultModel>>> searchQuran(String query) {
    return execute(() async {
      final results = qcf.searchWords(query);
      final List occurrences = results['result'] ?? [];
      return occurrences.map((e) {
        return QuranSearchResultModel(
          surahNumber: e['sora'] as int,
          surahName: qcf.getSurahNameArabic(e['sora'] as int),
          verseNumber: e['aya_no'] as int,
          text: e['text'] as String,
        );
      }).toList();
    });
  }
}
