import 'package:qcf_quran_plus/qcf_quran_plus.dart' as qcf;

class QuranMetadataService {
  String getSurahNameArabic(int surahNumber) {
    return qcf.getSurahNameArabic(surahNumber);
  }

  int getPageNumber(int surahNumber, int verseNumber) {
    return qcf.getPageNumber(surahNumber, verseNumber);
  }

  int getTotalVerses(int surahNumber) {
    return qcf.getVerseCount(surahNumber);
  }
}
