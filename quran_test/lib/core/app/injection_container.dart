import 'package:get_it/get_it.dart';
import 'package:qcf_quran_plus/qcf_quran_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/onboarding/onboarding_injection.dart';
import '../../features/quran/data/data_source/quran_local_data_source.dart';
import '../../features/quran/quran_injection.dart';
import 'mainapp_injection.dart';

final sl = GetIt.instance;

Future<void> initAppModule() async {
  // External
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // Initializations
  await QuranLocalDataSource.init();

  try {
    await QcfFontLoader.setupFontsAtStartup(onProgress: (progress) {});
  } catch (e) {
    // Log error but continue
  }

  // Feature Modules
  await initMainAppModule();
  initOnboardingInjection();
  initQuranInjection();
}
