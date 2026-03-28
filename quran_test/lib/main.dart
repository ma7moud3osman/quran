import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qcf_quran_plus/qcf_quran_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'features/onboarding/onboarding_injection.dart';
import 'features/quran/quran_injection.dart';
import 'features/quran/data/data_source/quran_local_data_source.dart';

final sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  await QuranLocalDataSource.init();
  
  initOnboardingInjection();
  initQuranInjection();

  runApp(const MyApp());

  // Load fonts in background after app starts
  QcfFontLoader.setupFontsAtStartup(
    onProgress: (progress) {
      debugPrint('Font loading progress: $progress');
    },
  ).catchError((e) {
    debugPrint('Error loading fonts: $e');
  });
}
