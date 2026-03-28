import '../../../../core/utils/repo_result.dart';
import '../models/onboarding_settings_model.dart';
import '../data_source/onboarding_data_source.dart';

class OnboardingRepository extends BaseRepository {
  final OnboardingDataSource _dataSource;

  OnboardingRepository(this._dataSource);

  Future<RepoResult<OnboardingSettingsModel>> getSettings() {
    return execute(() async {
      return _dataSource.getSettings();
    });
  }

  Future<RepoResult<void>> saveSettings(OnboardingSettingsModel settings) {
    return execute(() async {
      await _dataSource.saveSettings(settings);
    });
  }

  Future<RepoResult<void>> completeOnboarding() {
    return execute(() async {
      await _dataSource.setComplete();
    });
  }
}
