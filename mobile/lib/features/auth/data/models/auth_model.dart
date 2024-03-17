import 'package:mobile/features/auth/domain/entities/auth_entitie.dart';

class AuthModel extends AuthEntitie {
  const AuthModel(
      {required super.email,
      required super.password,
      required super.fullName,
      required super.userName,
      required super.birthDate});
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['text'],
      password: json['password'],
      fullName: json['fullName'],
      userName: json['username'],
      birthDate: DateTime.parse(json['birthDate']),
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'username': userName,
      'birthDate': birthDate,
    };
  }
}
