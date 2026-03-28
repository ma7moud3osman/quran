import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/extension/go_router_extension.dart';
import '../providers/quran_provider.dart';
import 'package:widgets_box/widgets_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:qcf_quran_plus/qcf_quran_plus.dart';

class QuranSearchScreen extends StatefulWidget {
  const QuranSearchScreen({super.key});

  @override
  State<QuranSearchScreen> createState() => _QuranSearchScreenState();
}

class _QuranSearchScreenState extends State<QuranSearchScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    final query = _searchController.text.trim();
    context.read<QuranProvider>().search(query);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuranProvider>();

    return Scaffold(
      appBar: AppBar(title: Text('search'.tr())),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'search_quran'.tr(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearch,
                ),
              ),
              onSubmitted: (_) => _onSearch(),
            ),
          ),
          Expanded(
            child: SmartScreen(
              isLoading: provider.status == LoadStatus.loading,
              isEmpty:
                  provider.status == LoadStatus.success &&
                  provider.searchResults.isEmpty,
              loadingType: LoadingType.skeleton,
              onRefresh: () async {
                _onSearch();
              },
              builder: (context) {
                if (provider.status == LoadStatus.failure) {
                  return Center(
                    child: Text(provider.errorMessage ?? 'search_error'.tr()),
                  );
                }
                return ListView.builder(
                  itemCount: provider.searchResults.length,
                  itemBuilder: (context, index) {
                    final result = provider.searchResults[index];
                    return ListTile(
                      title: Text(result.text, textAlign: TextAlign.right),
                      subtitle: Text(
                        '${result.surahName} - ${'ayah'.tr()} ${result.verseNumber}',
                      ),
                      onTap: () {
                        final page = getPageNumber(
                          result.surahNumber,
                          result.verseNumber,
                        );
                        context.pushToNamed(AppRoutes.quranMushaf, extra: page);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
