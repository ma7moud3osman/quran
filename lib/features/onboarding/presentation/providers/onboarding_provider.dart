import 'package:flutter/material.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/repo_result.dart';
import '../../data/models/onboarding_settings_model.dart';
import '../../data/repositories/onboarding_repository.dart';

class OnboardingProvider extends ChangeNotifier {
  final OnboardingRepository _repository;

  OnboardingProvider(this._repository) {
    _loadSettings();
  }

  LoadStatus _status = LoadStatus.initial;
  LoadStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  OnboardingSettingsModel _settings = OnboardingSettingsModel.fake();
  OnboardingSettingsModel get settings => _settings;

  Future<void> _loadSettings() async {
    _status = LoadStatus.loading;
    notifyListeners();

    final result = await _repository.getSettings();
    if (result is RepoSuccess<OnboardingSettingsModel>) {
      _settings = result.data;
      _status = LoadStatus.success;
    } else if (result is RepoFailure) {
      _errorMessage = (result as RepoFailure).message;
      _status = LoadStatus.failure;
    }
    notifyListeners();
  }

  void updateCalculationMethod(CalculationMethodEnum method) {
    _settings = _settings.copyWith(calculationMethod: method);
    notifyListeners();
  }

  void updateMadhab(MadhabEnum madhab) {
    _settings = _settings.copyWith(madhab: madhab);
    notifyListeners();
  }

  void updateHijriOffset(int offset) {
    _settings = _settings.copyWith(hijriOffset: offset);
    notifyListeners();
  }

  void updateLocation(double lat, double lng, String city) {
    _settings = _settings.copyWith(
      latitude: lat,
      longitude: lng,
      cityName: city,
    );
    notifyListeners();
  }

  Future<void> saveAndComplete() async {
    _status = LoadStatus.loading;
    notifyListeners();

    final newSettings = _settings.copyWith(isComplete: true);
    final result = await _repository.saveSettings(newSettings);

    if (result is RepoSuccess<void>) {
      _settings = newSettings;
      _status = LoadStatus.success;
    } else if (result is RepoFailure) {
      _errorMessage = result.message;
      _status = LoadStatus.failure;
    }
    notifyListeners();
  }
}
