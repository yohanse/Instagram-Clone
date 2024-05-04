part of 'add_reel_bloc.dart';

sealed class AddReelState extends Equatable {
  const AddReelState();
  
  @override
  List<Object> get props => [];
}

final class AddReelInitial extends AddReelState {}

final class AddReelLoading extends AddReelState {}

final class AddReelSuccess extends AddReelState {
  final ReelEntite reelEntite;
  const AddReelSuccess({required this.reelEntite});
  
  @override
  List<Object> get props => [reelEntite];
}

final class AddReelError extends AddReelState {
  final String message;
  const AddReelError({required this.message});
  
  @override
  List<Object> get props => [message];
}
