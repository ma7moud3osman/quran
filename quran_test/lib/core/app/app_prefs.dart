import 'package:shared_preferences/shared_preferences.dart';

const String prefsThemeApp = "prefsThemeApp";
const String prefsOnBoardingKey = "prefsOnBoardingKey";
const String prefsIsFirstTimeKey = "prefsIsFirstTimeKey";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);
  
  Future<void> clear() async => await _sharedPreferences.clear();

  Future<void> setThemeApp({required String mode}) async {
    await _sharedPreferences.setString(prefsThemeApp, mode);
  }

  String? getThemeApp() {
    return _sharedPreferences.getString(prefsThemeApp);
  }

  Future<void> toggleIsFirstTimeOpen() =>
      _sharedPreferences.setBool(prefsIsFirstTimeKey, !isFirstTimeOpen);
  
  bool get isFirstTimeOpen =>
      _sharedPreferences.getBool(prefsIsFirstTimeKey) ?? true;

  Future<void> setOnBoarding({required bool isOnBoarding}) async {
    await _sharedPreferences.setBool(prefsOnBoardingKey, isOnBoarding);
  }

  bool? getOnBoarding() {
    return _sharedPreferences.getBool(prefsOnBoardingKey);
  }
}
