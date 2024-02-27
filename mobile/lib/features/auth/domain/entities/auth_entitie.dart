import 'package:equatable/equatable.dart';

class AuthEntitie extends Equatable {
  final String email, password;
  final String? confirmationNumber, fullName, userName;
  final bool isSave;
  final DateTime? birthDate;
  const AuthEntitie({
    required this.email,
    required this.password,
    required this.isSave,
    this.confirmationNumber,
    this.fullName,
    this.userName,
    this.birthDate,
  });
  @override
  List<Object?> get props => [
        email,
        password,
        confirmationNumber,
        fullName,
        userName,
        isSave,
        birthDate
      ];
}
