import 'package:equatable/equatable.dart';

class AuthEntitie extends Equatable {
  final String email, password;
  final String fullName, userName;
  // final bool isSave;
  final DateTime birthDate;
  const AuthEntitie({
    required this.email,
    required this.password,
    required this.fullName,
    required this.userName,
    required this.birthDate,
  });
  @override
  List<Object?> get props => [
        email,
        password,
        fullName,
        userName,
        birthDate
      ];
}
