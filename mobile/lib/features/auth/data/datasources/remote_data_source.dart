import '../models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> checkConfirmation({String email, String confimationCode});
  Future<AuthModel> checkEmail({String email});
}
