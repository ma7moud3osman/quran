import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:quran_test/core/constants/app_constants.dart';

import 'core/routes/app_router.dart';
import 'core/routes/routes_name.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/presentation/providers/onboarding_provider.dart';
import 'features/quran/presentation/providers/quran_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sl = GetIt.instance;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<OnboardingProvider>()),
        ChangeNotifierProvider(create: (_) => sl<QuranProvider>()),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar', 'SA'),
        startLocale: const Locale('ar', 'SA'),
        child: const _MaterialApp(),
      ),
    );
  }
}

class _MaterialApp extends StatelessWidget {
  const _MaterialApp();

  @override
  Widget build(BuildContext context) {
    final onboardingProvider = context.read<OnboardingProvider>();
    final initialRoute = onboardingProvider.settings.isComplete
        ? AppPaths.quranIndex
        : AppPaths.onboarding;

    return MaterialApp.router(
      title: AppConstants.appName,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router(initialRoute),
      debugShowCheckedModeBanner: false,
    );
  }
}
