import 'package:flutter/material.dart';
import 'calculation_method_screen.dart';
import 'location_permission_screen.dart';
import 'optional_settings_screen.dart';

class OnboardingMainScreen extends StatefulWidget {
  const OnboardingMainScreen({super.key});

  @override
  State<OnboardingMainScreen> createState() => _OnboardingMainScreenState();
}

class _OnboardingMainScreenState extends State<OnboardingMainScreen> {
  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CalculationMethodScreen(onNext: _nextPage),
          LocationPermissionScreen(onNext: _nextPage),
          const OptionalSettingsScreen(),
        ],
      ),
    );
  }
}
