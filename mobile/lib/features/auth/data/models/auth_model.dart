import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';

class AuthModel extends AuthEntitie {
  const AuthModel(
      {required super.email, required super.password, required super.isSave});
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
        email: json['text'],
        password: json['password'],
        isSave: json['isSave']);
  }

  Map<String, dynamic> tojson() {
    return {'email': email, 'password': password, 'isSave': isSave};
  }
}
