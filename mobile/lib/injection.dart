import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/auth/data/datasources/local_data_source.dart';
import 'package:mobile/features/auth/data/datasources/remote_data_source.dart';
import 'package:mobile/features/auth/data/repositories/auth_repositorie_impl.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:mobile/features/auth/domain/usecases/check_confirmation.dart';
import 'package:mobile/features/auth/domain/usecases/check_email_auth.dart';
import 'package:mobile/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(
    () => AuthBloc(
      checkConfirmation: sl(),
      checkEmail: sl(),
    ),
  );

  //use case
  sl.registerLazySingleton(() => CheckEmail(authRepository: sl()));
  sl.registerLazySingleton(() => CheckConfirmation(authRepository: sl()));
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositorieImpl(
      authLocalDataSource: sl(),
      authRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Respository
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(prefs: sl()),
  );

  //Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  //External
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => SharedPreferences.getInstance());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
