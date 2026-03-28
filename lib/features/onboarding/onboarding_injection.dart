import 'package:get_it/get_it.dart';
import 'data/data_source/onboarding_data_source.dart';
import 'data/repositories/onboarding_repository.dart';
import 'presentation/providers/onboarding_provider.dart';

final sl = GetIt.instance;

void initOnboardingInjection() {
  sl.registerLazySingleton(() => OnboardingDataSource(sl()));
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepository(sl()),
  );
  sl.registerFactory(() => OnboardingProvider(sl()));
}
