import 'package:equatable/equatable.dart';

class ProfileEntitie extends Equatable {
  final String name, profileImage;
  const ProfileEntitie({required this.name, required this.profileImage});
  @override
  List<Object?> get props => [name, profileImage];
}
