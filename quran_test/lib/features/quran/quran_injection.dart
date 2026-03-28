import 'package:get_it/get_it.dart';
import 'data/data_source/quran_local_data_source.dart';
import 'data/repositories/quran_repository.dart';
import 'presentation/providers/quran_provider.dart';

final sl = GetIt.instance;

void initQuranInjection() {
  // Data Source
  sl.registerLazySingleton(() => QuranLocalDataSource(sl()));

  // Repository
  sl.registerLazySingleton<QuranRepository>(() => QuranRepository(sl()));

  // Provider
  sl.registerFactory(() => QuranProvider(sl()));
}
