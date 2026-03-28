import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qcf_quran_plus/qcf_quran_plus.dart';
import 'package:widgets_box/widgets_box.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/utils/enums.dart';
import '../providers/quran_provider.dart';

class QuranMushafScreen extends StatefulWidget {
  final int initialPage;

  const QuranMushafScreen({super.key, this.initialPage = 1});

  @override
  State<QuranMushafScreen> createState() => _QuranMushafScreenState();
}

class _QuranMushafScreenState extends State<QuranMushafScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage - 1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuranProvider>().initBookmarks();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuranProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final highlights = provider.bookmarks
        .map(
          (b) => HighlightVerse(
            surah: b.surahNumber,
            verseNumber: b.verseNumber,
            page: b.pageNumber,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('quran_kareem'.tr())),
      body: SmartScreen(
        isLoading: provider.status == LoadStatus.loading,
        isEmpty: false,
        loadingType: LoadingType.skeleton,
        onRefresh: () async {
          await provider.initBookmarks();
        },
        builder: (context) => QuranPageView(
          pageController: _pageController,
          isDarkMode: isDark,
          isTajweed: true,
          highlights: highlights,
          onPageChanged: (page) {
            provider.saveLastReadPage(page);
          },
          onLongPress: (surahNumber, verseNumber, details) {
            final page = getPageNumber(surahNumber, verseNumber);
            provider.toggleBookmark(surahNumber, verseNumber, page);
          },
        ),
      ),
    );
  }
}
