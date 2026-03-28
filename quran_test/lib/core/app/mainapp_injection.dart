import 'package:shared_preferences/shared_preferences.dart';
import 'app_prefs.dart';
import 'injection_container.dart';

import '../theme/theme_provider.dart';

Future<void> initMainAppModule() async {
  // app prefs instance
  sl.registerLazySingleton<AppPreferences>(
    () => AppPreferences(sl<SharedPreferences>()),
  );

  // Theme Provider
  sl.registerFactory(() => ThemeProvider());
}
