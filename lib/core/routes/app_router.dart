import 'package:go_router/go_router.dart';
import 'routes_name.dart';
import '../../features/onboarding/presentation/pages/onboarding_main_screen.dart';
import '../../features/quran/presentation/pages/quran_mushaf_screen.dart';
import '../../features/quran/presentation/pages/quran_search_screen.dart';
import '../../features/quran/presentation/pages/quran_surah_list_screen.dart';
import '../../features/quran/presentation/pages/surah_index_screen.dart';
import '../../features/onboarding/presentation/pages/splash_screen.dart';

class AppRouter {
  static GoRouter router(String initialLocation) => GoRouter(
    initialLocation: initialLocation,
    routes: [
      // Onboarding
      GoRoute(
        path: AppPaths.splash,
        name: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppPaths.onboarding,
        name: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingMainScreen(),
      ),

      // Quran
      GoRoute(
        path: AppPaths.quranIndex,
        name: AppRoutes.quranIndex,
        builder: (context, state) => const SurahIndexScreen(),
      ),
      GoRoute(
        path: AppPaths.quranMushaf,
        name: AppRoutes.quranMushaf,
        builder: (context, state) {
          final initialPage = (state.extra as int?) ?? 1;
          return QuranMushafScreen(initialPage: initialPage);
        },
      ),
      GoRoute(
        path: AppPaths.quranSurahList,
        name: AppRoutes.quranSurahList,
        builder: (context, state) {
          final surahNumber = (state.extra as int?) ?? 1;
          return QuranSurahListScreen(surahNumber: surahNumber);
        },
      ),
      GoRoute(
        path: AppPaths.quranSearch,
        name: AppRoutes.quranSearch,
        builder: (context, state) => const QuranSearchScreen(),
      ),
    ],
  );
}
