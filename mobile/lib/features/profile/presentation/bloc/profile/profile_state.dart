part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final String name, profileImage;
  const ProfileLoadedState({required this.name, required this.profileImage});
}

class ProfileErrorState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}


