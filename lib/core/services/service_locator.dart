import 'package:get_it/get_it.dart';
import 'package:test_firebase/feature/home/data/repo/home_repo.dart';
import '/feature/auth/data/repository/auth_repo.dart';
import '/feature/auth/presentation/cubit/auth_cubit.dart';

import '../database/cache/cache_helper.dart';

final sl = GetIt.instance;
void initServiceLoactor() {
  //cubits
sl.registerLazySingleton(() => AuthCubit(sl()));
//feaures
sl.registerLazySingleton(() => AuthRepo());
sl.registerLazySingleton(() => HomeRepo());
//external
  sl.registerLazySingleton(() => CacheHelper());
}
