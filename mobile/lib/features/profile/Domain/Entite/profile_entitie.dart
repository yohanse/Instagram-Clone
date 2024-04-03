import 'package:equatable/equatable.dart';

class ProfileEntitie extends Equatable {
  final int? user_id;
  final String name, profile_image;
  const ProfileEntitie(
      {required this.user_id, required this.name, required this.profile_image});
  @override
  List<Object?> get props => [];
}