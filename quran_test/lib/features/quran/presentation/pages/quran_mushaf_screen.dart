import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qcf_quran_plus/qcf_quran_plus.dart';
import 'package:widgets_box/widgets_box.dart';

import '../../../../core/extension/go_router_extension.dart';
import '../../../../core/theme/app_colors.dart';
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
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage;
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

  Widget _buildTopBar(BuildContext context, bool isDark) {
    final hizbText = getCurrentHizbTextForPage(_currentPage);
    final textColor = isDark ? Colors.white : Colors.black87;
    final chipBackground = isDark
        ? Colors.white12
        : Colors.grey.withValues(alpha: 0.1);

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 12),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Center: Hizb pill
          if (hizbText.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              decoration: BoxDecoration(
                color: chipBackground,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                hizbText,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor.withValues(alpha: 0.8),
                ),
              ),
            ),

          // Right: back navigation arrow
          // In RTL, arrow_back points RIGHT (->).
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_rounded,
                color: textColor.withValues(alpha: 0.8),
                size: 26,
              ),
              onPressed: () => context.popRoute(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuranProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.quranBackground;

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
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SmartScreen(
          isLoading: provider.status == LoadStatus.loading,
          isEmpty: false,
          loadingType: LoadingType.skeleton,
          onRefresh: () async {
            await provider.initBookmarks();
          },
          builder: (context) => QuranPageView(
            pageController: _pageController,
            isDarkMode: isDark,
            isTajweed: false,
            pageBackgroundColor: backgroundColor,
            highlights: highlights,
            topBar: _buildTopBar(context, isDark),
            onPageChanged: (page) {
              setState(() => _currentPage = page);
              provider.saveLastReadPage(page);
            },
            onLongPress: (surahNumber, verseNumber, details) {
              final page = getPageNumber(surahNumber, verseNumber);
              provider.toggleBookmark(surahNumber, verseNumber, page);
            },
          ),
        ),
      ),
    );
  }
}
