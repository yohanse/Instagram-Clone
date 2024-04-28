part of 'get_single_reel_bloc.dart';

sealed class GetSingleReelState extends Equatable {
  const GetSingleReelState();
  
  @override
  List<Object> get props => [];
}

final class GetSingleReelInitial extends GetSingleReelState {}

class GetSingleReelInProgress extends GetSingleReelState {}

class GetSingleReelSuccess extends GetSingleReelState {
  final ReelEntite reel;

  const GetSingleReelSuccess({required this.reel});

  @override
  List<Object> get props => [reel];
}

class GetSingleReelFailure extends GetSingleReelState {
  final String message;

  const GetSingleReelFailure({required this.message});

  @override
  List<Object> get props => [message];
}
