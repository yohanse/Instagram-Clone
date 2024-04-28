part of 'get_single_reel_bloc.dart';

sealed class GetSingleReelState extends Equatable {
  const GetSingleReelState();
  
  @override
  List<Object> get props => [];
}

final class GetSingleReelInitial extends GetSingleReelState {}
