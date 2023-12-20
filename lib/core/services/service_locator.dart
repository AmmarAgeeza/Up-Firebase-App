import 'package:get_it/get_it.dart';
import '../../feature/auth/presentation/cubit/auth_cubit.dart';
import '/feature/auth/data/repository/auth_repo.dart';

import '../database/cache/cache_helper.dart';

final sl = GetIt.instance;
void initServiceLoactor() {
  //cubits
sl.registerLazySingleton(() => AuthCubit(sl()));
//feaures
sl.registerLazySingleton(() => AuthRepo());
//external
  sl.registerLazySingleton(() => CacheHelper());
}
