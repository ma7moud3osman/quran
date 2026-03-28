import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/onboarding_settings_model.dart';
import '../../../../core/utils/enums.dart';

class OnboardingDataSource {
  static const String _settingsKey = 'onboarding_settings';
  final SharedPreferences _prefs;

  OnboardingDataSource(this._prefs);

  Future<void> saveSettings(OnboardingSettingsModel settings) async {
    final jsonString = jsonEncode(settings.toJson());
    await _prefs.setString(_settingsKey, jsonString);
  }

  OnboardingSettingsModel getSettings() {
    final jsonString = _prefs.getString(_settingsKey);
    if (jsonString != null) {
      try {
        final Map<String, dynamic> map = jsonDecode(jsonString);
        return OnboardingSettingsModel.fromJson(map);
      } catch (e) {
        // Fallback on error
      }
    }
    // Return default settings if none saved
    return const OnboardingSettingsModel(
      calculationMethod: CalculationMethodEnum.egyptian,
      madhab: MadhabEnum.shafii,
      hijriOffset: 0,
      isComplete: false,
    );
  }

  Future<void> setComplete() async {
    final settings = getSettings();
    final newSettings = settings.copyWith(isComplete: true);
    await saveSettings(newSettings);
  }
}
