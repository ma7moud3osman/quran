import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_language.dart';
import '../extension/colors_extension.dart';
import '../widgets/show_general_bottom_sheet.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/spacer_widget.dart';

void showLanguageBottomSheet(BuildContext context) {
  final currentLocale = context.locale;

  showGeneralBottomSheet(
    context: context,
    title: 'change_language'.tr(),
    builder: (context) =>
        _AnimatedLanguageSelector(currentLocale: currentLocale),
  );
}

class _AnimatedLanguageSelector extends StatefulWidget {
  final Locale currentLocale;

  const _AnimatedLanguageSelector({required this.currentLocale});

  @override
  State<_AnimatedLanguageSelector> createState() =>
      _AnimatedLanguageSelectorState();
}

class _AnimatedLanguageSelectorState extends State<_AnimatedLanguageSelector> {
  late Locale _selectedLocale;

  @override
  void initState() {
    super.initState();
    _selectedLocale = widget.currentLocale;
  }

  Future<void> _changeLanguage(BuildContext context, Locale newLocale) async {
    if (_selectedLocale == newLocale) {
      Navigator.of(context).pop();
      return;
    }

    setState(() => _selectedLocale = newLocale);

    try {
      await context.setLocale(newLocale);
    } catch (e) {
      debugPrint('Error changing language: $e');
    }

    if (!mounted) return;

    await Future.delayed(const Duration(milliseconds: 120));

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLanguageButton(
          context: context,
          label: 'العربية',
          isSelected: _selectedLocale == ARABIC_LOCAL,
          onTap: () => _changeLanguage(context, ARABIC_LOCAL),
        ),
        VerticalSpacer.large(),
        _buildLanguageButton(
          context: context,
          label: 'English',
          isSelected: _selectedLocale == ENGLISH_LOCAL,
          onTap: () => _changeLanguage(context, ENGLISH_LOCAL),
        ),
      ],
    );
  }

  Widget _buildLanguageButton({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final primary = context.primaryColor;
    final border = context.borderColor;

    return CustomElevatedButton(
      onPressed: onTap,
      backgroundColor: isSelected ? primary : Colors.white,
      borderColor: isSelected ? primary : border,
      textColor: isSelected ? Colors.white : context.titleColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected) ...[
            const SizedBox(width: 8),
            const Icon(Icons.check_circle, color: Colors.white, size: 20),
          ],
        ],
      ),
    );
  }
}
