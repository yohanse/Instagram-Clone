import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message, [List props = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
  @override
  List<Object?> get props => [];
}

class EmailNotCorrectFailure extends Failure {
  const EmailNotCorrectFailure(super.message);
  @override
  List<Object?> get props => [];
}

class EmailDoesNotExistFaliure extends Failure {
  const EmailDoesNotExistFaliure(super.message);
  @override
  List<Object?> get props => [];
}

class EmailAlreadyExistFaliure extends Failure {
  const EmailAlreadyExistFaliure(super.message);
  @override
  List<Object?> get props => [];
}

class NoTokenFailure extends Failure {
  const NoTokenFailure(super.message);
  @override
  List<Object?> get props => [];
}