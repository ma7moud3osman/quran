import 'package:flutter/material.dart';
import 'package:qcf_quran_plus/qcf_quran_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/extension/go_router_extension.dart';
import '../../../../core/routes/routes_name.dart';

class SurahIndexScreen extends StatelessWidget {
  const SurahIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('index'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.pushToNamed(AppRoutes.quranSearch),
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: totalSurahCount,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final surahNumber = index + 1;
          final name = getSurahNameArabic(surahNumber);
          return ListTile(
            leading: CircleAvatar(child: Text(surahNumber.toString())),
            title: Text(name),
            onTap: () {
              context.pushToNamed(AppRoutes.quranSurahList, extra: surahNumber);
            },
          );
        },
      ),
    );
  }
}
