import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/app/injection_container.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes_name.dart';
import 'core/theme/theme_provider.dart';
import 'features/onboarding/presentation/providers/onboarding_provider.dart';
import 'features/quran/presentation/providers/quran_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<OnboardingProvider>()),
        ChangeNotifierProvider(create: (_) => sl<QuranProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ThemeProvider>()),
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
    return MaterialApp.router(
      title: 'Jannah',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: context.watch<ThemeProvider>().lightTheme(context),
      darkTheme: context.watch<ThemeProvider>().darkTheme(context),
      themeMode: context.watch<ThemeProvider>().getThemeMode,
      routerConfig: AppRouter.router(AppPaths.splash),
      debugShowCheckedModeBanner: false,
    );
  }
}
