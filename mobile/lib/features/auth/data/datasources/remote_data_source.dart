import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> checkConfirmation({ required String email, required String confimationCode});
  Future<AuthModel> checkEmail({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  @override
  Future<AuthModel> checkConfirmation({required String email, required String confimationCode}) {
  }

  @override
  Future<AuthModel> checkEmail({required String email}) {
  }

}
