import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bookmark_model.dart';

class QuranLocalDataSource {
  static const String bookmarksBoxName = 'bookmarks';
  static const String lastReadPageKey = 'last_read_page';

  final SharedPreferences _prefs;
  late final Box<Map> _bookmarksBox;

  QuranLocalDataSource(this._prefs) {
    _bookmarksBox = Hive.box<Map>(bookmarksBoxName);
  }

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<Map>(bookmarksBoxName);
  }

  Future<void> saveBookmark(BookmarkModel bookmark) async {
    final key = '${bookmark.surahNumber}_${bookmark.verseNumber}';
    await _bookmarksBox.put(key, bookmark.toJson());
  }

  Future<void> removeBookmark(int surahNumber, int verseNumber) async {
    final key = '${surahNumber}_$verseNumber';
    await _bookmarksBox.delete(key);
  }

  List<BookmarkModel> getBookmarks() {
    return _bookmarksBox.values.map((e) {
      final map = e.cast<String, dynamic>();
      return BookmarkModel.fromJson(map);
    }).toList();
  }

  Future<void> saveLastReadPage(int pageNumber) async {
    await _prefs.setInt(lastReadPageKey, pageNumber);
  }

  int getLastReadPage() {
    return _prefs.getInt(lastReadPageKey) ?? 1;
  }
}
