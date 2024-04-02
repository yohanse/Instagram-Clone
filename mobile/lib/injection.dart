import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mobile/features/auth/data/datasources/local_data_source.dart';
import 'package:mobile/features/auth/data/datasources/remote_data_source.dart';
import 'package:mobile/features/auth/data/repositories/auth_repositorie_impl.dart';
import 'package:mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:mobile/features/auth/domain/usecases/check_confirmation.dart';
import 'package:mobile/features/auth/domain/usecases/check_email_auth.dart';
import 'package:mobile/features/auth/domain/usecases/check_username.dart';
import 'package:mobile/features/auth/domain/usecases/login.dart';
import 'package:mobile/features/auth/domain/usecases/signup.dart';
import 'package:mobile/features/auth/presentation/bloc/check_email/check_email_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/check_confirmation/check_confirmation_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/check_username/check_username_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:mobile/features/auth/presentation/bloc/signup/singup_bloc.dart';
import 'package:mobile/features/common/post/data/datasources/local_data_source.dart';
import 'package:mobile/features/common/post/data/datasources/remote_data_source.dart';
import 'package:mobile/features/common/post/data/repositories/post_repositorie_impl.dart';
import 'package:mobile/features/common/post/domain/repository/post_repository.dart';
import 'package:mobile/features/common/post/domain/usecases/get_all_post.dart';
import 'package:mobile/features/common/presentation/bloc/Image/image_manager_bloc.dart';
import 'package:mobile/features/common/presentation/bloc/IsMultipleSelected/is_multiple_selected_bloc.dart';
import 'package:mobile/features/common/presentation/bloc/post/post_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory(
    () => CheckEmailBloc(
      checkEmail: sl(),
    ),
  );
  sl.registerFactory(() => CheckConfirmationBloc(checkConfirmation: sl()));
  sl.registerFactory(() => CheckUsernameBloc(checkUsernameUsecase: sl()));
  sl.registerFactory(() => SingupBloc(signUpUsecase: sl()));
  sl.registerFactory(() => LoginBloc(logInUsecase: sl()));
  sl.registerFactory(() => PostBloc(getAllPostUseCase: sl()));
  sl.registerFactory(() => ImageManagerBloc());
  sl.registerFactory(() => IsMultipleSelectedBloc());

  //use case
  sl.registerLazySingleton(() => CheckEmailUsecase(authRepository: sl()));
  sl.registerLazySingleton(
      () => CheckConfirmationUsecase(authRepository: sl()));
  sl.registerLazySingleton(() => CheckUsernameUsecase(authRepository: sl()));

  sl.registerLazySingleton(
    () => SignUpUsecase(
      authRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LogInUsecase(
      authRepository: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetAllPostUseCase(postRepository: sl()));

  //Remote Data Source
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      authLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(postLocalDataSource: sl()));

  // Local Data Source
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(prefs: sl()),
  );
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(prefs: sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
      () => PostRepositorieImpl(postRemoteDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositorieImpl(
      authRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
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
