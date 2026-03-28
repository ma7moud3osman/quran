import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/extension/go_router_extension.dart';
import '../../../../core/routes/routes_name.dart';
import '../providers/onboarding_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startAnimation();
    _navigateToNext();
  }

  Future<void> _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        _opacity = 1.0;
      });
    }
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    final provider = context.read<OnboardingProvider>();
    if (provider.settings.isComplete) {
      context.goToNamed(AppRoutes.quranIndex);
    } else {
      context.goToNamed(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF004D40), // Dark Teal
              Color(0xFF002420), // Deeper Teal
            ],
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: const Duration(seconds: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 200, height: 200),
                const SizedBox(height: 24),
                const CircularProgressIndicator(
                  color: Color(0xFFFFD700), // Gold
                  strokeWidth: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
